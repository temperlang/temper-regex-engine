
local TemperRegexNFA = require('temper-regex-engine/nfa/nfa').TemperRegexNFA

local libparse = require('temper-regex-parser')

local function regex(str)
    return TemperRegexNFA.fromRegex(libparse.parse(str))
end

do
    local re = regex('\\b[a-zA-Z_]([a-zA-Z_]|[0-9])*\\b')
    assert(re:find('123_abc def_456 ghi_789').full.value == 'def_456')
end

do
    local re = regex('(?b=a)b|(?c=a)c')
    local b = re:find('ab')
    local c = re:find('ac')
    assert(b.groups.b ~= nil, 'find ab works')
    assert(c.groups.c ~= nil, 'find ac works')
    assert(b.groups.c == nil, 'no false c')
    assert(c.groups.b == nil, 'no false b')
end

do
    local re = regex('[12]+1')
    assert(re:found('121'))
end

do
    local re = regex('a+(?intro=b+)c(((?option1=d)|(?alphaOption2=e)))+')
    assert(re:found('abcdef'))
end
