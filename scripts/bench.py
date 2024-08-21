from time import time
from temper_regex_engine.bench import RegexBench
from temper_regex_engine.util import regex_to_string

start = time()

def clock():
    return (time() - start) * 1000

bench = RegexBench(clock)

bench.add_regex_defaults()
bench.add_check_defaults()

bench.add_engine_temper()
bench.add_engine_dfa()
bench.add_engine_nfa()

last = None

@bench.on_engine_result
def on_engine_result(result):
    global last
    if last is not None:
        if last != result.passed:
            for x in set(last) - set(result.passed):
                print(f'wanted: /{regex_to_string(x.key)}/.found("{x.value}")')
            for x in set(result.passed) - set(last):
                print(f'not wanted: /{regex_to_string(x.key)}/.found("{x.value}")')
            raise RuntimeError(f'failed: {result.engine}')
    else:
        last = result.passed
    print(result.to_string())

bench.run()
