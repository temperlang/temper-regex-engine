import * as bench from 'temper-regex-engine/bench.js';

const init = new Date();

const clock = () => new Date() - init;

const res = bench.bench(clock);
res.forEach(i => {
    console.log(i.toString());
});
