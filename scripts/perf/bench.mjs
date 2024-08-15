import {RegexBench} from 'temper-regex-engine/bench';

const init = new Date();

const clock = () => new Date() - init;

const bench = new RegexBench(clock);

bench.addRegexDefaults();
bench.addCheckDefaults();

bench.addEngineNFA();
bench.addEngineWalker();

bench.onEngineResult((result) => {
    console.log(result.toString());
});

bench.run();
