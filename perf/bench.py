import time
import sys
import re
from temper_regex_engine.bench import RegexBench
import temper_regex_engine.graph as graph

def clock_ms():
    return time.time() * 1000

class CompiledRegexEngineFinal:
    final: re.Pattern
    __slots__ = ('final',)
    
    def __init__(self, final: re.Pattern):
        self.final = final

    def found(self, str: str) -> bool:
        return self.final.search(str) != None

bench = RegexBench(chr, clock_ms)

bench.add_regex_defaults()
bench.add_check_defaults()

def opt_regex_engine(regex):
    res = graph.TemperRegexDFA(regex)
    src = res.to_regex_string(chr)
    final = re.compile(src)
    return CompiledRegexEngineFinal(final)

bench.add_engine('OptRegex', opt_regex_engine)
bench.add_engine_defaults()

@bench.on_engine_result
def on_engine_result(result):
    print(result.to_string())

bench.run()
