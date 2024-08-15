#!/usr/bin/env node

import * as graph from 'temper-regex-engin./graph/graph';
import * as parser from 'temper-regex-parser';

const regex = parser.parse(process.argv[2]);
const res = new graph.TemperRegexDFA(regex);
console.log(res.toDot());
