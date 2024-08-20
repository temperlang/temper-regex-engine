local RegexBench = require('temper-regex-engine/bench').RegexBench
local regexToString = require('temper-regex-engine/util').regexToString

local start = os.clock()
local clock = function()
    return (os.clock() - start) * 1000
end

local bench = RegexBench(clock);

bench:addRegexDefaults();
bench:addCheckDefaults();

local load = load or loadstring

bench:addEngineTemper();
bench:addEngineLua(function(str)
    -- print(str)
    local loader, err = load(str)
    if loader == nil then
        error(err)
    end
    return loader()
end);
bench:addEngineNFA();
bench:addEngineDFA();

local found

local check = true

bench:onEngineResult(function (result)
    if check and found then
        local errors = {}
        do
            local missing = {}
            for i=1, #found do
                missing[found[i].value] = found[i]
            end
            for i=1, #result.passed do
                missing[result.passed[i].value] = nil
            end
            for k, v in pairs(missing) do
                errors[#errors+1] = 'wanted: /' .. regexToString(v.key) .. '/.found("' .. k .. '")'
            end
        end
        do
            local extra = {}
            for i=1, #result.passed do
                extra[result.passed[i].value] = result.passed[i]
            end
            for i=1, #found do
                extra[found[i].value] = nil
            end
            for k, v in pairs(extra) do
                errors[#errors+1] = 'not wanted: /' .. regexToString(v.key) .. '/.found("' .. k .. '")'
            end
        end
        if #errors ~= 0 then
            local rest = table.concat(errors, '\n\t')
            error('engine ' .. result.engine .. ' failed with ' .. tostring(#errors) .. ' errors:\n\t' .. rest)
        end
    else
        found = result.passed
    end
    print(result:toString());
end);

bench:run();
