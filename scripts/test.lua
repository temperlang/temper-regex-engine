
local libgraph = require('temper-regex-engine/engines/nfa/nfa')

local libparse = require('temper-regex-parser')


if false then
    local re = libgraph.TemperRegexNFA(libparse.parse('(?b=a)b|(?c=a)c'))
    
    local b = re:find('ab')
    local c = re:find('ac')
    assert(b.b, 'find ab works')
    assert(c.c, 'find ac works')
    assert(b.c, 'no false c')
    assert(c.b, 'no false b')
end

if true then
    local re = libgraph.TemperRegexNFA(libparse.parse('^[ab]+c$'))
    local bc = re:find('abc')
    local ac = re:find('ac')
    print(bc.full.value)
    print(ac.full.value)
end
