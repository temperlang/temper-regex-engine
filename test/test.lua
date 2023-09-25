
local sub = require('temper-regex-engine/util/parser').sub
local nfa = require('temper-regex-engine/graph/nfa').TemperRegexNFA

local n = 0

local function check(t)
    local re = nfa(sub(t.re))
    local ok, res = pcall(re.find, re, t.str)
    if t.fail then
        if ok then
            error('expected fail (test: ' .. t.str .. ')')
        end
    else
        if not ok then
            error('expected not to fail')
        end
        for k, v in pairs(t) do
            if k ~= 're' and k ~= 'str' and k ~= 'fail' and k ~= 'name' then
                local ok, value = pcall(function() return res[k].value end)
                if not ok then
                    error('group ' .. k .. ' failed to reify')
                end
                if value ~= v then
                    print('group ' .. k .. ' = "' .. tostring(value) .. '"')
                    error('expected group ' .. k .. ' to be ' .. v)
                end
            end
        end
    end
    if t.name ~= nil then
        print('pass: ' .. t.name)
    end
end

check {
    name = 'basic',
    re = 'x',
    str = 'x',
    full = 'x'
}

check {
    name = 'groups',
    re = 'x(?y=y)z',
    str = 'wxyz',
    full = 'xyz',
    y = 'y'
}

check {
    name = 'fail',
    re = 'x',
    str = 'y',
    fail = true,
}

check {
    name = 'nongreedy',
    re = '(?first=\\w+)\\b.*?(?last=\\w+)',
    str = 'Joe Smith',
    full = 'Joe Smith',
    first = 'Joe',
    last = 'Smith'
}

check {
    name = 'repeat',
    re = 'ab*',
    str = 'abbey',
    full = 'abb'
}

check {
    name = 'repeat nongreedy',
    re = 'ab*?',
    str = 'abbey',
    full = 'a'
}

check {
    name = 'word border at end',
    re = '[ab]\\b',
    str = 'ab',
    full = 'b'
}

check {
    name = 'invert',
    re = '[^a]',
    str = 'abc',
    full = 'b'
}

check {
    name = 'lisp expr',
    re = '\\d+|\\(\\R( \\R)*\\)',
    str = 'abc (1 (2 3) 4) def',
    full = '(1 (2 3) 4)'
}

check {
    name = 'split lisp expr',
    re = '(?cell=\\w+)|\\((?func=\\R) ?(?args=\\R( \\R)*)\\)',
    str = '(eq x y) ; nope',
    full = '(eq x y)',
    func = 'eq',
    args = 'x y'
}

check {
    name = 'find balanced parens',
    re = '\\(\\R*?\\)',
    str = ')(())(',
    full = '(())'
}

check {
    name = 'balanced parens',
    re = '[^()]*(?:\\(\\R*?\\))*[^()]*',
    str = '(())',
    full = '(())'
}

check {
    name = 'equal number of a and b (too many b)',
    re = 'a\\R?b',
    str = 'abbb',
    full = 'ab'
}

check {
    name = 'equal number of a and b (too many a)',
    re = 'a\\R?b',
    str = 'aaaab',
    full = 'ab'
}

check {
    name = 'nested groups',
    re = 'c(?outer=d(?inner=e)f)g',
    str = 'abcdefghi',
    full = 'cdefg',
    outer = 'def',
    inner = 'e',
}

check {
    name = 'basic backref',
    re = '(?ab=a|b)\\k<ab>',
    str = 'aa',
    full = 'aa',
    ab = 'a',
}

check {
    name = 'backref should not rematch group',
    re = '(?ab=a|b)\\k<ab>',
    str = 'ab',
    fail = true
}

check {
    name = 'backref in group',
    re = '(?a=a\\k<a>)',
    str = 'aaa',
    full = 'aa',
    a = 'aa'
}

check {
    name = 'subroutine',
    re = '(?name:\\b\\w+\\b)(?&name)',
    str = 'hello world',
    full = 'hello'
}
