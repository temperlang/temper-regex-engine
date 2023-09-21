#!/usr/bin/env node

import * as graph from 'temper-regex-engine/engines/graph/dfa.js';
import * as parser from 'temper-regex-engine/util/parser.js';

const regex = parser.sub(process.argv[2]);
const res = new graph.TemperRegexDFA(regex);
console.log(res.toDot());
