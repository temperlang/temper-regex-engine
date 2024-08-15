local RegexBench = require('temper-regex-engine/bench').RegexBench

local start = os.clock()
local clock = function()
    return (os.clock() - start) * 1000
end

local bench = RegexBench(clock);

bench:addRegexDefaults();
bench:addCheckDefaults();

bench:addEngineNFA();
bench:addEngineWalker();

bench:onEngineResult(function (result)
    print(result:toString());
end);

bench:run();
