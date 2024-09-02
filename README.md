# Temper Regex Engine

A regex engine in temper.

It does the naive aproach to regex. Not very fast, but works on backends without regex engines in them (like lua).

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

The "scripts/test.lua" script currently fails on `re:found` here, but other
parts of it pass:

```lua
do
    local re = regex('[12]+1')
    assert(re:found('121'))
end
```

This is the error message I get:

```
String::get failed
```

## Example bundling for Temper

First install luamin.

```bash
npm install -g luamin
```

Then you can run the following.

```bash
temper build

lua bundler.lua \
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

luamin -f bundle.lua > bundle.min.lua
```
