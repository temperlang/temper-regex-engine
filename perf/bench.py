import time
import re
from temper_regex_engine.perf.bench import RegexBench
from temper_regex_engine.engines.graph.dfa import TemperRegexDFA
from temper_regex_engine.util.tostring import regex_to_string

def clock_ms():
    return time.time() * 1000

for i in range(64):
    n = i
    bench = RegexBench(chr, clock_ms)

    bench.add_regex_str('1?'*n + "0"*n)
    # bench.add_regex_defaults()

    # bench.add_check_defaults()
    bench.add_check('0' * n)

    opt_comp = 0
    unopt_comp = 0

    def custom_opt_pre(regex):
        global opt_comp
        start = clock_ms()
        res = TemperRegexDFA(regex)
        src = res.to_regex_string(chr)
        ret = re.compile(src)
        opt_comp = clock_ms() - start
        return ret
    
    def custom_unopt_pre(regex):
        global unopt_comp
        start = clock_ms()
        src = regex_to_string(regex, chr)
        ret = re.compile(src)
        unopt_comp = clock_ms() - start
        return ret

    def custom_cb(final, str: str) -> bool:
        return final.search(str) != None

    # bench.add_engine_defaults()
    bench.add_custom_engine('opt', custom_opt_pre, custom_cb)
    bench.add_custom_engine('unopt', custom_unopt_pre, custom_cb)

    opt_run = 0
    unopt_run = 0

    @bench.on_engine_result
    def on_engine_result(result):
        global opt_run, unopt_run
        if result.engine == 'opt' or result.engine == 'temper dfa':
            opt_run = result.score
        if result.engine == 'unopt' or result.engine == 'temper default':
            unopt_run = result.score

    bench.run()

    n_run = int(opt_run / unopt_run * 100) / 100
    if opt_comp != 0 and unopt_comp != 0:
        n_comp = int(opt_comp / unopt_comp * 100) / 100
        print(f'rep {n}: run {n_run}x faster, comp {n_comp}x slower')
    else:
        print(f'rep {n}: run {n_run}x faster')

