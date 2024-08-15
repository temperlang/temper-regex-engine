
local libgraph = require('temper-regex-engin./graph/graph')

local libparse = require('temper-regex-parser')

local re = libgraph.TemperRegexNFA(libparse.parse('(?b=a)b|(?c=a)c'))

local b = re:find('ab')
local c = re:find('ac')
assert(b.b, 'find ab works')
assert(c.c, 'find ac works')
assert(b.c, 'no false c')
assert(c.b, 'no false b')
