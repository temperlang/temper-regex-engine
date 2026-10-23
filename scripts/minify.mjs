// Usage: node scripts/minify.mjs INPUT.lua OUTPUT.lua
// INPUT and OUTPUT can be the same file.
import { readFileSync, writeFileSync } from 'node:fs';
import luamin from 'luamin';

const [input, output] = process.argv.slice(2);
writeFileSync(output, luamin.minify(readFileSync(input, 'utf8')));
