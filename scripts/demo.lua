#!/usr/bin/env lua

local graph = require('temper-regex-engin./graph/graph')
local parser = require('temper-regex-parser')

local ls = {
    '[abcdef]',
    '[wz]|[xy]',
    'a+',
    'xy?z'
}

for i=1, #ls do
    local cur = ls[i]
    local regex = parser.parse(cur)
    local res = graph.TemperRegexDFA(regex)
    print('/' .. cur .. '/ -> /' .. res:toRegexString(string.char) .. '/')
end
