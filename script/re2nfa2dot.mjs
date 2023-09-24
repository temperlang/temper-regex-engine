#!/usr/bin/env node

import * as graph from 'temper-regex-engine/graph/nfa.js';
import * as parser from 'temper-regex-engine/util/parser.js';

const regex = parser.sub(process.argv[2]);
const res = new graph.TemperRegexNFA(regex);
console.log(res.toString());
