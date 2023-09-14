import time
import math
import temper_regex_engine.bench as bench

def clock_ms():
    return time.time() * 1000

res = bench.bench(clock_ms)
for i in res:
    print(i.to_string())
