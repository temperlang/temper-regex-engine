import time
import math
import sys
import temper_regex_engine.bench as bench

def clock_ms():
    return time.time() * 1000

res = bench.bench(clock_ms)
for i in res:
    print(f"{sys.implementation.name}{sys.version_info.major}.{sys.version_info.minor} {i.name}: {int(i.score)}")
