local RegexBench = require('temper-regex-engine/bench').RegexBench

local start = os.clock()
local clock = function()
    return (os.clock() - start) * 1000
end

local bench = RegexBench(clock);

bench:addRegexDefaults();
bench:addCheckDefaults();

local notFound = {}
bench:addEngineDFA();
bench:addEnginePattern(function(pat)
    return function (str, index)
        local _, i = string.find(str, pat, index)
        if i then
            return {i+1}
        else
            return notFound
        end
    end
end)
bench:addEngineCombo();
bench:addEngineNFA();
bench:addEngineTemper();
bench:addEngineWalker();

bench:onEngineResult(function (result)
    -- for i=1, #result.passed do
    --     print(result.passed[i].value)
    -- end
    print(#result.passed)
    print(result:toString());
end);

bench:run();
