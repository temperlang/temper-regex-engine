#!/usr/bin/env node

import * as graph from 'temper-regex-engine/graph.js';
import * as parser from 'temper-regex-engine/parser.js';

const regex = parser.sub(process.argv[2]);
const res = new graph.TemperRegexNFA(regex);
console.log(res.toString());
