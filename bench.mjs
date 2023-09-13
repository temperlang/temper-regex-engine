
import * as nfa from 'temper-regex-engine/nfa.js';
import * as walk from 'temper-regex-engine/walk.js';
import * as parser from 'temper-regex-engine/parser.js';

const regex = parser.sub('h(?:[eu]l+o|i)')

const bench = (name, mod) => {
    const re = new mod.TemperCompiledRegex(regex);
    const checks = {
        'true': [
            'hello',
            'hi',
            'helo',
            'hullo',
            'hulo',
            'i am going to say hello',
            'abcdefghijklmnopqrstuvwxyz',
        ],
        'false': [
            'test',
            'Hell, MI',
            'hydrogen helium carbon nitrognen',
        ],
    };
    const times = {};
    for (const key of Object.keys(checks)) {
        for (const ent of checks[key]) {
            let iters = 1;
            let res = re.found(ent);
            const beginTime = new Date();
            do {
                for (let i = 0; i < iters; i++) {
                    res = re.found(ent);
                }
                iters += iters;
            } while (new Date() - beginTime < 100);
            const endTime = new Date();
            const ms = endTime - beginTime;
            const passed = String(res) === key;
            if (passed) {
                times[ent] = iters / (ms / 1000) | 0;
            } else {
                throw new Error(`bad test for ${name}: ${ent}`);
            }
        }
    }
    return times;
};

const r1 = bench('NFA Build', nfa);
const r2 = bench('Tree Walk', walk);
const speeds = [];
for (const key of Object.keys(r1)) {
    speeds.push(r1[key] / r2[key]);
}
speeds.sort((a, b) => a - b);
console.log(speeds);