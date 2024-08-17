import {RegexBench} from 'temper-regex-engine/bench';
import { regexToString } from 'temper-regex-engine/util';

const init = new Date();

const clock = () => new Date() - init;

const bench = new RegexBench(clock);

bench.addRegexDefaults();
bench.addCheckDefaults();

// bench.addEngineTemper();
// bench.addEngineDFA();
bench.addEngineNFA();
bench.addEngineCombo();

bench.addEnginePattern((fmt) => {
    let re = new RegExp(`^(${fmt})`, 'y');
    let notFound = [];
    return (str, index) => {
        re.lastIndex = index;
        const match = re.exec(str);
        if (match) {
            return [index + match[0].length];
        } else {
            return notFound;
        }
    };
});
// bench.addEngineWalker();

let last = new Set();

bench.onEngineResult((result) => {
    const pass = new Set(result.passed.map(x => `${regexToString(x[0])}: ${x[1]}`));
    const tooMany = pass.difference(last);
    const tooFew = last.difference(pass);
    if (last.size !== 0 && (tooMany.size !== 0 || tooFew.size !== 0)) {
        for (const p of tooMany) {
            console.log('did not want: ' + p);
        }
        for (const p of tooFew) {
            console.log('wanted: ' + p);
        }
        throw new Error(`failed: ${result.engine}`);
    } else {
        console.log(result.toString());
        last = pass;
    }
});

bench.run();
