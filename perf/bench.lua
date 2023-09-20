local RegexBench = require('temper-regex-engine/bench').RegexBench
local TemperRegexDFA = require('temper-regex-engine/graph').TemperRegexDFA

local chr = string.char
local start = os.clock()
local clock = function()
    return (os.clock() - start) * 1000
end

local bench = RegexBench(chr, clock);

bench:addRegexDefaults();
bench:addCheckDefaults();

bench:addEngine('OptRegex', function (re)
    local res = TemperRegexDFA(re)
    return res:toLua(chr, function(str, test)
        return string.find(str, test) ~= nil
    end)
end);
bench:addEngineDefaults();

bench:onEngineResult(function (result)
    print(result:toString());
end);

bench:run();
