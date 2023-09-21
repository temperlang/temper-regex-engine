#!/usr/bin/env lua

local TemperRegexDFA = require('temper-regex-engine/engines/graph/dfa').TemperRegexDFA
local sub = require('temper-regex-engine/util/parser').sub

local regex = sub(arg[1])
local res = TemperRegexDFA(regex)
local pattern = res:toRegexString(string.char)

print(pattern)
