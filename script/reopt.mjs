#!/usr/bin/env node

import * as graph from 'temper-regex-engine/graph';
import * as parser from 'temper-regex-engine/parser';

const regex = parser.sub(process.argv[2]);
const res = new graph.TemperRegexDFA(regex);
console.log(res.toRegexString(String.fromCharCode));
