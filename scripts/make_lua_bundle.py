import glob

in_file_names = [
    *glob.glob('temper.out/lua/temper-regex-engine/**/*.lua', recursive=True),
    # *glob.glob('temper.out/lua/temper-regex-parser/**/*.lua', recursive=True),
]

with open('bundle.lua', 'w') as out:
    for in_file_name in in_file_names:
        with open(in_file_name, 'r') as in_file:
            path = in_file_name
            path = path.replace('temper.out/lua/', '')
            path = path.replace('/init.lua', '')
            path = path.replace('.lua', '')
            out.write(f'package.preload["{path}"] = function()\n')
            for line in in_file.readlines():
                out.write('  ')
                out.write(line)
            out.write(f'end\n')
