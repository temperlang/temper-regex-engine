#!/usr/bin/env python3

import temper_regex_engine.graph.nfa as graph
import temper_regex_engine.util.parser as parser
import sys

regex = parser.sub(sys.argv[1])
res = graph.TemperRegexNFA(regex)
print(res.to_string())
