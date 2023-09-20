import {RegexBench} from 'temper-regex-engine/bench.js';
import {TemperRegexDFA} from 'temper-regex-engine/graph.js';

const init = new Date();

const chr = (c) => String.fromCharCode(c);
const clock = () => new Date() - init;

const bench = new RegexBench(chr, clock);

bench.addRegexDefaults();
bench.addCheckDefaults();

bench.addEngine('OptRegex', (re) => {
    const res = new TemperRegexDFA(re);
    const str = res.toRegexString(String.fromCharCode);
    const final = new RegExp(str);
    return new class {
        found(str) {
            return final.test(str);
        }
    }
});
bench.addEngineDefaults();

bench.onEngineResult((result) => {
    console.log(result.toString());
});

bench.run();
