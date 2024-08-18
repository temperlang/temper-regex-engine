from time import time
from temper_regex_engine.bench import RegexBench

def clock():
    return time() * 1000

bench = RegexBench(clock)

bench.add_regex_defaults()
bench.add_check_defaults()

bench.add_engine_nfa()
bench.add_engine_temper()

@bench.on_engine_result
def on_engine_result(result):
    print(result.to_string())

bench.run()
