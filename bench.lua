
local bench = require('temper-regex-engine.bench')

local function clock_ms()
    return os.clock() * 1000
end

local res = bench.bench(clock_ms)
for i=1, #res do
    if res[i].name ~= 'walker' then
        print(res[i]:toString())
    end
end
