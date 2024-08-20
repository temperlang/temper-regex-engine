
local fun = {}
local function unlistof(list, arr)
    if #list ~= 0 then
        arr[#arr + 1] = list[1]
        return unlistof(list[2], arr)
    else
        return arr
    end
end
local function fun_unlist(list)
    return unlistof(list, {})
end
local function fun_joinlist(arr)
    return table.concat(fun_unlist(arr))
end
local parser_pos = 1
local parser_line = 2
local parser_col = 3
local parser_src = 4
local parser_best = 5
local best_pos = 1
local best_line = 2
local best_col = 3
local function parser_new(src)
    return { 1, 1, 1, src, { 0, 1, 1 } }
end
local function parser_advance(state, chr)
    local best = state[parser_best]
    if best[best_pos] < state[parser_pos] then
        best[best_pos] = state[parser_pos]
        best[best_line] = state[parser_line]
        best[best_col] = state[parser_col]
    end
    if chr == '\n' then
        return { state[parser_pos] + 1, state[parser_line] + 1, 1, state[parser_src], best }
    else
        return { state[parser_pos] + 1, state[parser_line], state[parser_col] + 1, state[parser_src], best }
    end
end
local function parser_any(state, ok, err)
    if state[parser_pos] <= string.len(state[parser_src]) then
        local chr = string.sub(state[parser_src], state[parser_pos], state[parser_pos])
        return ok(parser_advance(state, chr), chr)
    else
        return err(state, 'unexpected: end of file')
    end
end
local function parser_eof(state, ok, err)
    if state[parser_pos] > string.len(state[parser_src]) then
        return ok(state, nil)
    else
        return err(state, 'wanted the file to end (Ln ' .. state[parser_best][best_line] .. ', Col ' .. state[parser_best][best_col] .. ')')
    end
end
local function parser_accept(value)
    return function(state, ok, err)
        return ok(state, value)
    end
end
local function parser_cond(next, xcond)
    return function(state, ok, err)
        return next(state, function(state, data)
            if xcond(data) then
                return ok(state, data)
            else
                return err(state, 'cannot match')
            end
        end, function(state, msg)
            return err(state, msg)
        end)
    end
end
local function parser_exact(char)
    return function(state, ok, err)
        if state[parser_pos] <= string.len(state[parser_src]) then
            local chr = string.sub(state[parser_src], state[parser_pos], state[parser_pos])
            if chr == char then
                return ok(parser_advance(state, chr), chr)
            else
                return err(state, 'cannot match')
            end
        else
            return err(state, 'unexpected: end of file')
        end
    end
end
local function parser_notexact(char)
    return function(state, ok, err)
        if state[parser_pos] <= string.len(state[parser_src]) then
            local chr = string.sub(state[parser_src], state[parser_pos], state[parser_pos])
            if chr ~= char then
                return ok(parser_advance(state, chr), chr)
            else
                return err(state, 'cannot match')
            end
        else
            return err(state, 'unexpected: end of file')
        end
    end
end
local function parser_range(low, high)
    local low_byte = string.byte(low)
    local high_byte = string.byte(high)
    return function(state, ok, err)
        if state[parser_pos] <= string.len(state[parser_src]) then
            local chr = string.sub(state[parser_src], state[parser_pos], state[parser_pos])
            local byte = string.byte(chr)
            if low_byte <= byte and byte <= high_byte then
                return ok(parser_advance(state, chr), chr)
            else
                return err(state, 'cannot match range')
            end
        else
            return err(state, 'unexpected: end of file')
        end
    end
end
local function parser_first(...)
    local function more(opts, start)
        local first = opts[start]
        if start >= #opts then
            return first
        end
        local fnext = more(opts, start + 1)
        return function(state, ok, err)
            return first(state, ok, function(state2, msg1)
                return fnext(state, ok, function(state, msg2)
                    return err(state, 'cannot match either')
                end)
            end)
        end
    end
    return more({ ... }, 1)
end
local function parser_transform(xnext, func)
    return function(state, ok, err)
        return xnext(state, function(state, data)
            return ok(state, func(data))
        end, err)
    end
end
local function parser_cons(parse1, parse2)
    return function(state, ok, err)
        return parse1(state, function(state, data1)
            return parse2(state, function(state, data2)
                return ok(state, { data1, data2 })
            end, err)
        end, err)
    end
end
local function parser_list0(next)
    local rest = nil
    local function more(state, ok, err)
        return rest(state, ok, function(state2, msg)
            return ok(state, {})
        end)
    end
    rest = parser_cons(next, more)
    return more
end
local function parser_list1(next)
    return parser_cons(next, parser_list0(next))
end
local function parser_skiponly(skip, read)
    return parser_transform(parser_cons(skip, read), function(data)
        return data[2]
    end)
end
local function parser_skips(skip, read)
    return parser_skiponly(parser_list0(skip), read)
end
local function parser_string(str)
    local ret = parser_accept({})
    local len = string.len(str)
    for i=0, len - 1 do
        ret = parser_cons(parser_exact(string.sub(str, len - i, len - i)), ret)
    end
    return parser_transform(ret, fun_joinlist)
end
local function parser_listof(...)
    local tab = { ... }
    local function more(head)
        local cur = tab[head]
        if cur == nil then
            return parser_accept({})
        else
            return parser_cons(cur, more(head + 1))
        end
    end
    return more(1)
end
local function parser_select(n, ...)
    return parser_transform(parser_listof(...), function(data)
        for i=2, n do
            data = data[2]
        end
        return data[1]
    end)
end
local function parser_sep1(lis, sep)
    return parser_cons(lis, parser_list0(parser_select(2, sep, lis)))
end
local function parser_sep(lis, sep)
    return parser_first(parser_sep1(lis, sep), parser_accept({}))
end
local function aststr(ast)
    if type(ast) ~= 'table' then
        return tostring(ast)
    elseif ast.type ~= nil then
        local tab = {}
        tab[#tab + 1] = '('
        tab[#tab + 1] = ast.type
        for i=1, #ast do
            tab[#tab + 1] = ' '
            tab[#tab + 1] = aststr(ast[i])
        end
        tab[#tab + 1] = ')'
        return table.concat(tab)
    else
        local tab = {}
        tab[#tab + 1] = '{'
        for i=1, #ast do
            tab[#tab + 1] = ' '
            tab[#tab + 1] = aststr(ast[i])
        end
        tab[#tab + 1] = '}'
        return table.concat(tab)
    end
end
local lua = {}
lua.comment = parser_listof(parser_string('--'), parser_list0(parser_notexact('\n')))
lua.ws = parser_list0(parser_first(parser_exact(' '), parser_exact('\n'), parser_exact('\t'), parser_exact('\r'), lua.comment))
function lua.wrap(par)
    return parser_select(2, lua.ws, par, lua.ws)
end
local function makeast(type, pos, ...)
    local ret = { type = type, pos = pos, ... }
    setmetatable(ret, { __tostring = aststr })
    return ret
end
function lua.ast(ast, ...)
    local next = lua.wrap(parser_listof(...))
    return function(state1, ok, err)
        return next(state1, function(state2, data1)
            local head = { line = state1.line, col = state1.col }
            local tail = { line = state2.line, col = state2.col }
            local pos = { head = head, tail = tail }
            local data2 = makeast(ast, pos)
            local datarr = fun_unlist(data1)
            for i=1, #datarr do
                local val = datarr[i]
                if type(val) == 'table' and val.expand then
                    for i=1, #val do
                        data2[#data2 + 1] = val[i]
                    end
                elseif type(val) ~= 'table' or not val.ignore then
                    data2[#data2 + 1] = val
                end
            end
            return ok(state2, data2)
        end, function(state, msg)
            return err(state, msg)
        end)
    end
end
function lua.delay(name)
    return function(state, ok, err)
        return lua[name](state, ok, err)
    end
end
function lua.ignore(par)
    return parser_transform(par, function(data)
        return { ignore = true }
    end)
end
function lua.maybe(par)
    return parser_first(par, parser_accept({ ignore = true }))
end
local astlist = function(arg)
    local res = fun_unlist(arg)
    res.expand = true
    return res
end
local keywords = { 'not', 'break', 'if', 'elseif', 'else', 'then', 'while', 'do', 'local', 'end', 'function', 'repeat', 'until', 'return', 'then', 'nil', 'true', 'false', 'in', 'for' }
local hashkeywords = {}
for i=1, #keywords do
    hashkeywords[keywords[i]] = keywords[i]
end
local function isident(id)
    return hashkeywords[id] == nil
end
local function iskeyword(id)
    return hashkeywords[id] ~= nil
end
function lua.keyword(name)
    return lua.ignore(lua.wrap(parser_cond(parser_string(name), iskeyword)))
end
function lua.keywordliteral(name)
    return parser_cond(parser_string(name), iskeyword)
end
function lua.binop(child, names)
    local ops = parser_string(names[1])
    for i=2, #names do
        ops = parser_first(ops, parser_string(names[i]))
    end
    ops = lua.wrap(ops)
    return parser_transform(lua.wrap(parser_cons(child, parser_list0(parser_cons(ops, child)))), function(data)
        local lhs = data[1]
        local rhs = fun_unlist(data[2])
        for i=1, #rhs do
            local ent = rhs[i]
            local pos = { head = lhs.pos.head, tail = ent[2].pos.tail }
            lhs = makeast(ent[1], pos, lhs, ent[2])
        end
        return lhs
    end)
end
lua.lowerletter = parser_range('a', 'z')
lua.upperletter = parser_range('A', 'Z')
lua.digit = parser_range('0', '9')
lua.letter = parser_first(lua.lowerletter, lua.upperletter)
lua.digits = parser_cond(parser_transform(parser_list1(parser_first(lua.digit, parser_exact('.'))), fun_joinlist), function(s)
    local dots = 0
    for i=1, string.len(s) do
        if string.sub(s, i, i) == '.' then
            dots = dots + 1
        end
    end
    return dots <= 1
end)
lua.name = parser_transform(parser_cons(parser_first(lua.letter, parser_exact('_')), parser_list0(parser_first(lua.digit, lua.letter, parser_exact('_')))), fun_joinlist)
local function stringbody(wrap)
    return parser_transform(parser_select(2, parser_string(wrap), parser_list0(parser_first(parser_transform(parser_listof(parser_exact('\\'), parser_any), fun_joinlist), parser_notexact(wrap))), parser_exact(wrap)), fun_joinlist)
end
lua.dstring = lua.ast('dstring', stringbody('"'))
lua.sstring = lua.ast('sstring', stringbody('\''))
lua.string = parser_first(lua.dstring, lua.sstring)
lua.expr = lua.delay('expr')
lua.chunk = lua.delay('chunk')
lua.varargs = lua.ast('varargs', lua.ignore(parser_string('...')))
lua.literal = lua.ast('literal', parser_first(lua.varargs, lua.keywordliteral('nil'), lua.keywordliteral('false'), lua.keywordliteral('true')))
lua.number = lua.ast('number', lua.digits)
lua.ident = lua.ast('ident', parser_cond(lua.name, isident))
lua.params = lua.ast('params', lua.ignore(parser_exact('(')), parser_transform(parser_sep(parser_first(lua.varargs, lua.ident), parser_exact(',')), astlist), lua.ignore(parser_exact(')')))
lua.fieldnamed = lua.ast('fieldnamed', lua.ident, lua.ignore(parser_exact('=')), lua.expr)
lua.fieldnth = lua.ast('fieldnth', lua.expr)
lua.fieldvalue = lua.ast('fieldvalue', lua.ignore(parser_exact('[')), lua.expr, parser_exact(']'), lua.ignore(parser_exact('=')), lua.expr)
lua.field = parser_first(lua.fieldnamed, lua.fieldnth, lua.fieldvalue)
lua.table = lua.ast('table', lua.ignore(parser_exact('{')), lua.ignore(lua.ws), parser_transform(parser_sep(lua.field, parser_exact(',')), astlist), lua.ignore(parser_exact('}')))
lua.lambda = lua.ast('lambda', lua.keyword('function'), lua.params, lua.chunk, lua.keyword('end'))
lua.parens = parser_select(2, parser_exact('('), lua.expr, parser_exact(')'))
lua.single = parser_first(lua.string, lua.number, lua.lambda, lua.ident, lua.table, lua.literal, lua.parens)
lua.args = parser_first(lua.ast('call', lua.string), lua.ast('call', lua.table), lua.ast('call', lua.ignore(parser_exact('(')), parser_transform(parser_sep(lua.expr, lua.wrap(parser_exact(','))), astlist), lua.ignore(parser_exact(')'))))
lua.index = lua.ast('index', lua.ignore(parser_exact('[')), lua.expr, lua.ignore(parser_exact(']')))
lua.dotindex = lua.ast('dotindex', lua.ignore(parser_exact('.')), lua.ident)
lua.methodcall = lua.ast('method', lua.ignore(parser_exact(':')), lua.ident, lua.args)
lua.postext = parser_first(lua.args, lua.index, lua.dotindex, lua.methodcall)
lua.post = lua.ast('postfix', lua.single, parser_transform(parser_list0(lua.postext), astlist))
lua.pre = parser_first(lua.ast('length', lua.ignore(parser_exact('#')), lua.post), lua.ast('negate', lua.ignore(parser_exact('-')), lua.post), lua.ast('not', lua.keyword('not'), lua.post), lua.post)
lua.powexpr = lua.binop(lua.pre, { '^' })
lua.mulexpr = lua.binop(lua.powexpr, { '*', '/', '%' })
lua.addexpr = lua.binop(lua.mulexpr, { '+', '-' })
lua.catexpr = lua.binop(lua.addexpr, { '..' })
lua.compare = lua.binop(lua.catexpr, { '<=', '>=', '==', '~=', '<', '>' })
lua.logic = lua.binop(lua.compare, { 'and', 'or' })
lua.expr = lua.logic
lua.post1 = lua.ast('postfix', lua.single, parser_transform(parser_list1(lua.postext), astlist))
lua.idents = lua.ast('to', parser_transform(parser_sep1(lua.ident, parser_exact(',')), astlist))
lua.exprs = lua.ast('from', parser_transform(parser_sep1(lua.expr, parser_exact(',')), astlist))
lua.posts = lua.ast('to', parser_transform(parser_sep1(lua.post, parser_exact(',')), astlist))
lua.stmtlocalfunction = lua.ast('local', lua.keyword('local'), lua.keyword('function'), lua.ident, lua.ast('lambda', lua.params, lua.chunk), lua.keyword('end'))
lua.assigns = lua.ast('assign', lua.posts, lua.ignore(parser_exact('=')), lua.exprs)
lua.stmtlocal = lua.ast('local', lua.keyword('local'), lua.idents, lua.maybe(parser_select(2, parser_exact('='), lua.exprs)))
lua.ifelse = lua.ast('else', lua.keyword('else'), lua.chunk)
lua.ifelseif = lua.ast('case', lua.keyword('elseif'), lua.expr, lua.keyword('then'), lua.chunk)
lua.ifelseifs = parser_transform(parser_list0(lua.ifelseif), astlist)
lua.stmtif = lua.ast('cond', lua.keyword('if'), lua.ast('case', lua.expr, lua.keyword('then'), lua.chunk), lua.ifelseifs, lua.maybe(lua.ifelse), lua.keyword('end'))
lua.stmtwhile = lua.ast('while', lua.keyword('while'), lua.expr, lua.keyword('do'), lua.chunk, lua.keyword('end'))
lua.stmtfunction = lua.ast('function', lua.keyword('function'), lua.post1, lua.chunk, lua.keyword('end'))
lua.stmtfor = lua.ast('for', lua.keyword('for'), lua.ident, lua.ignore(parser_exact('=')), lua.expr, lua.ignore(parser_exact(',')), lua.expr, lua.maybe(parser_select(2, parser_exact(','), lua.expr)), lua.keyword('do'), lua.chunk, lua.keyword('end'))
lua.stmtforin = lua.ast('forin', lua.keyword('for'), lua.idents, lua.keyword('in'), lua.exprs, lua.keyword('do'), lua.chunk, lua.keyword('end'))
lua.stmtdo = lua.ast('do', lua.keyword('do'), lua.chunk, lua.keyword('end'))
lua.stmtbreak = lua.ast('break', lua.keyword('break'))
lua.stmtgoto = lua.ast('goto', parser_string('goto '), lua.ident)
lua.stmtlabel = lua.ast('label', lua.ignore(parser_string('::')), lua.ignore(lua.ws), lua.ident, lua.ignore(lua.ws), lua.ignore(parser_string('::')))
lua.stmt = parser_first(lua.stmtlabel, lua.stmtgoto, lua.stmtbreak, lua.stmtif, lua.stmtforin, lua.stmtfor, lua.stmtlocalfunction, lua.stmtlocal, lua.stmtwhile, lua.stmtfunction, lua.assigns, lua.post1, lua.stmtdo)
lua.stmtreturn = lua.ast('return', lua.keyword('return'), parser_first(lua.exprs, parser_listof()))
lua.stmtlast = parser_first(lua.stmtgoto, lua.stmtreturn)
lua.chunk = lua.ast('begin', parser_transform(parser_list0(parser_first(lua.stmt, parser_exact(';'))), astlist), lua.maybe(lua.stmtlast), lua.ignore(parser_list0(parser_exact(';'))))
lua.langline = parser_listof(parser_exact('#'), parser_list0(parser_notexact('\n')))
lua.program = lua.ast('program', lua.ignore(lua.ws), lua.ignore(lua.maybe(lua.langline)), lua.chunk, lua.ignore(parser_eof))
local function parse(par, str)
    local ret = {}
    local state = parser_new(str)
    par(state, function(state, data)
        ret.ok = true
        ret.ast = data
    end, function(state, msg)
        ret.ok = false
        ret.msg = msg
    end)
    return ret
end
local function slurp(filename)
    local f = io.open(filename)
    local r = f:read('*all')
    f:close()
    return r
end
local function dump(name, data)
    local val = io.open(name, "w")
    val:write(data)
    val:close()
end
local tab = '  '
local space = ' '
local minify = false
local newline = true
local function indent(str)
    local len = string.len(str)
    local ret = {}
    for i=1, len do
        local c = string.sub(str, i, i)
        ret[#ret + 1] = c
        if c == '\n' then
            ret[#ret + 1] = tab
        end
    end
    return table.concat(ret)
end
local ops = {}
ops['^'] = 0
ops['*'] = 1
ops['/'] = 1
ops['%'] = 1
ops['..'] = 2
ops['+'] = 2
ops['-'] = 2
ops['=='] = 3
ops['~='] = 3
ops['<'] = 3
ops['>'] = 3
ops['<='] = 3
ops['>='] = 3
ops['and'] = 4
ops['or'] = 4

local function pure_symbol_head(n)
    if n < 26 then
        return string.char(n + 97)
    elseif n < 52 then
        return string.char(n - 26 + 65)
    end
end

local function pure_symbol_body(n)
    if n < 26 then
        return string.char(n + 97)
    elseif n < 52 then
        return string.char(n - 26 + 65)
    elseif n < 62 then
        return string.char(n - 52 + 48)
    else
        n = n - 62
        return pure_symbol_body(n % 62) .. pure_symbol_body(math.floor(n / 62)) 
    end
end

local function pure_symbol(n)
    local head = pure_symbol_head(n % 52)
    if n < 52 then
        return head
    else
        n = n - 52
        return head .. pure_symbol_body(math.floor(n / 52))
    end
end

local local_maps = {}
local local_gotos = {}

local keywords = {'and', 'break', 'do', 'else', 'elseif', 'end', 'false', 'for', 'function', 'if', 'in', 'local', 'nil', 'not', 'or', 'repeat', 'return', 'then', 'true', 'until', 'while'}
for i=1, #keywords do
    local keyword = keywords[i]
    local_maps[keyword] = {
        src = keyword
    }
end

local local_maps_start = #local_maps

local function check_symbol(sym)
    if local_maps[sym] then
        return sym .. '_'
    else
        return sym
    end
end

local function symbol(n)
    return check_symbol(pure_symbol(n))
end

local function on_enter()
    local state = {}

    state.len = #local_maps

    return state
end

local function on_exit(state)
    for i=state.len+1, #local_maps do
        local_maps[local_maps[i].src] = nil
        local_maps[i] = nil
    end
end

local function on_local(arg)
    local src = arg
    while type(src) == 'table' do
        if src.type == 'postfix' then
            src = src[#src-1]
        elseif src.type == 'ident' then
            src = src[1]
        else
            break
        end
    end
    if type(src) ~= 'string' then
        return error(tostring(arg))
    end
    local dest
    if minify then 
        dest = symbol(#local_maps-local_maps_start)
    else
        dest = src
    end
    local_maps[#local_maps + 1] = {
        src = src,
        dest = dest
    }
    local_maps[src] = dest
end

local function on_ident(src)
    local got = local_maps[src]
    if got ~= nil then
        return got
    end
    error('not found: ' .. src)
end

local function on_label_str(src)
    if local_gotos[src] == nil then
        local dest
        if minify then 
            dest = symbol(#local_gotos)
        else
            dest = src
        end
        local_gotos[#local_gotos + 1] = {
            src = src,
            dest = dest
        }
        local_gotos[src] = dest
    end
    return local_gotos[src]
end

local function on_goto_str(src)
    if local_gotos[src] == nil then
        return on_label_str(src)
    end
    return local_gotos[src]
end

local function builder(ast)
    local t = ast.type
    if t == 'program' then
        local scope = on_enter()
        for key in pairs(_G) do
            local_maps[#local_maps+1] = {
                src = key,
                dest = key,
            }
            local_maps[key] = key
        end
        local_maps_start = #local_maps
        local ret = builder(ast[1]) .. '\n'
        on_exit(scope)
        return string.sub(ret, 2)
    elseif t == 'begin' then
        local r = {}
        for i=1, #ast do
            if ast[i] ~= ';' then
                if newline then
                    r[#r + 1] = '\n'
                else
                    r[#r + 1] = ' '
                end
                r[#r + 1] = builder(ast[i])
            end
        end
        return table.concat(r)
    elseif t == 'local' or t == 'assign' then
        local r = {}
        if ast[1].type == 'ident' then
            r[#r + 1] = 'local function '
            r[#r + 1] = builder(ast[1])
            local state = on_enter()
            r[#r + 1] = builder(ast[2][1])
            on_local(ast[1])
            r[#r + 1] = indent(builder(ast[2][2]))
            if newline then
                r[#r + 1] = '\n'
            else
                r[#r + 1] = ' '
            end
            on_exit(state)
            r[#r + 1] = 'end'
            on_local(ast[1])
        else
            if t == 'local' then
                r[#r + 1] = 'local'
                for i=1, #ast[1] do
                    if i ~= 1 then
                        r[#r + 1] = ',' .. space
                    else
                        r[#r + 1] = ' '
                    end
                    on_local(ast[1][i])
                    r[#r + 1] = builder(ast[1][i])
                end
            else
                for i=1, #ast[1] do
                    if i ~= 1 then
                        r[#r + 1] = ',' .. space
                    end
                    r[#r + 1] = builder(ast[1][i])
                end
            end
            if ast[2] ~= nil then
                r[#r + 1] = space .. '=' .. space
                for i=1, #ast[2] do
                    if i ~= 1 then
                        r[#r + 1] = ',' .. space
                    end
                    r[#r + 1] = builder(ast[2][i])
                end
            end
        end
        return table.concat(r, '')
    elseif t == 'postfix' then
        local r = {}
        r[#r + 1] = builder(ast[1])
        for i=2, #ast do
            r[#r + 1] = builder(ast[i])
        end
        return table.concat(r)
    elseif t == 'function' then
        local r = {}
        r[#r + 1] = 'function '
        r[#r + 1] = builder(ast[1])
        local state = on_enter()
        r[#r + 1] = indent(builder(ast[2]))
        if newline then
            r[#r + 1] = '\n'
        else
            r[#r + 1] = ' '
        end
        on_exit(state)
        r[#r + 1] = 'end'
        return table.concat(r)
    elseif t == 'lambda' then
        local r = {}
        r[#r + 1] = 'function'
        r[#r + 1] = builder(ast[1])
        local state = on_enter()
        r[#r + 1] = indent(builder(ast[2]))
        if newline then
            r[#r + 1] = '\n'
        else
            r[#r + 1] = ' '
        end
        on_exit(state)
        r[#r + 1] = 'end'
        return table.concat(r)
    elseif t == 'method' then
        return ':' .. ast[1][1] .. builder(ast[2])
    elseif t == 'dotindex' then
        return '.' .. ast[1][1]
    elseif t == 'call' or t == 'params' then
        local r = {}
        r[#r + 1] = '('
        for i=1, #ast do
            if i ~= 1 then
                r[#r + 1] = ',' .. space
            end
            if t == 'params' then
                on_local(ast[i])
            end
            r[#r + 1] = builder(ast[i])
        end
        r[#r + 1] = ')'
        return table.concat(r)
    elseif t == 'do' then
        local r = {}
        r[#r + 1] = 'do'
        local state = on_enter()
        r[#r + 1] = indent(builder(ast[1]))
        if newline then
            r[#r + 1] = '\n'
        else
            r[#r + 1] = ' '
        end
        on_exit(state)
        r[#r + 1] = 'end'
        return table.concat(r)
    elseif t == 'for' then
        local r = {}
        r[#r + 1] = 'for '
        local state = on_enter()
        r[#r + 1] = builder(ast[1])
        r[#r + 1] = '='
        r[#r + 1] = builder(ast[2])
        for i=3, #ast - 1 do
            r[#r + 1] = ',' .. space
            r[#r + 1] = builder(ast[i])
        end
        r[#r + 1] = ' do'
        r[#r + 1] = indent(builder(ast[#ast]))
        if newline then
            r[#r + 1] = '\n'
        else
            r[#r + 1] = ' '
        end
        on_exit(state)
        r[#r + 1] = 'end'
        return table.concat(r)
    elseif t == 'while' then
        local r = {}
        r[#r + 1] = 'while '
        local state = on_enter()
        r[#r + 1] = builder(ast[1])
        r[#r + 1] = ' do'
        r[#r + 1] = indent(builder(ast[2]))
        if newline then
            r[#r + 1] = '\n'
        else
            r[#r + 1] = ' '
        end
        on_exit(state)
        r[#r + 1] = 'end'
        return table.concat(r)
    elseif t == 'cond' then
        local r = {}
        r[#r + 1] = 'if'
        r[#r + 1] = ' '
        r[#r + 1] = builder(ast[1][1])
        r[#r + 1] = ' '
        r[#r + 1] = 'then'
        local state = on_enter()
        r[#r + 1] = indent(builder(ast[1][2]))
        if newline then
            r[#r + 1] = '\n'
        else
            r[#r + 1] = ' '
        end
        on_exit(state)
        for i=2, #ast do
            if ast[i].type == 'else' then
                r[#r + 1] = 'else'
                local state = on_enter()
                r[#r + 1] = indent(builder(ast[i][1]))
                if newline then
                    r[#r + 1] = '\n'
                else
                    r[#r + 1] = ' '
                end
                on_exit(state)
            else
                r[#r + 1] = 'elseif'
                r[#r + 1] = ' '
                r[#r + 1] = builder(ast[i][1])
                r[#r + 1] = ' '
                r[#r + 1] = 'then'
                local state = on_enter()
                r[#r + 1] = indent(builder(ast[i][2]))
                if newline then
                    r[#r + 1] = '\n'
                else
                    r[#r + 1] = ' '
                end
                on_exit(state)
            end
        end
        r[#r + 1] = 'end'
        return table.concat(r)
    elseif t == 'return' then
        local r = { 'return' }
        for i=1, #ast[1] do
            if i ~= 1 then
                r[#r + 1] = ',' .. space
            else
                r[#r + 1] = ' '
            end
            r[#r + 1] = builder(ast[1][i])
        end
        return table.concat(r)
    elseif t == 'label' then
        on_local(ast[1])
        return '::' .. on_label_str(ast[1][1]) .. '::'
    elseif t == 'goto' then
        return 'goto ' .. on_goto_str(ast[2][1])
    elseif t == 'break' then
        return 'break'
    elseif t == 'number' then
        return tostring(ast[1])
    elseif t == 'sstring' then
        local r = {}
        r[#r + 1] = '\''
        r[#r + 1] = ast[1]
        r[#r + 1] = '\''
        return table.concat(r)
    elseif t == 'dstring' then
        local r = {}
        r[#r + 1] = '\"'
        r[#r + 1] = ast[1]
        r[#r + 1] = '\"'
        return table.concat(r)
    elseif t == 'table' then
        local r = {}
        r[#r + 1] = '{'
        for i=1, #ast do
            if i ~= 1 then
                r[#r + 1] = ',' .. space
            else
                r[#r + 1] = ' '
            end
            if ast[i].type == 'fieldnth' then
                r[#r + 1] = builder(ast[i][1])
            elseif ast[i].type == 'fieldnamed' then
                r[#r + 1] = builder(ast[i][1])
                r[#r + 1] = space .. '=' .. space
                r[#r + 1] = builder(ast[i][2])
            else
                r[#r + 1] = builder(ast[i])
            end
        end
        if #ast ~= 0 then
            r[#r + 1] = ' '
        end
        r[#r + 1] = '}'
        return table.concat(r)
    elseif t == 'ident' then
        return on_ident(ast[1])
    elseif t == 'varargs' then
        return '...'
    elseif t == 'literal' then
        if type(ast[1]) == 'table' and ast[1].type == 'varargs' then
            return '...'
        end
        return ast[1]
    elseif t == 'index' then
        local r = {}
        r[#r + 1] = '['
        r[#r + 1] = builder(ast[1])
        r[#r + 1] = ']'
        return table.concat(r)
    elseif t == 'not' or t == 'length' or t == 'negate' then
        local v1 = ast[1]
        if v1.type == 'postfix' and #v1 == 1 then
            v1 = v1[1]
        end
        local r = {}
        if t == 'not' then
            r[#r + 1] = 'not'
            if not ops[v1.type] then
                r[#r + 1] = ' '
            end
        elseif t == 'negate' then
            r[#r + 1] = '-'
        elseif t == 'length' then
            r[#r + 1] = '#'
        end
        if ops[v1.type] then
            r[#r + 1] = '('
            r[#r + 1] = builder(v1)
            r[#r + 1] = ')'
        else
            r[#r + 1] = builder(v1)
        end
        return table.concat(r)
    elseif ops[t] then
        local r = {}
        if ops[ast[1].type] and ops[ast[1].type] > ops[t] then
            r[#r + 1] = '('
            r[#r + 1] = builder(ast[1])
            r[#r + 1] = ')'
        else
            r[#r + 1] = builder(ast[1])
        end
        r[#r + 1] = ' '
        r[#r + 1] = ast.type
        r[#r + 1] = ' '
        if ops[ast[2].type] and ops[ast[2].type] > ops[t] then
            r[#r + 1] = '('
            r[#r + 1] = builder(ast[2])
            r[#r + 1] = ')'
        else
            r[#r + 1] = builder(ast[2])
        end
        return table.concat(r)
    end
    print(ast)
    os.exit(1)
end

local function usage(msg, code)
    print(msg)
    print('luft -- lua code formatter')
    print('usage:')
    print('  format input.lua and write to output.lua')
    print('    ' .. arg[-1] .. ' ' .. arg[0] .. ' input.lua output.lua')
    print()
    print('  format in place')
    print('    ' .. arg[-1] .. ' ' .. arg[0] .. ' -i input.lua')
    print()
    print('  -m    minify')
    print('  -0    do not indent')
    print('  -1    use 1 space')
    print('  -2    use 2 spaces')
    print('  -4    use 4 spaces')
    print('  -8    use 8 spaces')
    print('  -t    use tabs')
    print()
    os.exit(code)
end

local flat = {}
local flags = {}
for i=1, #arg do
    local cur = arg[i]
    if string.sub(cur, 1, 1) == '-' then
        for j=2, #cur do
            local flag = string.sub(cur, j, j)
            flags[flag] = not flags[flag]
        end
    else
        flat[#flat + 1] = cur
    end
end
if flags['m'] then
    minify = true
    newline = false
    space = ''
    tab = ''
elseif flags['0'] then
    tab = ''
elseif flags['1'] then
    tab = ' '
elseif flags['2'] then
    tab = '  '
elseif flags['4'] then
    tab = '    '
elseif flags['8'] then
    tab = '        '
elseif flags.t then
    tab = '\t'
end
if flags.h then
    usage('', 0)
elseif flags.i then
    if #flat == 0 then
        usage('need at least 1 input file', 1)
    end
    for i=1, #flat do
        local file = flat[i]
        local src = slurp(file)
        local res = parse(lua.program, src)
        if res.ok then
            local ast = res.ast
            local built = builder(ast)
            if flags.b then
                dump(file .. '.bak', src)
            end
            dump(file, built)
        else
            print(res.msg)
            os.exit(1)
        end
    end
else
    if #flat == 0 then
        usage('need an input file and output file', 1)
    end
    if #flat == 1 then
        usage('error: no output file, rerun with -i')
    end
    local infile = flat[1]
    local outfile = flat[2]
    local src = slurp(infile)
    local res = parse(lua.program, src)
    if res.ok then
        local ast = res.ast
        dump(outfile, builder(ast))
    else
        print(res.msg)
        os.exit(1)
    end
end
