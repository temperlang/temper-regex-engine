
local bench = require('temper-regex-engine.bench')

local function clock_ms()
    return os.clock() * 1000
end

local gsum = 0
local gcount = 0

local tsum = 0
local tcount = 0

local function on_result(graph, tree)
    gsum = gsum + graph
    gcount = gcount + 1
    tsum = tsum + tree
    tcount = tcount + 1
end

local res = bench.bench(clock_ms)
for i=1, #res do
    print(res[i]:toString())
end
