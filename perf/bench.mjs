import * as bench from 'temper-regex-engine/bench.js';
import * as graph from 'temper-regex-engine/graph.js';

const init = new Date();

const clock = () => new Date() - init;

const engines = [
    {
        name: 'compile',
        invoke: (re) => {
            const res = new graph.TemperRegexDFA(re);
            const str = res.toRegexString(String.fromCharCode);
            const final = new RegExp(str);
            return new class {
                found(str) {
                    return final.test(str);
                }
            }
        },
    }
];

const res = bench.bench(clock, engines);
res.forEach(i => {
    console.log(i.toString());
});
