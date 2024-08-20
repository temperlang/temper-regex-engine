
local bundle = 'bundle.lua'
local output = io.open(bundle, 'w')
if output == nil then
    error('failed to open ' .. bundle .. 'for writing')
end
for i=1, #arg do
    local path = arg[i]
    local input = io.open(path, 'r')
    if input == nil then
        error('failed to read ' .. path)
    end
    local mod = path:gsub('^temper.out/lua/', ''):gsub('.lua$', '')
    output:write('package.preload[\'')
    output:write(mod)
    output:write('\'] = function()\n')
    for line in input:lines() do
        output:write('  ')
        output:write(line)
        output:write('\n')
    end
    output:write('end\n')
end
output:flush()
output:close()

package.path = '?.lua'

arg = {[-1] = arg[-1], [0] = 'scripts/luft.lua', '-i', '-m', bundle}
require('scripts.luft')
