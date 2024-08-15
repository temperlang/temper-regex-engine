import {RegexBench} from 'temper-regex-engine/bench';
import {TemperRegexDFA} from 'temper-regex-engin./graph/graph';

const init = new Date();

const clock = () => new Date() - init;

const bench = new RegexBench(clock);

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
