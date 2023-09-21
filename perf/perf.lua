local RegexBench = require('temper-regex-engine/perf/bench').RegexBench
local TemperRegexDFA = require('temper-regex-engine/engines/graph/dfa').TemperRegexDFA
local regxeToString = require('temper-regex-engine/util/tostring').regexToString

local chr = string.char
local start = os.clock()
local clock = function()
    return (os.clock() - start) * 1000
end

local bench = RegexBench(chr, clock);

bench:addRegexDefaults();
bench:addCheckDefaults();

pcall(function()
    local regex = require('regex')
    bench:addEngine('mod regex', function(re)
        local str = regxeToString(re)
        local re = regex.new(str)
        return {
            found = function(self, str)
                return re:test(str)
            end
        }
    end)
    bench:addEngine('mod regex+jit', function(re)
        local str = regxeToString(re)
        local re = regex.new(str, 'j')
        return {
            found = function(self, str)
                return re:test(str)
            end
        }
    end)
end)

pcall(function()
    local pcre2 = require('rex_pcre2')
    bench:addEngine('mod rex_pcre2', function(re)
        local str = regxeToString(re)
        local re = pcre2.new(str)
        return {
            found = function(self, str)
                return re:find(str) ~= nil
            end
        }
    end)
    bench:addEngine('mod rex_pcre2+jit', function(re)
        local str = regxeToString(re)
        local re = pcre2.new(str)
        re:jit_compile(pcre2.JIT_PARTIAL_SOFT)
        return {
            found = function(self, str)
                return re:find(str) ~= nil
            end
        }
    end)
end)

pcall(function()
    local pcre2 = require('rex_posix')
    bench:addEngine('mod rex_posix', function(re)
        local str = regxeToString(re)
        local re = pcre2.new(str)
        return {
            found = function(self, str)
                return re:find(str) ~= nil
            end
        }
    end)
end)

pcall(function()
    local pcre2 = require('rex_gnu')
    bench:addEngine('mod rex_gnu', function(re)
        local str = regxeToString(re)
        local re = pcre2.new(str)
        return {
            found = function(self, str)
                return re:find(str) ~= nil
            end
        }
    end)
end)

local find = string.find

bench:addEngine('temper regex-opt', function (re)
    local res = TemperRegexDFA(re)
    return res:toLua(chr, function(str, test)
        return find(str, test) ~= nil
    end)
end)

bench:addEngineDFA()
bench:addEngineNFA()
bench:addEngineWalker()

bench:onEngineResult(function (result)
    print(result:toString())
end)

bench:run()