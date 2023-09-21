import time
import re
from temper_regex_engine.perf.bench import RegexBench
from temper_regex_engine.engines.graph.dfa import TemperRegexDFA

def clock_ms():
    return time.time() * 1000

bench = RegexBench(chr, clock_ms)

bench.add_regex_defaults()

bench.add_check_defaults()

def custom_opt_pre(regex):
    global opt_comp
    start = clock_ms()
    res = TemperRegexDFA(regex)
    src = res.to_regex_string(chr)
    ret = re.compile(src)
    opt_comp = clock_ms() - start
    return ret

def custom_cb(final, str: str) -> bool:
    return final.search(str) != None

bench.add_engine_defaults()
bench.add_custom_engine('temper regex-opt', custom_opt_pre, custom_cb)

@bench.on_engine_result
def on_engine_result(result):
    print(result.to_string())

bench.run()
