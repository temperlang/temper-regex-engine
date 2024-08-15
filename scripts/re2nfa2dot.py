#!/usr/bin/env python3

import temper_regex_engine.graph as graph
import temper_regex_parser as parser
import sys

regex = parser.parse(sys.argv[1])
res = graph.TemperRegexNFA(regex)
print(res.to_string())
