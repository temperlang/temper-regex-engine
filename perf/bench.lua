TEMPER_LUA_DEBUG_PCALL = true

local RegexBench = require('temper-regex-engine/bench').RegexBench

local start = os.clock()
local clock = function()
    return (os.clock() - start) * 1000
end

local bench = RegexBench(clock);

bench:addRegexDefaults();
bench:addCheckDefaults();

-- bench:addEngine('OptRegex', function (re)
--     local res = TemperRegexDFA(re)
--     return res:toPatterns(function(str, test)
--         return string.find(str, test) ~= nil
--     end)
-- end);
bench:addEngineNFA();
-- bench:addEngineDFA();
bench:addEngineWalker();
-- bench:addEngineDefaults();

bench:onEngineResult(function (result)
    print(result:toString());
end);

bench:run();
