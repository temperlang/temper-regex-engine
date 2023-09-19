
local bench = require('temper-regex-engine/bench')
local graph = require('temper-regex-engine/graph')

local function clock_ms()
    return os.clock() * 1000
end

local engines = {
    {
        name = "pattern",
        invoke = function(self, re)
            local res = graph.TemperRegexDFA(re)
            return res:toLua(string.char, function(str, test)
                return string.find(str, test) ~= nil
            end)
        end,
    }
}

local res = bench.bench(clock_ms, engines)
for i=1, #res do
    if res[i].name ~= 'native' then
        print(res[i]:toString())
    end
end
