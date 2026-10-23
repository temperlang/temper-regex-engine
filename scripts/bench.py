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
    # Pair compares by identity, so compare its contents.
    passed = {(x.key, x.value) for x in result.passed}
    if last is not None:
        if last != passed:
            for regex, text in last - passed:
                print(f'wanted: /{regex_to_string(regex)}/.found("{text}")')
            for regex, text in passed - last:
                print(f'not wanted: /{regex_to_string(regex)}/.found("{text}")')
            raise RuntimeError(f'failed: {result.engine}')
    else:
        last = passed
    print(result.to_string())

bench.run()
