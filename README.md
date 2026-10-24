# Temper Regex Engine

A regex engine in temper.

It's a backtracking NFA that explores each state at each position at most once
per search. When a pattern has no anchors, a DFA also answers `found` on its
own and ends other searches early when nothing matches. It works on backends
without regex engines in them (like lua).

## Example testing

Add this import to config.temper.md:

```ts
    import("https://github.com/temperlang/temper-regex-parser/tree/regex-range");
```

Because remote imports still can be unstable, this is isn't included by default,
but it's needed for test code to run. Remote imports sometimes hang temper
builds, and we need to fix that.

Set up your environment for testing Lua:

```bash
export LUA_PATH="temper.out/lua/?.lua;temper.out/lua/?/init.lua"
# TODO Setup for other backends.
```

Then run:

```
temper build
```

Finally, try test scripts:

```
$ lua ./scripts/bench.lua
::found
Temper: 306.05
Opt: 396.2

::find
Temper: 38.51
Opt: 43.41

::replace
Temper: 33.04
Opt: 32.89

::split
Temper: 42.57
Opt: 49.07
```

## Example bundling for Temper

First install luamin into this directory.

```bash
npm install luamin@1.0.4
```

Then you can run the following.

```bash
temper build

lua bundler.lua bundle.lua \
    temper.out/lua/temper-regex-engine/ctype.lua \
    temper.out/lua/temper-regex-engine/dfa/dfa.lua \
    temper.out/lua/temper-regex-engine/dfa/javascript.lua \
    temper.out/lua/temper-regex-engine/dfa/lua.lua \
    temper.out/lua/temper-regex-engine/init.lua \
    temper.out/lua/temper-regex-engine/nfa/engine.lua \
    temper.out/lua/temper-regex-engine/nfa/matcher.lua \
    temper.out/lua/temper-regex-engine/nfa/nfa.lua \
    temper.out/lua/temper-regex-engine/nfa/stack.lua \
    temper.out/lua/temper-regex-engine/nfa/state.lua \
    temper.out/lua/temper-regex-engine/regex.lua \
    temper.out/lua/temper-regex-engine/util.lua

node scripts/minify.mjs bundle.lua bundle.min.lua
```

Temper's Lua backend uses the result as
`be-lua/src/commonMain/resources/lang/temper/be/lua/temper-core/regex/runtime.lua`.
