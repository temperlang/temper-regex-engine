#!/usr/bin/env lua

local graph = require('temper-regex-engine/graph')
local parser = require('temper-regex-parser')

local regex = parser.parse(arg[1]);
local res = graph.TemperRegexDFA(regex);
print(res:toDot())
