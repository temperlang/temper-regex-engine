
local temper = require('temper-core')

local TemperRegexNFA = require('temper-regex-engine/engines/nfa/nfa').TemperRegexNFA
local regexToString = require('temper-regex-engine/util').regexToString

local libparse = require('temper-regex-parser')

-- local done = false
local function noFastMatcher(re)
    -- if not done then
    --     done = true
    --     print(regexToString(re))
    --     for k, v in pairs(re) do
    --         print(k, v)
    --     end
    -- end
    return temper.null
end

local function regex(str)
    return TemperRegexNFA.fromRegex(libparse.parse(str), noFastMatcher)
end

do
    local re = regex('\\b[a-zA-Z_]([a-zA-Z_]|[0-9])*\\b')
    assert(re:find('123_abc def_456 ghi_789').full.value == 'def_456')
end

do
    local re = regex('(?b=a)b|(?c=a)c')
    local b = re:find('ab')
    local c = re:find('ac')
    assert(b.b ~= nil, 'find ab works')
    assert(c.c ~= nil, 'find ac works')
    assert(b.c == nil, 'no false c')
    assert(c.b == nil, 'no false b')
end

do
    local re = regex('[12]+1')
    assert(re:found('121'))
end

do
    local re = regex('a+(?intro=b+)c(((?option1=d)|(?alphaOption2=e)))+')
    assert(re:found('abcdef'))
end
