import temper_regex_engine.graph as graph
import temper_regex_engine.parser as parser
import sys

regex = parser.sub(sys.argv[1])
res = graph.TemperRegexNFA(regex)
print(res.to_string())
