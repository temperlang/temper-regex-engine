# Temper Regex Engine

A regex engine in temper.

It does the naive aproach to regex. Not very fast, but works on backends without regex engines in them (like lua).

## Example usage

### Windows PowerShell

```
temper-regex-engine> npm i

added 4 packages, and audited 6 packages in 2s

found 0 vulnerabilities
temper-regex-engine> node .\perf\perf.mjs
OptRegex: 40663.97
Temper: 40520.31
DFA: 4030.49
NFA: 1309.09
Walker: 0.21
temper-regex-engine> $env:LUA_PATH = "temper.out/lua/?.lua;temper.out/lua/?/init.lua"
temper-regex-engine> lua .\perf\bench.lua
OptRegex: 2644.98
Temper: 1.05
DFA: 68.48999999999999
NFA: 18.83
Walker: 0.9399999999999999
temper-regex-engine> $env:PYTHONPATH = "temper.out/py/temper-core;temper.out/py/std;temper.out/py/temper-regex-engine;temper.out/py/temper-regex-parser"
temper-regex-engine> python .\perf\bench.py
OptRegex: 2116.87
Temper: 1309.75
DFA: 33.13
NFA: 23.83
Walker: 2.64
temper-regex-engine> node .\script\re2nfa2dot.mjs "a.b"
digraph {
  rankdir="LR";
  q0 -> q3 [label="a"];
  q2 -> q1 [label="b"];
  q3 -> q2 [label="."];
}
temper-regex-engine> lua .\script\re2nfa2dot.lua "a.b"
digraph {
  rankdir="LR";
  q0 -> q3 [label="a"];
  q2 -> q1 [label="b"];
  q3 -> q2 [label="."];
}
temper-regex-engine> python .\script\re2nfa2dot.py "a.b"
digraph {
  rankdir="LR";
  q0 -> q3 [label="a"];
  q2 -> q1 [label="b"];
  q3 -> q2 [label="."];
}
```
