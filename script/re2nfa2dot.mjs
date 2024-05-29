#!/usr/bin/env node

import * as graph from 'temper-regex-engine/graph';
import * as parser from 'temper-regex-parser';

const regex = parser.parse(process.argv[2]);
const res = new graph.TemperRegexNFA(regex);
console.log(res.toString());
