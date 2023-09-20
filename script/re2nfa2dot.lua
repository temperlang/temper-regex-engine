#!/usr/bin/env lua

local graph = require('temper-regex-engine/graph')
local parser = require('temper-regex-engine/parser')

local regex = parser.sub(arg[1])
local res = graph.TemperRegexNFA(regex)
print(res:toString())
