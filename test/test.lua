
local sub = require('temper-regex-engine/util/parser').sub
local nfa = require('temper-regex-engine/graph/nfa').TemperRegexNFA

local re = sub("(?thing=x)")

local nre = nfa(re)

local function dump(o)
    if type(o) == 'table' then
       local s = '{'
       for k,v in pairs(o) do
            if k ~= '.type' then
                if type(k) ~= 'number' then k = '"'..tostring(k)..'"' end
                s = s .. k .. ' = ' .. dump(v) .. ','
            end
        end
       return s .. '}'
    else
       return tostring(o)
    end
end

local t = nre:find("x")

print(dump(t.thing.value))
