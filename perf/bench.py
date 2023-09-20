import time
import sys
import re
import temper_regex_engine.bench as bench
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

class CompiledRegexEngine:
    name: str
    __slots__ = ('name',)

    def __init__(self):
        self.name = "compile"

    def invoke(self, regex):
        res = graph.TemperRegexDFA(regex)
        src = res.to_regex_string(chr)
        final = re.compile(src)
        return CompiledRegexEngineFinal(final)

res = bench.bench(clock_ms, [CompiledRegexEngine()])
for i in res:
    print(f"{sys.implementation.name}{sys.version_info.major}.{sys.version_info.minor} {i.name}: {int(i.score)}")
