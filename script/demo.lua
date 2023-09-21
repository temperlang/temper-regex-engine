#!/usr/bin/env lua

local TemperRegexDFA = require('temper-regex-engine/engines/graph/dfa').TemperRegexDFA
local sub = require('temper-regex-engine/util/parser').sub

local ls = {
    '[abcdef]',
    '[wz]|[xy]',
    'a+',
    'xy?z'
}

for i=1, #ls do
    local cur = ls[i]
    local regex = sub(cur)
    local res = TemperRegexDFA(regex)
    print('/' .. cur .. '/ -> /' .. res:toRegexString(string.char) .. '/')
end
