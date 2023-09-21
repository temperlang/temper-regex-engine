#!/usr/bin/env lua

local TemperRegexNFA = require('temper-regex-engine/engines/graph/nfa').TemperRegexNFA
local sub = require('temper-regex-engine/util/parser').sub

local regex = sub(arg[1])
local res = TemperRegexNFA(regex)
print(res:toString())
