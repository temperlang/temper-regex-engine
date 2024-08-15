package.preload["temper-regex-engine"] = function()
  require('temper-regex-engine/regex')
  require('temper-regex-engine/engines/native')
  require('temper-regex-engine/util')
  require('temper-regex-engine/engines/walk')
  require('temper-regex-engine/engines/nfa/matcher')
  require('temper-regex-engine/engines/nfa/state')
  require('temper-regex-engine/engines/nfa/stack')
  require('temper-regex-engine/engines/nfa/engine')
  require('temper-regex-engine/engines/nfa/nfa')
  require('temper-regex-engine/engines/patterns')
  require('temper-regex-engine/engines/dfa/builder')
  require('temper-regex-engine/engines/dfa/table')
  require('temper-regex-engine/engines/dfa/dfa')
  require('temper-regex-engine/bench')
  require('temper-regex-engine/test')
end
package.preload["temper-regex-engine/regex"] = function()
  local temper = require('temper-core');
  local RegexNode, Capture, CodePart, CodePoints, Special, SpecialSet, CodeRange, ItemizedRegex, CodeSet, Or, Repeat, entire, oneOrMore, optional, Sequence, Group, Regex, Begin, Dot, End, WordBoundary, Digit, Space, Word, TemperRegex, exports;
  RegexNode = temper.import('std/regex', 'RegexNode');
  Capture = temper.import('std/regex', 'Capture');
  CodePart = temper.import('std/regex', 'CodePart');
  CodePoints = temper.import('std/regex', 'CodePoints');
  Special = temper.import('std/regex', 'Special');
  SpecialSet = temper.import('std/regex', 'SpecialSet');
  CodeRange = temper.import('std/regex', 'CodeRange');
  ItemizedRegex = temper.import('std/regex', 'ItemizedRegex');
  CodeSet = temper.import('std/regex', 'CodeSet');
  Or = temper.import('std/regex', 'Or');
  Repeat = temper.import('std/regex', 'Repeat');
  entire = temper.import('std/regex', 'entire');
  oneOrMore = temper.import('std/regex', 'oneOrMore');
  optional = temper.import('std/regex', 'optional');
  Sequence = temper.import('std/regex', 'Sequence');
  Group = temper.import('std/regex', 'Group');
  Regex = temper.import('std/regex', 'Regex');
  Begin = temper.import('std/regex', 'Begin');
  Dot = temper.import('std/regex', 'Dot');
  End = temper.import('std/regex', 'End');
  WordBoundary = temper.import('std/regex', 'WordBoundary');
  Digit = temper.import('std/regex', 'Digit');
  Space = temper.import('std/regex', 'Space');
  Word = temper.import('std/regex', 'Word');
  TemperRegex = temper.type('TemperRegex');
  TemperRegex.constructor = function(this__0, data__35)
    temper.virtual();
    return nil;
  end;
  TemperRegex.methods.replace = function(this__1, text__38, format__39)
    return__6 = temper.virtual();
  end;
  TemperRegex.methods.split = function(this__2, text__42)
    return__7 = temper.virtual();
  end;
  TemperRegex.methods.found = function(this__3, text__45)
    return__8 = temper.virtual();
  end;
  TemperRegex.methods.find = function(this__4, text__48)
    return__9 = temper.virtual();
  end;
  exports = {};
  exports.TemperRegex = TemperRegex;
  return exports;
end
package.preload["temper-regex-engine/bench"] = function()
  local temper = require('temper-core');
  local RegexNode, TemperRegex, regexToString, TemperRegexNFA, TemperRegexDFA, TemperRegexWalker, TemperRegexNative, parse, Engine__5, SingleResult, EngineResult__8, RegexBench, engines__64, exports;
  RegexNode = temper.import('std/regex', 'RegexNode');
  TemperRegex = temper.import('temper-regex-engine/regex', 'TemperRegex');
  regexToString = temper.import('temper-regex-engine/util', 'regexToString');
  TemperRegexNFA = temper.import('temper-regex-engine/engines/nfa/nfa', 'TemperRegexNFA');
  TemperRegexDFA = temper.import('temper-regex-engine/engines/dfa/dfa', 'TemperRegexDFA');
  TemperRegexWalker = temper.import('temper-regex-engine/engines/walk', 'TemperRegexWalker');
  TemperRegexNative = temper.import('temper-regex-engine/engines/native', 'TemperRegexNative');
  parse = temper.import('temper-regex-parser', 'parse');
  Engine__5 = temper.type('Engine__5');
  Engine__5.methods.invoke = function(this__6, re__68)
    return this__6.cons__66(re__68);
  end;
  Engine__5.constructor = function(this__25, name__71, cons__72)
    this__25.name__65 = name__71;
    this__25.cons__66 = cons__72;
    return nil;
  end;
  Engine__5.get.name = function(this__173)
    return this__173.name__65;
  end;
  Engine__5.get.cons = function(this__177)
    return this__177.cons__66;
  end;
  SingleResult = temper.type('SingleResult');
  SingleResult.methods.toString = function(this__7)
    return temper.concat(this__7.engine__73, ' score: ', temper.float64_tostring(this__7.score__77), ' (found: ', temper.boolean_tostring(this__7.found__76), ') (str: ', this__7.str__74, ') (regex: ', this__7.regex__75, ')');
  end;
  SingleResult.constructor = function(this__29, engine__81, str__82, regex__83, found__84, score__85)
    this__29.engine__73 = engine__81;
    this__29.str__74 = str__82;
    this__29.regex__75 = regex__83;
    this__29.found__76 = found__84;
    this__29.score__77 = score__85;
    return nil;
  end;
  SingleResult.get.engine = function(this__181)
    return this__181.engine__73;
  end;
  SingleResult.get.str = function(this__185)
    return this__185.str__74;
  end;
  SingleResult.get.regex = function(this__189)
    return this__189.regex__75;
  end;
  SingleResult.get.found = function(this__193)
    return this__193.found__76;
  end;
  SingleResult.get.score = function(this__197)
    return this__197.score__77;
  end;
  EngineResult__8 = temper.type('EngineResult__8');
  EngineResult__8.methods.toString = function(this__9)
    local t_453, t_454, t_455, t_456;
    t_453 = this__9.engine__86;
    t_454 = temper.float64_toint(temper.mul(this__9.score__87, 100.0));
    t_455 = temper.int_tofloat64(t_454);
    t_456 = temper.fdiv(t_455, 100.0);
    return temper.concat(t_453, ': ', temper.float64_tostring(t_456));
  end;
  EngineResult__8.constructor = function(this__32, engine__91, score__92)
    this__32.engine__86 = engine__91;
    this__32.score__87 = score__92;
    return nil;
  end;
  EngineResult__8.get.engine = function(this__201)
    return this__201.engine__86;
  end;
  EngineResult__8.get.score = function(this__205)
    return this__205.score__87;
  end;
  RegexBench = temper.type('RegexBench');
  RegexBench.constructor = function(this__10, getTime__101)
    local t_457, t_458, t_459, fn__540, fn__539;
    this__10.time__93 = getTime__101;
    t_457 = temper.listbuilder_constructor();
    this__10.engines__94 = t_457;
    t_458 = temper.listbuilder_constructor();
    this__10.checks__95 = t_458;
    t_459 = temper.listbuilder_constructor();
    this__10.regex__96 = t_459;
    fn__540 = function(r__103)
      return nil;
    end;
    this__10.onSingleResultCallback__97 = fn__540;
    fn__539 = function(r__105)
      return nil;
    end;
    this__10.onEngineResultCallback__98 = fn__539;
    this__10.timePerRunInternal__99 = 50.0;
    return nil;
  end;
  RegexBench.methods.onSingleResult = function(this__11, v__108)
    this__11.onSingleResultCallback__97 = v__108;
    return nil;
  end;
  RegexBench.methods.onEngineResult = function(this__12, v__111)
    this__12.onEngineResultCallback__98 = v__111;
    return nil;
  end;
  RegexBench.methods.addRegexDefaults = function(this__13)
    this__13:addRegexStr('h(?:[eu]l+o|i)');
    this__13:addRegexStr('(a+a)+a');
    this__13:addRegexStr('([Hh][eu]l+l){4}');
    return nil;
  end;
  RegexBench.methods.addCheckDefaults = function(this__14)
    local many_a__117, many_h__118;
    temper.listbuilder_add(this__14.checks__95, 'hello');
    temper.listbuilder_add(this__14.checks__95, 'hi');
    temper.listbuilder_add(this__14.checks__95, 'helo');
    temper.listbuilder_add(this__14.checks__95, 'hullo');
    temper.listbuilder_add(this__14.checks__95, 'hulo');
    temper.listbuilder_add(this__14.checks__95, 'i am going to say hello');
    temper.listbuilder_add(this__14.checks__95, 'abcdefghijklmnopqrstuvwxyz');
    temper.listbuilder_add(this__14.checks__95, 'test');
    temper.listbuilder_add(this__14.checks__95, 'Hell, MI');
    temper.listbuilder_add(this__14.checks__95, 'hydrogen helium carbon nitrognen');
    many_a__117 = 'aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa';
    many_h__118 = 'hullhullhullhullhullhullhullhullhullhullhullhullhullhullhullhullhullhullhullhullhullhullhullhullhullhullhullhullhullhullhullhullhullhullhullhullhullhullhullhullhullhullhullhullhullhullhullhullhullhullhullhullhullhullhullhullhullhullhullhullhullhullhullhullhullhullhullhullhullhullhullhullhullhullhullhullhullhullhullhullhullhullhullhull';
    temper.listbuilder_add(this__14.checks__95, many_a__117);
    temper.listbuilder_add(this__14.checks__95, many_h__118);
    return nil;
  end;
  RegexBench.methods.addEngineDefaults = function(this__15)
    this__15:addEngineTemper();
    this__15:addEngineDFA();
    this__15:addEngineNFA();
    this__15:addEngineWalker();
    return nil;
  end;
  RegexBench.methods.addEngine = function(this__16, name__122, cb__123)
    temper.listbuilder_add(this__16.engines__94, Engine__5(name__122, cb__123));
    return nil;
  end;
  RegexBench.methods.addRegexStr = function(this__17, str__126)
    local t_460;
    t_460 = parse(str__126);
    this__17:addRegex(t_460);
    return nil;
  end;
  RegexBench.methods.addRegex = function(this__18, re__129)
    temper.listbuilder_add(this__18.regex__96, re__129);
    return nil;
  end;
  RegexBench.methods.addEngineTemper = function(this__19)
    local fn__515;
    fn__515 = function(regex__133)
      return TemperRegexNative(regex__133);
    end;
    this__19:addEngine('Temper', fn__515);
    return nil;
  end;
  RegexBench.methods.addEngineDFA = function(this__20)
    local fn__509;
    fn__509 = function(regex__137)
      return TemperRegexDFA(regex__137);
    end;
    this__20:addEngine('DFA', fn__509);
    return nil;
  end;
  RegexBench.methods.addEngineNFA = function(this__21)
    local fn__503;
    fn__503 = function(regex__141)
      return TemperRegexNFA(regex__141);
    end;
    this__21:addEngine('NFA', fn__503);
    return nil;
  end;
  RegexBench.methods.addEngineWalker = function(this__22)
    local fn__497;
    fn__497 = function(regex__145)
      return TemperRegexWalker(regex__145);
    end;
    this__22:addEngine('Walker', fn__497);
    return nil;
  end;
  RegexBench.methods.isFound = function(this__23, tcre__148, check__149)
    return temper.mapped_has(tcre__148:find(check__149), 'full');
  end;
  RegexBench.methods.run = function(this__24)
    local t_461, t_462, t_463, t_464, t_465, t_466, t_467, t_468, t_469, t_470, t_471, t_472, t_473, runs__153, i__154;
    runs__153 = temper.listbuilder_constructor();
    i__154 = 0.0;
    while true do
      local engine__155, count__156, total__157, j__158;
      t_461 = temper.listbuilder_length(this__24.engines__94);
      if not (i__154 < t_461) then
        break;
      else
      end
      t_467 = temper.listed_get(this__24.engines__94, i__154);
      engine__155 = t_467;
      count__156 = 0.0;
      total__157 = 0.0;
      j__158 = 0.0;
      while true do
        local re__159, tcre__160, k__161;
        t_462 = temper.listbuilder_length(this__24.regex__96);
        if not (j__158 < t_462) then
          break;
        else
        end
        t_468 = temper.listed_get(this__24.regex__96, j__158);
        re__159 = t_468;
        tcre__160 = engine__155:invoke(re__159);
        k__161 = 0.0;
        while true do
          local check__162, iters__163, found__164, beginTime__165, endTime__167, ms__168, score__169, thisRun__170;
          t_463 = temper.listbuilder_length(this__24.checks__95);
          if not (k__161 < t_463) then
            break;
          else
          end
          t_469 = temper.listed_get(this__24.checks__95, k__161);
          check__162 = t_469;
          iters__163 = 1.0;
          t_464 = this__24:isFound(tcre__160, check__162);
          found__164 = t_464;
          beginTime__165 = this__24.time__93();
          while true do
            local l__166;
            l__166 = 0.0;
            while (l__166 < iters__163) do
              t_465 = this__24:isFound(tcre__160, check__162);
              found__164 = t_465;
              l__166 = (l__166 + 1.0);
            end
            iters__163 = (iters__163 + iters__163);
            if not temper.float_lt(temper.sub(this__24.time__93(), beginTime__165), this__24.timePerRunInternal__99) then
              break;
            else
            end
          end
          endTime__167 = this__24.time__93();
          ms__168 = temper.sub(endTime__167, beginTime__165);
          t_470 = temper.int_tofloat64(iters__163);
          t_471 = temper.fdiv(t_470, ms__168);
          score__169 = t_471;
          count__156 = temper.add(count__156, 1.0);
          total__157 = temper.add(total__157, score__169);
          thisRun__170 = SingleResult(engine__155.name, check__162, regexToString(re__159), found__164, score__169);
          this__24.onSingleResultCallback__97(thisRun__170);
          temper.listbuilder_add(runs__153, thisRun__170);
          k__161 = (k__161 + 1.0);
        end
        j__158 = (j__158 + 1.0);
      end
      t_473 = this__24.onEngineResultCallback__98;
      t_466 = engine__155.name;
      t_472 = temper.fdiv(total__157, count__156);
      t_473(EngineResult__8(t_466, t_472));
      i__154 = (i__154 + 1.0);
    end
    temper.listbuilder_tolist(runs__153);
    return nil;
  end;
  engines__64 = temper.listbuilder_constructor();
  exports = {};
  exports.SingleResult = SingleResult;
  exports.RegexBench = RegexBench;
  return exports;
end
package.preload["temper-regex-engine/test"] = function()
  local temper = require('temper-core');
  local RegexNode, Capture, CodePart, Special, SpecialSet, CodeRange, ItemizedRegex, CodeSet, Repeat, entire, oneOrMore, optional, Group, Regex, Begin, Dot, End, Digit, Space, Word, CodePoints, Or, Sequence, WordBoundary, TemperRegexNFA, t_474, idStart__25, idNumber__26, word__27, nfa__28, t_475, t_476, found__30, exports;
  RegexNode = temper.import('std/regex', 'RegexNode');
  Capture = temper.import('std/regex', 'Capture');
  CodePart = temper.import('std/regex', 'CodePart');
  Special = temper.import('std/regex', 'Special');
  SpecialSet = temper.import('std/regex', 'SpecialSet');
  CodeRange = temper.import('std/regex', 'CodeRange');
  ItemizedRegex = temper.import('std/regex', 'ItemizedRegex');
  CodeSet = temper.import('std/regex', 'CodeSet');
  Repeat = temper.import('std/regex', 'Repeat');
  entire = temper.import('std/regex', 'entire');
  oneOrMore = temper.import('std/regex', 'oneOrMore');
  optional = temper.import('std/regex', 'optional');
  Group = temper.import('std/regex', 'Group');
  Regex = temper.import('std/regex', 'Regex');
  Begin = temper.import('std/regex', 'Begin');
  Dot = temper.import('std/regex', 'Dot');
  End = temper.import('std/regex', 'End');
  Digit = temper.import('std/regex', 'Digit');
  Space = temper.import('std/regex', 'Space');
  Word = temper.import('std/regex', 'Word');
  CodePoints = temper.import('std/regex', 'CodePoints');
  Or = temper.import('std/regex', 'Or');
  Sequence = temper.import('std/regex', 'Sequence');
  WordBoundary = temper.import('std/regex', 'WordBoundary');
  TemperRegexNFA = temper.import('temper-regex-engine/engines/nfa/nfa', 'TemperRegexNFA');
  t_474 = 0.0;
  idStart__25 = (Or(temper.listof(CodePoints('a'), CodePoints('b'), CodePoints('c'))):compiled()).data;
  idNumber__26 = (Or(temper.listof(CodePoints('1'), CodePoints('2'), CodePoints('3'))):compiled()).data;
  word__27 = Sequence(temper.listof(WordBoundary, idStart__25, idNumber__26, WordBoundary));
  nfa__28 = TemperRegexNFA(word__27);
  temper.log(nfa__28:toString());
  t_475 = nil;
  t_475 = word__27:find('1a b2 c3');
  t_476 = nil;
  t_476 = temper.mapped_get(t_475, 'full');
  found__30 = t_476.value;
  temper.log(temper.concat('Found id: ', found__30));
  exports = {};
  return exports;
end
package.preload["temper-regex-engine/util"] = function()
  local temper = require('temper-core');
  local RegexNode, Capture, CodePoints, Special, CodeRange, CodeSet, Or, Repeat, Sequence, Begin, Dot, End, WordBoundary, Digit, Space, Word, CodePart, SpecialSet, ItemizedRegex, entire, oneOrMore, optional, Group, Regex, regexToString, idString, ord, chr, slice, exports;
  RegexNode = temper.import('std/regex', 'RegexNode');
  Capture = temper.import('std/regex', 'Capture');
  CodePoints = temper.import('std/regex', 'CodePoints');
  Special = temper.import('std/regex', 'Special');
  CodeRange = temper.import('std/regex', 'CodeRange');
  CodeSet = temper.import('std/regex', 'CodeSet');
  Or = temper.import('std/regex', 'Or');
  Repeat = temper.import('std/regex', 'Repeat');
  Sequence = temper.import('std/regex', 'Sequence');
  Begin = temper.import('std/regex', 'Begin');
  Dot = temper.import('std/regex', 'Dot');
  End = temper.import('std/regex', 'End');
  WordBoundary = temper.import('std/regex', 'WordBoundary');
  Digit = temper.import('std/regex', 'Digit');
  Space = temper.import('std/regex', 'Space');
  Word = temper.import('std/regex', 'Word');
  CodePart = temper.import('std/regex', 'CodePart');
  SpecialSet = temper.import('std/regex', 'SpecialSet');
  ItemizedRegex = temper.import('std/regex', 'ItemizedRegex');
  entire = temper.import('std/regex', 'entire');
  oneOrMore = temper.import('std/regex', 'oneOrMore');
  optional = temper.import('std/regex', 'optional');
  Group = temper.import('std/regex', 'Group');
  Regex = temper.import('std/regex', 'Regex');
  regexToString = function(base__57)
    local return__24, t_1, t_2, t_3, t_4, t_5, t_6, t_7, t_8, t_9, t_10, t_11, t_12, t_13, t_14, t_15, t_16, t_17, t_18, t_19, t_20, t_21, t_22, t_23, t_24, t_25, t_26, t_27, t_28, t_29, t_30, t_31, t_32, t_33, t_34, t_35, t_36, ret__59, j__60, fn__489, ret__65, add__64, i__69, fn__488, mod__72, q__73, str__74, pat__75, points__76;
    if temper.instance_of(base__57, Capture) then
      t_13 = temper.cast_to(base__57, Capture);
      t_1 = t_13.name;
      t_2 = regexToString(t_13.item);
      return__24 = temper.concat('(?', t_1, '=', t_2, ')');
    elseif temper.instance_of(base__57, CodePoints) then
      t_14 = temper.cast_to(base__57, CodePoints);
      return__24 = t_14.value;
    elseif temper.instance_of(base__57, CodeSet) then
      t_15 = temper.cast_to(base__57, CodeSet);
      ret__59 = temper.listbuilder_constructor();
      j__60 = 0.0;
      while true do
        local subBase__61;
        t_3 = temper.list_length(t_15.items);
        if not (j__60 < t_3) then
          break;
        else
        end
        t_16 = temper.list_get(t_15.items, j__60);
        subBase__61 = t_16;
        if temper.instance_of(subBase__61, CodeRange) then
          t_17 = temper.cast_to(subBase__61, CodeRange);
          t_18 = temper.string_fromcodepoint(t_17.min);
          t_19 = temper.string_fromcodepoint(t_17.max);
          temper.listbuilder_add(ret__59, temper.concat(t_18, '-', t_19));
        elseif temper.instance_of(subBase__61, CodePoints) then
          t_20 = temper.cast_to(subBase__61, CodePoints);
          temper.listbuilder_add(ret__59, t_20.value);
        else
        end
        j__60 = (j__60 + 1.0);
      end
      fn__489 = function(s__62)
        return s__62;
      end;
      t_4 = temper.listed_join(ret__59, '', fn__489);
      return__24 = temper.concat('[', t_4, ']');
    elseif temper.instance_of(base__57, Or) then
      t_21 = temper.cast_to(base__57, Or);
      ret__65 = temper.mapbuilder_constructor();
      add__64 = function(ent__66)
        local t_37, t_38, t_39, t_40;
        if temper.instance_of(ent__66, Or) then
          local i__68;
          t_39 = temper.cast_to(ent__66, Or);
          i__68 = 0.0;
          while true do
            t_37 = temper.list_length(t_39.items);
            if not (i__68 < t_37) then
              break;
            else
            end
            t_40 = temper.list_get(t_39.items, i__68);
            add__64(t_40);
            i__68 = (i__68 + 1.0);
          end
        else
          t_38 = regexToString(ent__66);
          temper.mapbuilder_set(ret__65, t_38, true);
        end
        return nil;
      end;
      i__69 = 0.0;
      while true do
        t_5 = temper.list_length(t_21.items);
        if not (i__69 < t_5) then
          break;
        else
        end
        t_22 = temper.list_get(t_21.items, i__69);
        add__64(t_22);
        i__69 = (i__69 + 1.0);
      end
      t_6 = temper.mapped_tolist(ret__65);
      fn__488 = function(p__70)
        return p__70.key;
      end;
      return__24 = temper.listed_join(t_6, '|', fn__488);
    elseif temper.instance_of(base__57, Repeat) then
      t_23 = temper.cast_to(base__57, Repeat);
      if (t_23.min == 0.0) then
        t_24 = t_23.max;
        t_25 = (t_24 == 1.0);
      else
        t_25 = false;
      end
      if t_25 then
        mod__72 = '?';
      else
        if (t_23.min == 0.0) then
          t_26 = t_23.max;
          t_27 = (t_26 == temper.null);
        else
          t_27 = false;
        end
        if t_27 then
          mod__72 = '*';
        else
          if (t_23.min == 1.0) then
            t_28 = t_23.max;
            t_29 = (t_28 == temper.null);
          else
            t_29 = false;
          end
          if t_29 then
            mod__72 = '+';
          else
            t_7 = t_23.min;
            t_30 = t_23.max;
            if (t_7 == t_30) then
              t_8 = temper.int_tostring(t_23.min);
              mod__72 = temper.concat('{', t_8, '}');
            else
              t_31 = t_23.max;
              if (t_31 == temper.null) then
                t_9 = temper.int_tostring(t_23.min);
                mod__72 = temper.concat('{', t_9, ',}');
              else
                t_10 = temper.int_tostring(t_23.min);
                t_32 = t_23.max;
                t_33 = temper.cast_to_int(t_32);
                t_11 = temper.int_tostring(t_33);
                mod__72 = temper.concat('{', t_10, ',', t_11, '}');
              end
            end
          end
        end
      end
      if t_23.reluctant then
        q__73 = '?';
      else
        q__73 = '';
      end
      str__74 = regexToString(t_23.item);
      pat__75 = '%';
      t_12 = t_23.item;
      if temper.instance_of(t_12, CodeSet) then
        pat__75 = str__74;
      elseif temper.instance_of(t_12, CodePoints) then
        points__76 = temper.cast_to(t_23.item, CodePoints);
        if (temper.list_length(temper.string_split(points__76.value, '')) == 1.0) then
          pat__75 = str__74;
        else
          pat__75 = temper.concat('(', str__74, ')');
        end
      else
        pat__75 = temper.concat('(', str__74, ')');
      end
      return__24 = temper.concat(pat__75, mod__72, q__73);
    elseif temper.instance_of(base__57, Sequence) then
      t_34 = temper.cast_to(base__57, Sequence);
      if (temper.list_length(t_34.items) == 0.0) then
        return__24 = '';
      elseif (temper.list_length(t_34.items) == 1.0) then
        t_35 = temper.list_get(t_34.items, 0.0);
        return__24 = regexToString(t_35);
      else
        local rec__77, inner__80;
        rec__77 = function(r__78)
          return regexToString(r__78);
        end;
        inner__80 = temper.listed_join(t_34.items, '', rec__77);
        return__24 = temper.concat('(', inner__80, ')');
      end
    elseif temper.instance_of(base__57, Special) then
      t_36 = temper.cast_to(base__57, Special);
      if temper.generic_eq(t_36, Begin) then
        return__24 = '^';
      elseif temper.generic_eq(t_36, Dot) then
        return__24 = '.';
      elseif temper.generic_eq(t_36, End) then
        return__24 = '$';
      elseif temper.generic_eq(t_36, WordBoundary) then
        return__24 = '\\b';
      elseif temper.generic_eq(t_36, Digit) then
        return__24 = '\\d';
      elseif temper.generic_eq(t_36, Space) then
        return__24 = '\\s';
      elseif temper.generic_eq(t_36, Word) then
        return__24 = '\\w';
      else
        temper.bubble();
      end
    else
      temper.bubble();
    end
    return return__24;
  end;
  idString = function(s__81)
    return s__81;
  end;
  ord = function(s__83)
    return temper.string_codeat(s__83, 1.0);
  end;
  chr = function(i__85)
    return temper.string_fromcodepoint(i__85);
  end;
  slice = function(s__87, start__88, end__89)
    local t_41, t_42, p__91, i__92, r__93, i__94;
    p__91 = 1.0;
    i__92 = 0.0;
    while (i__92 < start__88) do
      t_41 = temper.string_next(s__87, p__91);
      p__91 = t_41;
      i__92 = (i__92 + 1.0);
    end
    r__93 = temper.listbuilder_constructor();
    i__94 = start__88;
    while (i__94 < end__89) do
      temper.listbuilder_add(r__93, temper.string_codeat(s__87, p__91));
      t_42 = temper.string_next(s__87, p__91);
      p__91 = t_42;
      i__94 = (i__94 + 1.0);
    end
    return temper.listed_join(r__93, '', chr);
  end;
  exports = {};
  exports.regexToString = regexToString;
  exports.idString = idString;
  exports.ord = ord;
  exports.chr = chr;
  exports.slice = slice;
  return exports;
end
package.preload["temper-regex-engine/engines/native"] = function()
  local temper = require('temper-core');
  local RegexNode, Regex, Capture, CodePart, CodePoints, Special, SpecialSet, CodeRange, ItemizedRegex, CodeSet, Or, Repeat, entire, oneOrMore, optional, Sequence, Group, Begin, Dot, End, WordBoundary, Digit, Space, Word, TemperRegex, TemperRegexNative, exports;
  RegexNode = temper.import('std/regex', 'RegexNode');
  Regex = temper.import('std/regex', 'Regex');
  Capture = temper.import('std/regex', 'Capture');
  CodePart = temper.import('std/regex', 'CodePart');
  CodePoints = temper.import('std/regex', 'CodePoints');
  Special = temper.import('std/regex', 'Special');
  SpecialSet = temper.import('std/regex', 'SpecialSet');
  CodeRange = temper.import('std/regex', 'CodeRange');
  ItemizedRegex = temper.import('std/regex', 'ItemizedRegex');
  CodeSet = temper.import('std/regex', 'CodeSet');
  Or = temper.import('std/regex', 'Or');
  Repeat = temper.import('std/regex', 'Repeat');
  entire = temper.import('std/regex', 'entire');
  oneOrMore = temper.import('std/regex', 'oneOrMore');
  optional = temper.import('std/regex', 'optional');
  Sequence = temper.import('std/regex', 'Sequence');
  Group = temper.import('std/regex', 'Group');
  Begin = temper.import('std/regex', 'Begin');
  Dot = temper.import('std/regex', 'Dot');
  End = temper.import('std/regex', 'End');
  WordBoundary = temper.import('std/regex', 'WordBoundary');
  Digit = temper.import('std/regex', 'Digit');
  Space = temper.import('std/regex', 'Space');
  Word = temper.import('std/regex', 'Word');
  TemperRegex = temper.import('temper-regex-engine/regex', 'TemperRegex');
  TemperRegexNative = temper.type('TemperRegexNative', TemperRegex);
  TemperRegexNative.constructor = function(this__0, re__35)
    local t_0;
    t_0 = Regex(re__35);
    this__0.data__33 = t_0;
    return nil;
  end;
  TemperRegexNative.methods.split = function(this__1, text__38)
    return this__1.data__33:split(text__38);
  end;
  TemperRegexNative.methods.found = function(this__2, text__41)
    return this__2.data__33:found(text__41);
  end;
  TemperRegexNative.methods.find = function(this__3, text__44)
    return this__3.data__33:find(text__44);
  end;
  TemperRegexNative.get.data = function(this__48)
    return this__48.data__33;
  end;
  exports = {};
  exports.TemperRegexNative = TemperRegexNative;
  return exports;
end
package.preload["temper-regex-engine/engines/walk"] = function()
  local temper = require('temper-core');
  local RegexNode, Capture, CodePoints, Special, CodeRange, CodeSet, Or, Repeat, Sequence, Group, Begin, Dot, End, WordBoundary, Digit, Space, Word, CodePart, SpecialSet, ItemizedRegex, entire, oneOrMore, optional, Regex, TemperRegex, chr, Matcher, TemperRegexWalker, isCodePointWordChar__79, exports;
  RegexNode = temper.import('std/regex', 'RegexNode');
  Capture = temper.import('std/regex', 'Capture');
  CodePoints = temper.import('std/regex', 'CodePoints');
  Special = temper.import('std/regex', 'Special');
  CodeRange = temper.import('std/regex', 'CodeRange');
  CodeSet = temper.import('std/regex', 'CodeSet');
  Or = temper.import('std/regex', 'Or');
  Repeat = temper.import('std/regex', 'Repeat');
  Sequence = temper.import('std/regex', 'Sequence');
  Group = temper.import('std/regex', 'Group');
  Begin = temper.import('std/regex', 'Begin');
  Dot = temper.import('std/regex', 'Dot');
  End = temper.import('std/regex', 'End');
  WordBoundary = temper.import('std/regex', 'WordBoundary');
  Digit = temper.import('std/regex', 'Digit');
  Space = temper.import('std/regex', 'Space');
  Word = temper.import('std/regex', 'Word');
  CodePart = temper.import('std/regex', 'CodePart');
  SpecialSet = temper.import('std/regex', 'SpecialSet');
  ItemizedRegex = temper.import('std/regex', 'ItemizedRegex');
  entire = temper.import('std/regex', 'entire');
  oneOrMore = temper.import('std/regex', 'oneOrMore');
  optional = temper.import('std/regex', 'optional');
  Regex = temper.import('std/regex', 'Regex');
  TemperRegex = temper.import('temper-regex-engine/regex', 'TemperRegex');
  chr = temper.import('temper-regex-engine/util', 'chr');
  Matcher = temper.type('Matcher');
  Matcher.constructor = function(this__36, src__113)
    local t_43;
    this__36.str__108 = src__113;
    this__36.head__109 = 1.0;
    t_43 = temper.mapbuilder_constructor();
    this__36.groups__110 = t_43;
    this__36.depth__111 = 0.0;
    return nil;
  end;
  Matcher.methods.advance = function(this__37)
    local t_44;
    t_44 = temper.string_next(this__37.str__108, this__37.head__109);
    this__37.head__109 = t_44;
    return nil;
  end;
  Matcher.methods.setHead = function(this__38, val__118)
    this__38.head__109 = val__118;
    return nil;
  end;
  Matcher.methods.matchCapture = function(this__39, regex__121)
    local return__61, t_45, begin__123, t_46;
    begin__123 = this__39.head__109;
    t_46 = regex__121.item;
    if this__39:matchRegex(t_46) then
      local end__124, list__125, i__126, text__127;
      end__124 = this__39.head__109;
      list__125 = temper.listbuilder_constructor();
      i__126 = begin__123;
      while temper.generic_lt(i__126, end__124) do
        temper.listbuilder_add(list__125, temper.string_codeat(this__39.str__108, i__126));
        t_45 = temper.string_next(this__39.str__108, i__126);
        i__126 = t_45;
      end
      text__127 = temper.string_fromcodepoints(list__125);
      temper.mapbuilder_set(this__39.groups__110, regex__121.name, Group(regex__121.name, text__127, temper.string_countbetween(this__39.str__108, 1.0, begin__123)));
      return__61 = true;
    else
      this__39:setHead(begin__123);
      return__61 = false;
    end
    return return__61;
  end;
  Matcher.methods.matchCodePoints = function(this__40, regex__129)
    local return__62, t_47, t_48, t_49, t_50;
    ::continue_1::
    if (this__40.depth__111 == 0.0) then
      local value__131, init__132, sHead__133;
      value__131 = regex__129.value;
      init__132 = this__40.head__109;
      sHead__133 = 1.0;
      while true do
        local c__134;
        c__134 = temper.string_codeat(value__131, sHead__133);
        if (c__134 == 0.0) then
          return__62 = true;
          goto break_0;
        else
        end
        if (temper.string_codeat(this__40.str__108, this__40.head__109) ~= c__134) then
          this__40:setHead(init__132);
          return__62 = false;
          goto break_0;
        else
        end
        t_47 = temper.string_next(this__40.str__108, this__40.head__109);
        this__40.head__109 = t_47;
        t_48 = temper.string_next(value__131, sHead__133);
        sHead__133 = t_48;
      end
    else
      local value__135, sHead__136;
      value__135 = regex__129.value;
      sHead__136 = 1.0;
      while true do
        local c__137;
        c__137 = temper.string_codeat(value__135, sHead__136);
        if (c__137 == 0.0) then
          t_49 = temper.string_next(this__40.str__108, this__40.head__109);
          this__40.head__109 = t_49;
          return__62 = true;
          goto break_0;
        else
        end
        if (temper.string_codeat(this__40.str__108, this__40.head__109) ~= c__137) then
          return__62 = false;
          goto break_0;
        else
        end
        t_50 = temper.string_next(value__135, sHead__136);
        sHead__136 = t_50;
      end
    end
    ::break_0::return return__62;
  end;
  Matcher.methods.matchDot = function(this__41)
    local return__63;
    if temper.string_hasindex(this__41.str__108, this__41.head__109) then
      this__41:advance();
      return__63 = true;
    else
      return__63 = false;
    end
    return return__63;
  end;
  Matcher.methods.matchDigit = function(this__42)
    local return__64, t_51, code__142;
    ::continue_3::
    if temper.string_hasindex(this__42.str__108, this__42.head__109) then
      return__64 = false;
      goto break_2;
    else
    end
    code__142 = temper.string_codeat(this__42.str__108, this__42.head__109);
    if (48.0 <= code__142) then
      t_51 = (code__142 <= 57.0);
    else
      t_51 = false;
    end
    if t_51 then
      this__42:advance();
      return__64 = true;
    else
      return__64 = false;
    end
    ::break_2::return return__64;
  end;
  Matcher.methods.matchWord = function(this__43)
    local return__65;
    if isCodePointWordChar__79(temper.string_codeat(this__43.str__108, this__43.head__109)) then
      this__43:advance();
      return__65 = true;
    else
      return__65 = false;
    end
    return return__65;
  end;
  Matcher.methods.matchWordBoundary = function(this__44)
    local last__147;
    last__147 = temper.string_prev(this__44.str__108, this__44.head__109);
    return temper.generic_ne(isCodePointWordChar__79(temper.string_codeat(this__44.str__108, last__147)), isCodePointWordChar__79(temper.string_codeat(this__44.str__108, this__44.head__109)));
  end;
  Matcher.methods.matchSpecial = function(this__45, regex__149)
    local return__67, t_52, c__151;
    if temper.generic_eq(regex__149, Begin) then
      t_52 = temper.stringindex_compareto(this__45.head__109, 1.0);
      return__67 = (t_52 == 0.0);
    elseif temper.generic_eq(regex__149, Dot) then
      return__67 = this__45:matchDot();
    elseif temper.generic_eq(regex__149, End) then
      if temper.string_hasindex(this__45.str__108, this__45.head__109) then
        return__67 = false;
      else
        return__67 = true;
      end
    elseif temper.generic_eq(regex__149, WordBoundary) then
      return__67 = this__45:matchWordBoundary();
    elseif temper.generic_eq(regex__149, Digit) then
      return__67 = this__45:matchDigit();
    elseif temper.generic_eq(regex__149, Space) then
      c__151 = temper.string_codeat(this__45.str__108, this__45.head__109);
      if (c__151 == 32.0) then
        return__67 = true;
      elseif (c__151 == 9.0) then
        return__67 = true;
      elseif (c__151 == 13.0) then
        return__67 = true;
      else
        return__67 = (c__151 == 10.0);
      end
    elseif temper.generic_eq(regex__149, Word) then
      return__67 = this__45:matchWord();
    else
      return__67 = false;
    end
    return return__67;
  end;
  Matcher.methods.matchCodeRange = function(this__46, regex__153)
    local return__68, t_53, t_54, n__155;
    ::continue_5::n__155 = temper.string_codeat(this__46.str__108, this__46.head__109);
    if (n__155 == 0.0) then
      return__68 = false;
      goto break_4;
    else
    end
    if (regex__153.min <= n__155) then
      t_53 = regex__153.max;
      t_54 = (n__155 <= t_53);
    else
      t_54 = false;
    end
    if t_54 then
      this__46:advance();
      return__68 = true;
    else
      return__68 = false;
    end
    ::break_4::return return__68;
  end;
  Matcher.methods.matchCodeSet = function(this__47, regex__157)
    local return__69, t_55, t_56, t_57, t_58, begin__159;
    ::continue_7::begin__159 = this__47.head__109;
    if regex__157.negated then
      local i__160;
      i__160 = 0.0;
      while true do
        local res__161;
        t_55 = temper.list_length(regex__157.items);
        if not (i__160 < t_55) then
          break;
        else
        end
        this__47.depth__111 = (this__47.depth__111 + 1.0);
        t_57 = temper.list_get(regex__157.items, i__160);
        res__161 = this__47:matchRegex(t_57);
        this__47.depth__111 = (this__47.depth__111 - 1.0);
        if res__161 then
          return__69 = false;
          goto break_6;
        else
        end
        this__47:setHead(begin__159);
        i__160 = (i__160 + 1.0);
      end
      this__47:advance();
      return__69 = true;
    else
      local i__162;
      i__162 = 0.0;
      while true do
        local res__163;
        t_56 = temper.list_length(regex__157.items);
        if not (i__162 < t_56) then
          break;
        else
        end
        this__47.depth__111 = (this__47.depth__111 + 1.0);
        t_58 = temper.list_get(regex__157.items, i__162);
        res__163 = this__47:matchRegex(t_58);
        this__47.depth__111 = (this__47.depth__111 - 1.0);
        if res__163 then
          return__69 = true;
          goto break_6;
        else
        end
        this__47:setHead(begin__159);
        i__162 = (i__162 + 1.0);
      end
      return__69 = false;
    end
    ::break_6::return return__69;
  end;
  Matcher.methods.matchOr = function(this__48, regex__165)
    local return__70, t_59, t_60, start__167, i__168;
    ::continue_9::start__167 = this__48.head__109;
    i__168 = 0.0;
    while true do
      t_59 = temper.list_length(regex__165.items);
      if not (i__168 < t_59) then
        break;
      else
      end
      t_60 = temper.list_get(regex__165.items, i__168);
      if this__48:matchRegex(t_60) then
        return__70 = true;
        goto break_8;
      else
      end
      i__168 = (i__168 + 1.0);
    end
    this__48:setHead(start__167);
    return__70 = false;
    ::break_8::return return__70;
  end;
  Matcher.methods.matchRepeat = function(this__49, regex__170)
    local return__71, t_61, t_62, t_63, t_64, t_65, t_66, t_67, start__172, i__173;
    ::continue_11::start__172 = this__49.head__109;
    i__173 = 0.0;
    while true do
      t_61 = regex__170.min;
      if not (i__173 < t_61) then
        break;
      else
      end
      t_62 = regex__170.item;
      if not this__49:matchRegex(t_62) then
        this__49:setHead(start__172);
        return__71 = false;
        goto break_10;
      else
      end
      i__173 = (i__173 + 1.0);
    end
    t_66 = regex__170.max;
    if (t_66 == temper.null) then
      while true do
        local mid__174;
        mid__174 = this__49.head__109;
        t_63 = regex__170.item;
        if not this__49:matchRegex(t_63) then
          this__49:setHead(mid__174);
          return__71 = true;
          goto break_10;
        else
        end
      end
    else
      local maxNoNull__175, i__176;
      t_67 = regex__170.max;
      maxNoNull__175 = temper.cast_to_int(t_67);
      t_64 = regex__170.min;
      i__176 = t_64;
      while (i__176 < maxNoNull__175) do
        local mid__177;
        mid__177 = this__49.head__109;
        t_65 = regex__170.item;
        if not this__49:matchRegex(t_65) then
          this__49:setHead(mid__177);
          return__71 = true;
          goto break_10;
        else
        end
        i__176 = (i__176 + 1.0);
      end
      return__71 = true;
    end
    ::break_10::return return__71;
  end;
  Matcher.methods.matchSequence = function(this__50, regex__179)
    local return__72, t_68, t_69, start__181, i__182;
    ::continue_13::start__181 = this__50.head__109;
    i__182 = 0.0;
    while true do
      t_68 = temper.list_length(regex__179.items);
      if not (i__182 < t_68) then
        break;
      else
      end
      t_69 = temper.list_get(regex__179.items, i__182);
      if not this__50:matchRegex(t_69) then
        this__50:setHead(start__181);
        return__72 = false;
        goto break_12;
      else
      end
      i__182 = (i__182 + 1.0);
    end
    return__72 = true;
    ::break_12::return return__72;
  end;
  Matcher.methods.matchRegex = function(this__51, regex__184)
    local return__73, t_70, t_71, t_72, t_73, t_74, t_75, t_76, t_77;
    if temper.instance_of(regex__184, Capture) then
      t_70 = temper.cast_to(regex__184, Capture);
      return__73 = this__51:matchCapture(t_70);
    elseif temper.instance_of(regex__184, CodePoints) then
      t_71 = temper.cast_to(regex__184, CodePoints);
      return__73 = this__51:matchCodePoints(t_71);
    elseif temper.instance_of(regex__184, CodeRange) then
      t_72 = temper.cast_to(regex__184, CodeRange);
      return__73 = this__51:matchCodeRange(t_72);
    elseif temper.instance_of(regex__184, CodeSet) then
      t_73 = temper.cast_to(regex__184, CodeSet);
      return__73 = this__51:matchCodeSet(t_73);
    elseif temper.instance_of(regex__184, Or) then
      t_74 = temper.cast_to(regex__184, Or);
      return__73 = this__51:matchOr(t_74);
    elseif temper.instance_of(regex__184, Repeat) then
      t_75 = temper.cast_to(regex__184, Repeat);
      return__73 = this__51:matchRepeat(t_75);
    elseif temper.instance_of(regex__184, Sequence) then
      t_76 = temper.cast_to(regex__184, Sequence);
      return__73 = this__51:matchSequence(t_76);
    elseif temper.instance_of(regex__184, Special) then
      t_77 = temper.cast_to(regex__184, Special);
      return__73 = this__51:matchSpecial(t_77);
    else
      return__73 = false;
    end
    return return__73;
  end;
  Matcher.methods.resetGroups = function(this__52, regex__187)
    local t_78, t_79, t_80, t_81, t_82, t_83, t_84, t_85, t_86, t_87, i__189, i__190;
    if temper.instance_of(regex__187, Capture) then
      t_82 = temper.cast_to(regex__187, Capture);
      temper.mapbuilder_set(this__52.groups__110, t_82.name, Group(t_82.name, '', -1.0));
      t_78 = t_82.item;
      this__52:resetGroups(t_78);
    elseif temper.instance_of(regex__187, Repeat) then
      t_83 = temper.cast_to(regex__187, Repeat);
      t_79 = t_83.item;
      this__52:resetGroups(t_79);
    elseif temper.instance_of(regex__187, Or) then
      t_84 = temper.cast_to(regex__187, Or);
      i__189 = 0.0;
      while true do
        t_80 = temper.list_length(t_84.items);
        if not (i__189 < t_80) then
          break;
        else
        end
        t_85 = temper.list_get(t_84.items, i__189);
        this__52:resetGroups(t_85);
        i__189 = (i__189 + 1.0);
      end
    elseif temper.instance_of(regex__187, Sequence) then
      t_86 = temper.cast_to(regex__187, Sequence);
      i__190 = 0.0;
      while true do
        t_81 = temper.list_length(t_86.items);
        if not (i__190 < t_81) then
          break;
        else
        end
        t_87 = temper.list_get(t_86.items, i__190);
        this__52:resetGroups(t_87);
        i__190 = (i__190 + 1.0);
      end
    else
    end
    return nil;
  end;
  Matcher.get.str = function(this__216)
    return this__216.str__108;
  end;
  Matcher.get.head = function(this__220)
    return this__220.head__109;
  end;
  Matcher.get.groups = function(this__224)
    return this__224.groups__110;
  end;
  Matcher.get.depth = function(this__228)
    return this__228.depth__111;
  end;
  TemperRegexWalker = temper.type('TemperRegexWalker', TemperRegex);
  TemperRegexWalker.constructor = function(this__53, re__193)
    this__53.data__191 = re__193;
    return nil;
  end;
  TemperRegexWalker.methods.split = function(this__54, text__196)
    local t_88, t_89, t_90, t_91, t_92, cur__198, ret__199, i__200;
    t_92 = temper.listbuilder_constructor();
    cur__198 = t_92;
    ret__199 = temper.listbuilder_constructor();
    i__200 = 1.0;
    while true do
      local m__201;
      if not temper.string_hasindex(text__196, i__200) then
        break;
      else
      end
      m__201 = Matcher(text__196);
      m__201:setHead(i__200);
      if m__201:matchRegex(this__54.data__191) then
        t_88 = m__201.head;
        i__200 = t_88;
        temper.listbuilder_add(ret__199, temper.listed_join(cur__198, '', chr));
        t_89 = temper.listbuilder_constructor();
        cur__198 = t_89;
      else
        t_90 = temper.string_codeat(text__196, i__200);
        temper.listbuilder_add(cur__198, t_90);
        t_91 = temper.string_next(text__196, i__200);
        i__200 = t_91;
      end
    end
    temper.listbuilder_add(ret__199, temper.listed_join(cur__198, '', chr));
    return temper.listbuilder_tolist(ret__199);
  end;
  TemperRegexWalker.methods.found = function(this__55, text__203)
    local return__77, t_93, i__205;
    ::continue_15::i__205 = 1.0;
    while true do
      local m__206;
      if not temper.string_hasindex(text__203, i__205) then
        break;
      else
      end
      m__206 = Matcher(text__203);
      m__206:setHead(i__205);
      m__206:resetGroups(this__55.data__191);
      if m__206:matchRegex(this__55.data__191) then
        return__77 = true;
        goto break_14;
      else
      end
      t_93 = temper.string_next(text__203, i__205);
      i__205 = t_93;
    end
    return__77 = false;
    ::break_14::return return__77;
  end;
  TemperRegexWalker.methods.find = function(this__56, text__208)
    local return__78, t_94, t_95, t_96, start__210, i__211;
    ::continue_17::start__210 = 0.0;
    i__211 = 1.0;
    while true do
      local m__212;
      if not temper.string_hasindex(text__208, i__211) then
        break;
      else
      end
      m__212 = Matcher(text__208);
      m__212:setHead(i__211);
      m__212:resetGroups(this__56.data__191);
      if m__212:matchRegex(this__56.data__191) then
        if not temper.mapped_has(m__212.groups, 'full') then
          local full__213;
          full__213 = temper.listbuilder_constructor();
          while true do
            t_94 = m__212.head;
            if not (temper.stringindex_compareto(i__211, t_94) ~= 0.0) then
              break;
            else
            end
            temper.listbuilder_add(full__213, temper.string_codeat(text__208, i__211));
            t_95 = temper.string_next(text__208, i__211);
            i__211 = t_95;
          end
          temper.mapbuilder_set(m__212.groups, 'full', Group('full', temper.listed_join(full__213, '', chr), start__210));
        else
        end
        return__78 = m__212.groups;
        goto break_16;
      else
      end
      start__210 = (start__210 + 1.0);
      t_96 = temper.string_next(text__208, i__211);
      i__211 = t_96;
    end
    return__78 = temper.map_constructor(temper.listof());
    ::break_16::return return__78;
  end;
  TemperRegexWalker.get.data = function(this__256)
    return this__256.data__191;
  end;
  isCodePointWordChar__79 = function(code__106)
    local return__57, t_97, t_98, t_99;
    if (48.0 <= code__106) then
      t_97 = (code__106 <= 57.0);
    else
      t_97 = false;
    end
    if t_97 then
      return__57 = true;
    else
      if (65.0 <= code__106) then
        t_98 = (code__106 <= 90.0);
      else
        t_98 = false;
      end
      if t_98 then
        return__57 = true;
      else
        if (97.0 <= code__106) then
          t_99 = (code__106 <= 122.0);
        else
          t_99 = false;
        end
        if t_99 then
          return__57 = true;
        else
          return__57 = (code__106 == 95.0);
        end
      end
    end
    return return__57;
  end;
  exports = {};
  exports.Matcher = Matcher;
  exports.TemperRegexWalker = TemperRegexWalker;
  return exports;
end
package.preload["temper-regex-engine/engines/patterns"] = function()
  local temper = require('temper-core');
  local TemperRegex, TemperRegexPatterns, exports;
  TemperRegex = temper.import('temper-regex-engine/regex', 'TemperRegex');
  TemperRegexPatterns = temper.type('TemperRegexPatterns', TemperRegex);
  TemperRegexPatterns.constructor = function(this__1, strs__9, isMatch__10)
    this__1.tries__6 = strs__9;
    this__1.check__7 = isMatch__10;
    return nil;
  end;
  TemperRegexPatterns.methods.found = function(this__2, str__13)
    local return__4, t_277, t_278, t_279, i__15;
    ::continue_29::i__15 = 0.0;
    while true do
      t_277 = temper.list_length(this__2.tries__6);
      if not (i__15 < t_277) then
        break;
      else
      end
      t_279 = this__2.check__7;
      t_278 = temper.list_get(this__2.tries__6, i__15);
      if t_279(str__13, t_278) then
        return__4 = true;
        goto break_28;
      else
      end
      i__15 = (i__15 + 1.0);
    end
    return__4 = false;
    ::break_28::return return__4;
  end;
  TemperRegexPatterns.get.tries = function(this__18)
    return this__18.tries__6;
  end;
  TemperRegexPatterns.get.check = function(this__22)
    return this__22.check__7;
  end;
  exports = {};
  exports.TemperRegexPatterns = TemperRegexPatterns;
  return exports;
end
package.preload["temper-regex-engine/engines/nfa/engine"] = function()
  local temper = require('temper-core');
  local RegexNode, Capture, CodePart, CodePoints, Special, SpecialSet, CodeRange, ItemizedRegex, CodeSet, Or, Repeat, entire, oneOrMore, optional, Sequence, Regex, Begin, Dot, End, WordBoundary, Digit, Space, Word, Group, State, Next, Stack, StackStart, StackSlot, ord, chr, idString, slice, Matcher, StartGroupMatcher, EndGroupMatcher, EpsilonMatcher, BeginMatcher, EndMatcher, WordBoundaryMatcher, WordClassMatcher, SpaceClassMatcher, AnyMatcher, BitSetMatcher, CharCodeMatcher, CharMatcher, Engine, exports;
  RegexNode = temper.import('std/regex', 'RegexNode');
  Capture = temper.import('std/regex', 'Capture');
  CodePart = temper.import('std/regex', 'CodePart');
  CodePoints = temper.import('std/regex', 'CodePoints');
  Special = temper.import('std/regex', 'Special');
  SpecialSet = temper.import('std/regex', 'SpecialSet');
  CodeRange = temper.import('std/regex', 'CodeRange');
  ItemizedRegex = temper.import('std/regex', 'ItemizedRegex');
  CodeSet = temper.import('std/regex', 'CodeSet');
  Or = temper.import('std/regex', 'Or');
  Repeat = temper.import('std/regex', 'Repeat');
  entire = temper.import('std/regex', 'entire');
  oneOrMore = temper.import('std/regex', 'oneOrMore');
  optional = temper.import('std/regex', 'optional');
  Sequence = temper.import('std/regex', 'Sequence');
  Regex = temper.import('std/regex', 'Regex');
  Begin = temper.import('std/regex', 'Begin');
  Dot = temper.import('std/regex', 'Dot');
  End = temper.import('std/regex', 'End');
  WordBoundary = temper.import('std/regex', 'WordBoundary');
  Digit = temper.import('std/regex', 'Digit');
  Space = temper.import('std/regex', 'Space');
  Word = temper.import('std/regex', 'Word');
  Group = temper.import('std/regex', 'Group');
  State = temper.import('temper-regex-engine/engines/nfa/state', 'State');
  Next = temper.import('temper-regex-engine/engines/nfa/state', 'Next');
  Stack = temper.import('temper-regex-engine/engines/nfa/stack', 'Stack');
  StackStart = temper.import('temper-regex-engine/engines/nfa/stack', 'StackStart');
  StackSlot = temper.import('temper-regex-engine/engines/nfa/stack', 'StackSlot');
  ord = temper.import('temper-regex-engine/util', 'ord');
  chr = temper.import('temper-regex-engine/util', 'chr');
  idString = temper.import('temper-regex-engine/util', 'idString');
  slice = temper.import('temper-regex-engine/util', 'slice');
  Matcher = temper.import('temper-regex-engine/engines/nfa/matcher', 'Matcher');
  StartGroupMatcher = temper.import('temper-regex-engine/engines/nfa/matcher', 'StartGroupMatcher');
  EndGroupMatcher = temper.import('temper-regex-engine/engines/nfa/matcher', 'EndGroupMatcher');
  EpsilonMatcher = temper.import('temper-regex-engine/engines/nfa/matcher', 'EpsilonMatcher');
  BeginMatcher = temper.import('temper-regex-engine/engines/nfa/matcher', 'BeginMatcher');
  EndMatcher = temper.import('temper-regex-engine/engines/nfa/matcher', 'EndMatcher');
  WordBoundaryMatcher = temper.import('temper-regex-engine/engines/nfa/matcher', 'WordBoundaryMatcher');
  WordClassMatcher = temper.import('temper-regex-engine/engines/nfa/matcher', 'WordClassMatcher');
  SpaceClassMatcher = temper.import('temper-regex-engine/engines/nfa/matcher', 'SpaceClassMatcher');
  AnyMatcher = temper.import('temper-regex-engine/engines/nfa/matcher', 'AnyMatcher');
  BitSetMatcher = temper.import('temper-regex-engine/engines/nfa/matcher', 'BitSetMatcher');
  CharCodeMatcher = temper.import('temper-regex-engine/engines/nfa/matcher', 'CharCodeMatcher');
  CharMatcher = temper.import('temper-regex-engine/engines/nfa/matcher', 'CharMatcher');
  Engine = temper.type('Engine');
  Engine.constructor = function(this__29)
    local t_111, t_112, t_113, t_114;
    t_111 = temper.listbuilder_constructor();
    this__29.states__105 = t_111;
    t_112 = this__29:newState();
    this__29.startState__106 = t_112;
    t_113 = this__29:newState();
    this__29.endState__107 = t_113;
    t_114 = EpsilonMatcher();
    this__29.epsilon__108 = t_114;
    return nil;
  end;
  Engine.methods.opt = function(this__30)
    local cur__113, t_115;
    cur__113 = this__30;
    t_115 = cur__113:optDeadCode();
    cur__113 = t_115;
    return cur__113;
  end;
  Engine.methods.optDeadCode = function(this__31)
    local unopt__117, opt__118, map__119, visit__116;
    unopt__117 = this__31;
    opt__118 = Engine();
    map__119 = temper.mapbuilder_constructor();
    visit__116 = function(state__120)
      local return__43, t_116, t_117, t_118, t_119, t_120, t_121, t_122, t_123, t_124, t_125, t_126, t_127, t_128, t_129, t_130, optId__122, local_131, local_132, local_133, outState__123, i__124;
      ::continue_19::local_131, local_132, local_133 = temper.pcall(function()
        t_116 = state__120.id;
        t_129 = temper.mapped_get(map__119, t_116);
        optId__122 = t_129;
      end);
      if local_131 then
      else
        optId__122 = -1.0;
      end
      if (optId__122 >= 0.0) then
        t_117 = opt__118.states;
        return__43 = temper.listed_get(t_117, optId__122);
        goto break_18;
      else
      end
      t_118 = unopt__117.startState;
      if temper.generic_eq(state__120, t_118) then
        t_119 = opt__118.startState;
        outState__123 = t_119;
      else
        t_120 = unopt__117.endState;
        if temper.generic_eq(state__120, t_120) then
          t_121 = opt__118.endState;
          outState__123 = t_121;
        else
          t_122 = opt__118:newState();
          outState__123 = t_122;
        end
      end
      t_123 = state__120.id;
      t_124 = outState__123.id;
      temper.mapbuilder_set(map__119, t_123, t_124);
      i__124 = 0.0;
      while true do
        local next__125;
        t_125 = temper.listbuilder_length(state__120.next);
        if not (i__124 < t_125) then
          break;
        else
        end
        t_130 = temper.listed_get(state__120.next, i__124);
        next__125 = t_130;
        t_126 = next__125.matcher;
        t_127 = next__125.toState;
        t_128 = visit__116(t_127);
        outState__123:addNext(t_126, t_128);
        i__124 = (i__124 + 1.0);
      end
      return__43 = outState__123;
      ::break_18::return return__43;
    end;
    visit__116(this__31.startState__106);
    return opt__118;
  end;
  Engine.methods.optEpsilonEllison = function(this__32)
    local unopt__129, opt__130, map__131, visit__128;
    unopt__129 = this__32;
    opt__130 = Engine();
    map__131 = temper.mapbuilder_constructor();
    visit__128 = function(state__132)
      local return__45, t_135, t_136, t_137, t_138, t_139, t_140, t_141, t_142, t_143, t_144, t_145, t_146, t_147, t_148, optId__135, local_149, local_150, local_151, outState__136, added__137, count__138, isFinal__139, add__134, i__145;
      ::continue_21::local_149, local_150, local_151 = temper.pcall(function()
        t_135 = state__132.id;
        t_145 = temper.mapped_get(map__131, t_135);
        optId__135 = t_145;
      end);
      if local_149 then
      else
        optId__135 = -1.0;
      end
      if (optId__135 >= 0.0) then
        t_136 = opt__130.states;
        return__45 = temper.listed_get(t_136, optId__135);
        goto break_20;
      else
      end
      t_137 = unopt__129.startState;
      if temper.generic_eq(state__132, t_137) then
        t_138 = opt__130.startState;
        t_146 = t_138;
      else
        t_139 = unopt__129.endState;
        if temper.generic_eq(state__132, t_139) then
          t_140 = opt__130.endState;
          t_146 = t_140;
        else
          t_141 = opt__130:newState();
          t_146 = t_141;
        end
      end
      outState__136 = t_146;
      t_142 = state__132.id;
      t_143 = outState__136.id;
      temper.mapbuilder_set(map__131, t_142, t_143);
      added__137 = temper.densebitvector_constructor(0.0);
      count__138 = 0.0;
      isFinal__139 = false;
      add__134 = function(matcher__140, toState__141)
        local return__46, t_153, t_154, t_155, t_156, t_157, t_158, t_159, t_160;
        ::continue_23::t_153 = unopt__129.epsilon;
        if temper.generic_eq(matcher__140, t_153) then
          local i__143;
          t_154 = toState__141.id;
          if temper.densebitvector_get(added__137, t_154) then
            return__46 = nil;
            goto break_22;
          else
          end
          t_155 = toState__141.id;
          temper.densebitvector_set(added__137, t_155, true);
          if (toState__141.id == 1.0) then
            isFinal__139 = true;
            return__46 = nil;
            goto break_22;
          else
          end
          i__143 = 0.0;
          while true do
            local next__144;
            t_156 = temper.listbuilder_length(toState__141.next);
            if not (i__143 < t_156) then
              break;
            else
            end
            t_160 = temper.listed_get(toState__141.next, i__143);
            next__144 = t_160;
            t_157 = next__144.matcher;
            t_158 = next__144.toState;
            add__134(t_157, t_158);
            i__143 = (i__143 + 1.0);
          end
        else
          count__138 = (count__138 + 1.0);
          t_159 = visit__128(toState__141);
          outState__136:addNext(matcher__140, t_159);
        end
        return__46 = nil;
        ::break_22::return return__46;
      end;
      i__145 = 0.0;
      while true do
        local next__146;
        t_144 = temper.listbuilder_length(state__132.next);
        if not (i__145 < t_144) then
          break;
        else
        end
        t_147 = temper.listed_get(state__132.next, i__145);
        next__146 = t_147;
        add__134(next__146.matcher, next__146.toState);
        i__145 = (i__145 + 1.0);
      end
      if (count__138 == 0.0) then
        t_148 = true;
      else
        t_148 = isFinal__139;
      end
      if t_148 then
        return__45 = opt__130.endState;
        goto break_20;
      else
      end
      return__45 = outState__136;
      ::break_20::return return__45;
    end;
    visit__128(this__32.startState__106);
    return opt__130;
  end;
  Engine.methods.newState = function(this__33)
    local ret__149;
    ret__149 = State(temper.listbuilder_length(this__33.states__105));
    temper.listbuilder_add(this__33.states__105, ret__149);
    return ret__149;
  end;
  Engine.methods.replace = function(this__34, str__151, replace__152)
    local t_161, t_162, t_163, t_164, t_165, t_166, t_167, t_168, t_169, t_170, t_171, t_172, t_173, t_174, t_175, t_176, t_177, t_178, pairs__154, pending__155, codePoints__156, stackStart__157, badNext__158, last__159, ret__160, fulls__161, i__162, cur__176, j__177, groups__178, keys__179, i__180, out__185, t_179, i__186;
    pairs__154 = temper.mapbuilder_constructor();
    pending__155 = temper.mapbuilder_constructor();
    codePoints__156 = temper.listed_map(temper.string_split(str__151, ''), ord);
    stackStart__157 = StackStart();
    badNext__158 = Next(this__34.endState__107, this__34.epsilon__108);
    last__159 = 0.0;
    ret__160 = temper.listbuilder_constructor();
    fulls__161 = temper.listbuilder_constructor();
    i__162 = 0.0;
    while true do
      local stack__163;
      t_161 = temper.list_length(codePoints__156);
      if not (i__162 < t_161) then
        break;
      else
      end
      t_162 = StackSlot(i__162, this__34.startState__106, stackStart__157);
      stack__163 = t_162;
      while temper.generic_ne(stack__163, stackStart__157) do
        local index__164, state__165, next__170, len__171, c__172;
        index__164 = stack__163.index;
        state__165 = stack__163.state;
        t_163 = stack__163.next;
        stack__163 = t_163;
        if (state__165.id == this__34.endState__107.id) then
          local cur__166, j__167, str__168, j__169;
          cur__166 = temper.listbuilder_constructor();
          j__167 = last__159;
          while (j__167 < i__162) do
            temper.listbuilder_add(cur__166, temper.listed_getor(codePoints__156, j__167, 0.0));
            j__167 = (j__167 + 1.0);
          end
          temper.listbuilder_add(ret__160, temper.listed_join(cur__166, '', chr));
          str__168 = temper.listbuilder_constructor();
          j__169 = i__162;
          while (j__169 < index__164) do
            temper.listbuilder_add(str__168, temper.listed_getor(codePoints__156, j__169, 0.0));
            j__169 = (j__169 + 1.0);
          end
          temper.listbuilder_add(fulls__161, Group('full', temper.listed_join(str__168, '', chr), i__162));
          i__162 = index__164;
          last__159 = index__164;
          break;
        else
        end
        next__170 = state__165.next;
        len__171 = temper.listbuilder_length(next__170);
        c__172 = 0.0;
        while (c__172 < len__171) do
          local matcher__174, toState__175;
          t_164 = temper.listed_getor(next__170, c__172, badNext__158);
          matcher__174 = t_164.matcher;
          toState__175 = t_164.toState;
          if matcher__174:matches(codePoints__156, index__164) then
            if temper.instance_of(matcher__174, StartGroupMatcher) then
              t_172 = temper.cast_to(matcher__174, StartGroupMatcher);
              temper.mapbuilder_set(pending__155, t_172.name, index__164);
            elseif temper.instance_of(matcher__174, EndGroupMatcher) then
              t_173 = temper.cast_to(matcher__174, EndGroupMatcher);
              t_165 = t_173.name;
              t_174 = temper.mapped_get(pending__155, t_173.name);
              temper.mapbuilder_set(pairs__154, t_165, temper.pair_constructor(t_174, index__164));
            else
            end
            t_166 = StackSlot((index__164 + matcher__174:width()), toState__175, stack__163);
            stack__163 = t_166;
          else
          end
          c__172 = (c__172 + 1.0);
        end
      end
      i__162 = (i__162 + 1.0);
    end
    cur__176 = temper.listbuilder_constructor();
    j__177 = last__159;
    while true do
      t_167 = temper.list_length(codePoints__156);
      if not (j__177 < t_167) then
        break;
      else
      end
      temper.listbuilder_add(cur__176, temper.listed_getor(codePoints__156, j__177, 0.0));
      j__177 = (j__177 + 1.0);
    end
    temper.listbuilder_add(ret__160, temper.listed_join(cur__176, '', chr));
    groups__178 = temper.mapbuilder_constructor();
    keys__179 = temper.mapped_keys(pairs__154);
    i__180 = 0.0;
    while true do
      local key__181, val__182, str__183, j__184;
      t_168 = temper.listed_length(keys__179);
      if not (i__180 < t_168) then
        break;
      else
      end
      t_175 = temper.listed_get(keys__179, i__180);
      key__181 = t_175;
      t_176 = temper.mapped_get(pairs__154, key__181);
      val__182 = t_176;
      str__183 = temper.listbuilder_constructor();
      t_169 = val__182.key;
      j__184 = t_169;
      while true do
        t_170 = val__182.value;
        if not (j__184 < t_170) then
          break;
        else
        end
        temper.listbuilder_add(str__183, temper.listed_getor(codePoints__156, j__184, 0.0));
        j__184 = (j__184 + 1.0);
      end
      temper.mapbuilder_set(groups__178, key__181, Group(key__181, temper.listed_join(str__183, '', chr), val__182.key));
      i__180 = (i__180 + 1.0);
    end
    out__185 = temper.listbuilder_constructor();
    t_179 = temper.listed_get(ret__160, 0.0);
    temper.listbuilder_add(out__185, t_179);
    i__186 = 1.0;
    while true do
      t_171 = temper.listbuilder_length(ret__160);
      if not (i__186 < t_171) then
        break;
      else
      end
      t_177 = temper.listed_get(fulls__161, (i__186 - 1.0));
      temper.mapbuilder_set(groups__178, 'full', t_177);
      temper.listbuilder_add(out__185, replace__152(groups__178));
      t_178 = temper.listed_get(ret__160, i__186);
      temper.listbuilder_add(out__185, t_178);
      i__186 = (i__186 + 1.0);
    end
    return temper.listed_join(out__185, '', idString);
  end;
  Engine.methods.split = function(this__35, str__188)
    local t_180, t_181, t_182, t_183, t_184, t_185, codePoints__190, stackStart__191, badNext__192, last__193, ret__194, i__195, cur__207, j__208;
    codePoints__190 = temper.listed_map(temper.string_split(str__188, ''), ord);
    stackStart__191 = StackStart();
    badNext__192 = Next(this__35.endState__107, this__35.epsilon__108);
    last__193 = 0.0;
    ret__194 = temper.listbuilder_constructor();
    i__195 = 0.0;
    while true do
      local stack__196;
      t_180 = temper.list_length(codePoints__190);
      if not (i__195 < t_180) then
        break;
      else
      end
      t_181 = StackSlot(i__195, this__35.startState__106, stackStart__191);
      stack__196 = t_181;
      while temper.generic_ne(stack__196, stackStart__191) do
        local index__197, state__198, next__201, len__202, c__203;
        index__197 = stack__196.index;
        state__198 = stack__196.state;
        t_182 = stack__196.next;
        stack__196 = t_182;
        if (state__198.id == this__35.endState__107.id) then
          local cur__199, j__200;
          cur__199 = temper.listbuilder_constructor();
          j__200 = last__193;
          while (j__200 < i__195) do
            temper.listbuilder_add(cur__199, temper.listed_getor(codePoints__190, j__200, 0.0));
            j__200 = (j__200 + 1.0);
          end
          i__195 = (index__197 - 1.0);
          last__193 = index__197;
          temper.listbuilder_add(ret__194, temper.listed_join(cur__199, '', chr));
          break;
        else
        end
        next__201 = state__198.next;
        len__202 = temper.listbuilder_length(next__201);
        c__203 = 0.0;
        while (c__203 < len__202) do
          local matcher__205, toState__206;
          t_183 = temper.listed_getor(next__201, c__203, badNext__192);
          matcher__205 = t_183.matcher;
          toState__206 = t_183.toState;
          if matcher__205:matches(codePoints__190, index__197) then
            t_184 = StackSlot((index__197 + matcher__205:width()), toState__206, stack__196);
            stack__196 = t_184;
          else
          end
          c__203 = (c__203 + 1.0);
        end
      end
      i__195 = (i__195 + 1.0);
    end
    cur__207 = temper.listbuilder_constructor();
    j__208 = last__193;
    while true do
      t_185 = temper.list_length(codePoints__190);
      if not (j__208 < t_185) then
        break;
      else
      end
      temper.listbuilder_add(cur__207, temper.listed_getor(codePoints__190, j__208, 0.0));
      j__208 = (j__208 + 1.0);
    end
    temper.listbuilder_add(ret__194, temper.listed_join(cur__207, '', chr));
    return ret__194;
  end;
  Engine.methods.found = function(this__36, str__210)
    local return__50, t_186, t_187, t_188, t_189, t_190, codePoints__212, stackStart__213, badNext__214, i__215;
    ::continue_25::codePoints__212 = temper.listed_map(temper.string_split(str__210, ''), ord);
    stackStart__213 = StackStart();
    badNext__214 = Next(this__36.endState__107, this__36.epsilon__108);
    i__215 = 0.0;
    while true do
      local stack__216;
      t_186 = temper.list_length(codePoints__212);
      if not (i__215 < t_186) then
        break;
      else
      end
      t_187 = StackSlot(i__215, this__36.startState__106, stackStart__213);
      stack__216 = t_187;
      while temper.generic_ne(stack__216, stackStart__213) do
        local index__217, state__218, next__219, len__220, c__221;
        index__217 = stack__216.index;
        state__218 = stack__216.state;
        t_188 = stack__216.next;
        stack__216 = t_188;
        if (state__218.id == this__36.endState__107.id) then
          return__50 = true;
          goto break_24;
        else
        end
        next__219 = state__218.next;
        len__220 = temper.listbuilder_length(next__219);
        c__221 = 0.0;
        while (c__221 < len__220) do
          local matcher__223, toState__224;
          t_189 = temper.listed_getor(next__219, c__221, badNext__214);
          matcher__223 = t_189.matcher;
          toState__224 = t_189.toState;
          if matcher__223:matches(codePoints__212, index__217) then
            t_190 = StackSlot((index__217 + matcher__223:width()), toState__224, stack__216);
            stack__216 = t_190;
          else
          end
          c__221 = (c__221 + 1.0);
        end
      end
      i__215 = (i__215 + 1.0);
    end
    return__50 = false;
    ::break_24::return return__50;
  end;
  Engine.methods.find = function(this__37, str__226)
    local return__51, t_191, t_192, t_193, t_194, t_195, t_196, t_197, t_198, t_199, t_200, t_201, t_202, t_203, t_204, pairs__228, pending__229, codePoints__230, stackStart__231, badNext__232, i__233;
    ::continue_27::pairs__228 = temper.mapbuilder_constructor();
    pending__229 = temper.mapbuilder_constructor();
    codePoints__230 = temper.listed_map(temper.string_split(str__226, ''), ord);
    stackStart__231 = StackStart();
    badNext__232 = Next(this__37.endState__107, this__37.epsilon__108);
    i__233 = 0.0;
    while true do
      local stack__234;
      t_191 = temper.list_length(codePoints__230);
      if not (i__233 < t_191) then
        break;
      else
      end
      t_192 = StackSlot(i__233, this__37.startState__106, stackStart__231);
      stack__234 = t_192;
      while temper.generic_ne(stack__234, stackStart__231) do
        local index__235, state__236, next__246, len__247, c__248;
        index__235 = stack__234.index;
        state__236 = stack__234.state;
        t_193 = stack__234.next;
        stack__234 = t_193;
        if (state__236.id == this__37.endState__107.id) then
          local ret__237, keys__238, i__239;
          ret__237 = temper.mapbuilder_constructor();
          keys__238 = temper.mapped_keys(pairs__228);
          i__239 = 0.0;
          while true do
            local key__240, val__241, str__242, j__243;
            t_194 = temper.listed_length(keys__238);
            if not (i__239 < t_194) then
              break;
            else
            end
            t_200 = temper.listed_get(keys__238, i__239);
            key__240 = t_200;
            t_201 = temper.mapped_get(pairs__228, key__240);
            val__241 = t_201;
            str__242 = temper.listbuilder_constructor();
            t_195 = val__241.key;
            j__243 = t_195;
            while true do
              t_196 = val__241.value;
              if not (j__243 < t_196) then
                break;
              else
              end
              temper.listbuilder_add(str__242, temper.listed_getor(codePoints__230, j__243, 0.0));
              j__243 = (j__243 + 1.0);
            end
            temper.mapbuilder_set(ret__237, key__240, Group(key__240, temper.listed_join(str__242, '', chr), val__241.key));
            i__239 = (i__239 + 1.0);
          end
          if not temper.mapped_has(ret__237, 'full') then
            local str__244, j__245;
            str__244 = temper.listbuilder_constructor();
            j__245 = i__233;
            while (j__245 < index__235) do
              temper.listbuilder_add(str__244, temper.listed_getor(codePoints__230, j__245, 0.0));
              j__245 = (j__245 + 1.0);
            end
            temper.mapbuilder_set(ret__237, 'full', Group('full', temper.listed_join(str__244, '', chr), i__233));
          else
          end
          return__51 = ret__237;
          goto break_26;
        else
        end
        next__246 = state__236.next;
        len__247 = temper.listbuilder_length(next__246);
        c__248 = 0.0;
        while (c__248 < len__247) do
          local matcher__250, toState__251;
          t_197 = temper.listed_getor(next__246, c__248, badNext__232);
          matcher__250 = t_197.matcher;
          toState__251 = t_197.toState;
          if matcher__250:matches(codePoints__230, index__235) then
            if temper.instance_of(matcher__250, StartGroupMatcher) then
              t_202 = temper.cast_to(matcher__250, StartGroupMatcher);
              temper.mapbuilder_set(pending__229, t_202.name, index__235);
            elseif temper.instance_of(matcher__250, EndGroupMatcher) then
              t_203 = temper.cast_to(matcher__250, EndGroupMatcher);
              t_198 = t_203.name;
              t_204 = temper.mapped_get(pending__229, t_203.name);
              temper.mapbuilder_set(pairs__228, t_198, temper.pair_constructor(t_204, index__235));
            else
            end
            t_199 = StackSlot((index__235 + matcher__250:width()), toState__251, stack__234);
            stack__234 = t_199;
          else
          end
          c__248 = (c__248 + 1.0);
        end
      end
      i__233 = (i__233 + 1.0);
    end
    return__51 = temper.map_constructor(temper.listof());
    ::break_26::return return__51;
  end;
  Engine.methods.toString = function(this__38)
    local count__254, t_205, fn__1333, inner__255;
    count__254 = 0.0;
    t_205 = this__38.states__105;
    fn__1333 = function(state__256)
      local name__258, t_206, fn__1326;
      name__258 = temper.concat('q', temper.int_tostring(state__256.id));
      t_206 = state__256.next;
      fn__1326 = function(next__259)
        local line__261, nexts__262, t_207;
        line__261 = temper.int_tostring(count__254);
        count__254 = (count__254 + 1.0);
        nexts__262 = temper.int_tostring(next__259.toState.id);
        t_207 = next__259.matcher:toString();
        return temper.concat('\n  ', name__258, ' -> q', nexts__262, ' [label="', t_207, '"];');
      end;
      return temper.listed_join(t_206, '', fn__1326);
    end;
    inner__255 = temper.listed_join(t_205, '', fn__1333);
    return temper.concat('digraph {\n  rankdir="LR";', inner__255, '\n}');
  end;
  Engine.methods.toDotSub = function(this__39, gname__264, color__265)
    local count__267, used__268, t_208, fn__1309, inner__269, t_213, fn__1308, decls__277;
    count__267 = 0.0;
    used__268 = temper.mapbuilder_constructor();
    t_208 = this__39.states__105;
    fn__1309 = function(state__270)
      local name__272, t_209, t_210, fn__1299;
      name__272 = temper.concat('q', temper.int_tostring(state__270.id));
      t_209 = state__270.id;
      temper.mapbuilder_set(used__268, t_209, true);
      t_210 = state__270.next;
      fn__1299 = function(next__273)
        local line__275, nexts__276, t_211, t_212;
        line__275 = temper.int_tostring(count__267);
        count__267 = (count__267 + 1.0);
        nexts__276 = temper.int_tostring(next__273.toState.id);
        t_211 = next__273.toState.id;
        temper.mapbuilder_set(used__268, t_211, true);
        t_212 = next__273.matcher:toString();
        return temper.concat('\n    ', gname__264, '_', name__272, ' -> ', gname__264, '_q', nexts__276, ' [label="', t_212, '"];');
      end;
      return temper.listed_join(t_210, '', fn__1299);
    end;
    inner__269 = temper.listed_join(t_208, '', fn__1309);
    t_213 = this__39.states__105;
    fn__1308 = function(state__278)
      local return__58, t_214, t_215, t_216, local_217, local_218, local_219;
      local_217, local_218, local_219 = temper.pcall(function()
        t_214 = state__278.id;
        t_215 = temper.mapped_get(used__268, t_214);
        t_216 = t_215;
      end);
      if local_217 then
      else
        t_216 = false;
      end
      if t_216 then
        local name__280, label__281, shape__282;
        name__280 = temper.concat('q', temper.int_tostring(state__278.id));
        if (state__278.id == 0.0) then
          label__281 = 'start';
        elseif (state__278.id == 1.0) then
          label__281 = 'end';
        else
          label__281 = name__280;
        end
        shape__282 = 'ellipse';
        return__58 = temper.concat('\n    ', gname__264, '_', name__280, ' [shape="', shape__282, '"] [label="', label__281, '"];');
      else
        return__58 = '';
      end
      return return__58;
    end;
    decls__277 = temper.listed_join(t_213, '', fn__1308);
    return temper.concat('subgraph ', gname__264, ' {\n    node [style=filled color="', color__265, '"];\n    color="#E7E7E7";\n    label="NFA";\n    rankdir="LR";', decls__277, inner__269, '\n  }');
  end;
  Engine.get.states = function(this__285)
    return this__285.states__105;
  end;
  Engine.get.startState = function(this__289)
    return this__289.startState__106;
  end;
  Engine.get.endState = function(this__293)
    return this__293.endState__107;
  end;
  Engine.get.epsilon = function(this__297)
    return this__297.epsilon__108;
  end;
  exports = {};
  exports.Engine = Engine;
  return exports;
end
package.preload["temper-regex-engine/engines/nfa/nfa"] = function()
  local temper = require('temper-core');
  local RegexNode, Capture, CodePoints, Special, CodeRange, CodeSet, Or, Repeat, Sequence, Begin, Dot, End, WordBoundary, Digit, Space, Word, CodePart, SpecialSet, ItemizedRegex, entire, oneOrMore, optional, Group, Regex, TemperRegex, regexToString, Engine, State, Matcher, CharCodeMatcher, EpsilonMatcher, BeginMatcher, EndMatcher, WordBoundaryMatcher, WordClassMatcher, SpaceClassMatcher, AnyMatcher, BitSetMatcher, StartGroupMatcher, EndGroupMatcher, CharMatcher, TemperRegexNFA, exports;
  RegexNode = temper.import('std/regex', 'RegexNode');
  Capture = temper.import('std/regex', 'Capture');
  CodePoints = temper.import('std/regex', 'CodePoints');
  Special = temper.import('std/regex', 'Special');
  CodeRange = temper.import('std/regex', 'CodeRange');
  CodeSet = temper.import('std/regex', 'CodeSet');
  Or = temper.import('std/regex', 'Or');
  Repeat = temper.import('std/regex', 'Repeat');
  Sequence = temper.import('std/regex', 'Sequence');
  Begin = temper.import('std/regex', 'Begin');
  Dot = temper.import('std/regex', 'Dot');
  End = temper.import('std/regex', 'End');
  WordBoundary = temper.import('std/regex', 'WordBoundary');
  Digit = temper.import('std/regex', 'Digit');
  Space = temper.import('std/regex', 'Space');
  Word = temper.import('std/regex', 'Word');
  CodePart = temper.import('std/regex', 'CodePart');
  SpecialSet = temper.import('std/regex', 'SpecialSet');
  ItemizedRegex = temper.import('std/regex', 'ItemizedRegex');
  entire = temper.import('std/regex', 'entire');
  oneOrMore = temper.import('std/regex', 'oneOrMore');
  optional = temper.import('std/regex', 'optional');
  Group = temper.import('std/regex', 'Group');
  Regex = temper.import('std/regex', 'Regex');
  TemperRegex = temper.import('temper-regex-engine/regex', 'TemperRegex');
  regexToString = temper.import('temper-regex-engine/util', 'regexToString');
  Engine = temper.import('temper-regex-engine/engines/nfa/engine', 'Engine');
  State = temper.import('temper-regex-engine/engines/nfa/state', 'State');
  Matcher = temper.import('temper-regex-engine/engines/nfa/matcher', 'Matcher');
  CharCodeMatcher = temper.import('temper-regex-engine/engines/nfa/matcher', 'CharCodeMatcher');
  EpsilonMatcher = temper.import('temper-regex-engine/engines/nfa/matcher', 'EpsilonMatcher');
  BeginMatcher = temper.import('temper-regex-engine/engines/nfa/matcher', 'BeginMatcher');
  EndMatcher = temper.import('temper-regex-engine/engines/nfa/matcher', 'EndMatcher');
  WordBoundaryMatcher = temper.import('temper-regex-engine/engines/nfa/matcher', 'WordBoundaryMatcher');
  WordClassMatcher = temper.import('temper-regex-engine/engines/nfa/matcher', 'WordClassMatcher');
  SpaceClassMatcher = temper.import('temper-regex-engine/engines/nfa/matcher', 'SpaceClassMatcher');
  AnyMatcher = temper.import('temper-regex-engine/engines/nfa/matcher', 'AnyMatcher');
  BitSetMatcher = temper.import('temper-regex-engine/engines/nfa/matcher', 'BitSetMatcher');
  StartGroupMatcher = temper.import('temper-regex-engine/engines/nfa/matcher', 'StartGroupMatcher');
  EndGroupMatcher = temper.import('temper-regex-engine/engines/nfa/matcher', 'EndGroupMatcher');
  CharMatcher = temper.import('temper-regex-engine/engines/nfa/matcher', 'CharMatcher');
  TemperRegexNFA = temper.type('TemperRegexNFA', TemperRegex);
  TemperRegexNFA.constructor = function(this__21, regex__78)
    local t_221, t_222, t_223, t_224;
    t_221 = Engine();
    this__21.engine__76 = t_221;
    t_222 = this__21.engine__76.startState;
    t_223 = this__21.engine__76.endState;
    this__21:buildRegex(regex__78, t_222, t_223);
    t_224 = this__21.engine__76:opt();
    this__21.engine__76 = t_224;
    return nil;
  end;
  TemperRegexNFA.methods.buildRegex = function(this__22, regex__81, input__82, output__83)
    local t_225, t_226, t_227, t_228, t_229, t_230, t_231, t_232, t_233, t_234, t_235, t_236, t_237, t_238, t_239, t_240, t_241, t_242, t_243, t_244, t_245, t_246, t_247, t_248, t_249, t_250, t_251, t_252, t_253, t_254, t_255, t_256, t_257, t_258, t_259, t_260, t_261, t_262, t_263, t_264, t_265, t_266, t_267, t_268, t_269, t_270, t_271, t_272, t_273, t_274, t_275, t_276, split__87, lastState__88, i__89, bitset__91, j__92, i__97, lastState__98, i__99, nextState__104, j__105, bitset__107, i__108;
    if temper.instance_of(regex__81, Capture) then
      local mid1__85, mid2__86;
      t_259 = temper.cast_to(regex__81, Capture);
      mid1__85 = this__22.engine__76:newState();
      mid2__86 = this__22.engine__76:newState();
      t_225 = StartGroupMatcher(t_259.name);
      input__82:addNext(t_225, mid1__85);
      t_226 = t_259.item;
      this__22:buildRegex(t_226, mid1__85, mid2__86);
      mid2__86:addNext(EndGroupMatcher(t_259.name), output__83);
    elseif temper.instance_of(regex__81, CodePoints) then
      t_260 = temper.cast_to(regex__81, CodePoints);
      split__87 = temper.string_split(t_260.value, '');
      lastState__88 = input__82;
      i__89 = 0.0;
      while true do
        t_227 = temper.list_length(split__87);
        if not (i__89 < t_227) then
          break;
        else
        end
        t_228 = temper.list_length(split__87);
        if (i__89 == (t_228 - 1.0)) then
          t_261 = temper.list_get(split__87, i__89);
          t_229 = CharMatcher(t_261);
          lastState__88:addNext(t_229, output__83);
        else
          local curState__90;
          curState__90 = this__22.engine__76:newState();
          t_262 = temper.list_get(split__87, i__89);
          t_230 = CharMatcher(t_262);
          lastState__88:addNext(t_230, curState__90);
          lastState__88 = curState__90;
        end
        i__89 = (i__89 + 1.0);
      end
    elseif temper.instance_of(regex__81, CodeSet) then
      t_263 = temper.cast_to(regex__81, CodeSet);
      bitset__91 = temper.densebitvector_constructor(0.0);
      j__92 = 0.0;
      while true do
        local subRegex__93, split__95, i__96;
        t_231 = temper.list_length(t_263.items);
        if not (j__92 < t_231) then
          break;
        else
        end
        t_264 = temper.list_get(t_263.items, j__92);
        subRegex__93 = t_264;
        if temper.instance_of(subRegex__93, CodeRange) then
          local i__94;
          t_265 = temper.cast_to(subRegex__93, CodeRange);
          t_232 = t_265.min;
          i__94 = t_232;
          while true do
            t_233 = t_265.max;
            if not (i__94 <= t_233) then
              break;
            else
            end
            temper.densebitvector_set(bitset__91, i__94, true);
            i__94 = (i__94 + 1.0);
          end
        elseif temper.instance_of(subRegex__93, CodePoints) then
          t_266 = temper.cast_to(subRegex__93, CodePoints);
          split__95 = temper.string_split(t_266.value, '');
          i__96 = 0.0;
          while true do
            t_234 = temper.list_length(split__95);
            if not (i__96 < t_234) then
              break;
            else
            end
            t_267 = temper.list_get(split__95, i__96);
            temper.densebitvector_set(bitset__91, temper.string_codeat(t_267, 1.0), true);
            i__96 = (i__96 + 1.0);
          end
        else
        end
        j__92 = (j__92 + 1.0);
      end
      t_235 = BitSetMatcher(bitset__91, not t_263.negated);
      input__82:addNext(t_235, output__83);
    elseif temper.instance_of(regex__81, Or) then
      t_268 = temper.cast_to(regex__81, Or);
      i__97 = 0.0;
      while true do
        t_236 = temper.list_length(t_268.items);
        if not (i__97 < t_236) then
          break;
        else
        end
        t_269 = temper.list_get(t_268.items, i__97);
        this__22:buildRegex(t_269, input__82, output__83);
        i__97 = (i__97 + 1.0);
      end
    elseif temper.instance_of(regex__81, Repeat) then
      t_270 = temper.cast_to(regex__81, Repeat);
      lastState__98 = input__82;
      i__99 = 0.0;
      while true do
        local curState__100;
        t_237 = t_270.min;
        if not (i__99 < t_237) then
          break;
        else
        end
        curState__100 = this__22.engine__76:newState();
        t_238 = t_270.item;
        this__22:buildRegex(t_238, lastState__98, curState__100);
        lastState__98 = curState__100;
        i__99 = (i__99 + 1.0);
      end
      t_271 = t_270.max;
      if (t_271 ~= temper.null) then
        local max__101, i__102;
        t_272 = t_270.max;
        max__101 = temper.cast_to_int(t_272);
        t_239 = t_270.min;
        i__102 = t_239;
        while (i__102 < max__101) do
          local curState__103;
          curState__103 = this__22.engine__76:newState();
          if t_270.reluctant then
            t_240 = t_270.item;
            this__22:buildRegex(t_240, lastState__98, curState__103);
            t_241 = this__22.engine__76.epsilon;
            lastState__98:addNext(t_241, output__83);
          else
            t_242 = this__22.engine__76.epsilon;
            lastState__98:addNext(t_242, output__83);
            t_243 = t_270.item;
            this__22:buildRegex(t_243, lastState__98, curState__103);
          end
          lastState__98 = curState__103;
          i__102 = (i__102 + 1.0);
        end
        t_244 = this__22.engine__76.epsilon;
        lastState__98:addNext(t_244, output__83);
      elseif t_270.reluctant then
        t_245 = t_270.item;
        this__22:buildRegex(t_245, lastState__98, lastState__98);
        t_246 = this__22.engine__76.epsilon;
        lastState__98:addNext(t_246, output__83);
      else
        t_247 = this__22.engine__76.epsilon;
        lastState__98:addNext(t_247, output__83);
        t_248 = t_270.item;
        this__22:buildRegex(t_248, lastState__98, lastState__98);
      end
    elseif temper.instance_of(regex__81, Sequence) then
      t_273 = temper.cast_to(regex__81, Sequence);
      nextState__104 = output__83;
      t_249 = temper.list_length(t_273.items);
      j__105 = (t_249 - 1.0);
      while (j__105 >= 0.0) do
        local curState__106;
        if (j__105 == 0.0) then
          t_274 = input__82;
        else
          t_250 = this__22.engine__76:newState();
          t_274 = t_250;
        end
        curState__106 = t_274;
        t_275 = temper.list_get(t_273.items, j__105);
        this__22:buildRegex(t_275, curState__106, nextState__104);
        nextState__104 = curState__106;
        j__105 = (j__105 - 1.0);
      end
      if (temper.list_length(t_273.items) == 0.0) then
        t_251 = this__22.engine__76.epsilon;
        input__82:addNext(t_251, nextState__104);
      else
      end
    elseif temper.instance_of(regex__81, Special) then
      t_276 = temper.cast_to(regex__81, Special);
      if temper.generic_eq(t_276, Begin) then
        t_252 = BeginMatcher();
        input__82:addNext(t_252, output__83);
      elseif temper.generic_eq(t_276, Dot) then
        t_253 = AnyMatcher();
        input__82:addNext(t_253, output__83);
      elseif temper.generic_eq(t_276, End) then
        t_254 = EndMatcher();
        input__82:addNext(t_254, output__83);
      elseif temper.generic_eq(t_276, WordBoundary) then
        t_255 = WordBoundaryMatcher();
        input__82:addNext(t_255, output__83);
      elseif temper.generic_eq(t_276, Digit) then
        bitset__107 = temper.densebitvector_constructor(64.0);
        i__108 = 48.0;
        while (i__108 <= 57.0) do
          temper.densebitvector_set(bitset__107, i__108, true);
          i__108 = (i__108 + 1.0);
        end
        t_256 = BitSetMatcher(bitset__107, true);
        input__82:addNext(t_256, output__83);
      elseif temper.generic_eq(t_276, Space) then
        t_257 = SpaceClassMatcher();
        input__82:addNext(t_257, output__83);
      elseif temper.generic_eq(t_276, Word) then
        t_258 = WordClassMatcher();
        input__82:addNext(t_258, output__83);
      else
        temper.bubble();
      end
    else
    end
    return nil;
  end;
  TemperRegexNFA.methods.replace = function(this__23, text__110, format__111)
    return this__23.engine__76:replace(text__110, format__111);
  end;
  TemperRegexNFA.methods.split = function(this__24, text__114)
    return this__24.engine__76:split(text__114);
  end;
  TemperRegexNFA.methods.found = function(this__25, text__117)
    return this__25.engine__76:found(text__117);
  end;
  TemperRegexNFA.methods.find = function(this__26, text__120)
    return this__26.engine__76:find(text__120);
  end;
  TemperRegexNFA.methods.toString = function(this__27)
    return this__27.engine__76:toString();
  end;
  TemperRegexNFA.get.engine = function(this__126)
    return this__126.engine__76;
  end;
  exports = {};
  exports.TemperRegexNFA = TemperRegexNFA;
  return exports;
end
package.preload["temper-regex-engine/engines/nfa/state"] = function()
  local temper = require('temper-core');
  local Matcher, Next, State, exports;
  Matcher = temper.import('temper-regex-engine/engines/nfa/matcher', 'Matcher');
  Next = temper.type('Next');
  Next.constructor = function(this__4, toState__13, matcher__14)
    this__4.toState__10 = toState__13;
    this__4.matcher__11 = matcher__14;
    return nil;
  end;
  Next.get.toState = function(this__40)
    return this__40.toState__10;
  end;
  Next.get.matcher = function(this__44)
    return this__44.matcher__11;
  end;
  State = temper.type('State');
  State.constructor = function(this__1, identify__18)
    local t_105;
    this__1.id__15 = identify__18;
    t_105 = temper.listbuilder_constructor();
    this__1.next__16 = t_105;
    return nil;
  end;
  State.methods.addNext = function(this__2, matcher__21, toState__22)
    temper.listbuilder_add(this__2.next__16, Next(toState__22, matcher__21));
    return nil;
  end;
  State.methods.addNextFirst = function(this__3, matcher__25, toState__26)
    local t_106, t_107, t_108, oldNext__28, t_109, i__29;
    oldNext__28 = this__3.next__16;
    t_109 = temper.listbuilder_constructor();
    this__3.next__16 = t_109;
    temper.listbuilder_add(this__3.next__16, Next(toState__26, matcher__25));
    i__29 = 0.0;
    while true do
      t_106 = temper.listbuilder_length(oldNext__28);
      if not (i__29 < t_106) then
        break;
      else
      end
      t_108 = this__3.next__16;
      t_107 = temper.listed_get(oldNext__28, i__29);
      temper.listbuilder_add(t_108, t_107);
      i__29 = (i__29 + 1.0);
    end
    return nil;
  end;
  State.get.id = function(this__32)
    return this__32.id__15;
  end;
  State.get.next = function(this__36)
    return this__36.next__16;
  end;
  exports = {};
  exports.Next = Next;
  exports.State = State;
  return exports;
end
package.preload["temper-regex-engine/engines/nfa/matcher"] = function()
  local temper = require('temper-core');
  local ord, Matcher, BeginMatcher, EndMatcher, WordBoundaryMatcher, WordClassMatcher, SpaceClassMatcher, AnyMatcher, BitSetMatcher, CharCodeMatcher, StartGroupMatcher, EndGroupMatcher, CharMatcher, EpsilonMatcher, isCodePointWordChar__102, exports;
  ord = temper.import('temper-regex-engine/util', 'ord');
  Matcher = temper.type('Matcher');
  Matcher.methods.matches = function(this__11, str__107, index__108)
    return__49 = temper.virtual();
  end;
  Matcher.methods.toString = function(this__12)
    return__50 = temper.virtual();
  end;
  Matcher.methods.width = function(this__13)
    return 1.0;
  end;
  BeginMatcher = temper.type('BeginMatcher', Matcher);
  BeginMatcher.methods.matches = function(this__14, str__115, index__116)
    return (index__116 == 0.0);
  end;
  BeginMatcher.methods.toString = function(this__15)
    return '^';
  end;
  BeginMatcher.methods.width = function(this__16)
    return 0.0;
  end;
  BeginMatcher.constructor = function(this__52)
    return nil;
  end;
  EndMatcher = temper.type('EndMatcher', Matcher);
  EndMatcher.methods.matches = function(this__17, str__124, index__125)
    local t_100;
    t_100 = temper.list_length(str__124);
    return (index__125 == t_100);
  end;
  EndMatcher.methods.toString = function(this__18)
    return '$';
  end;
  EndMatcher.methods.width = function(this__19)
    return 0.0;
  end;
  EndMatcher.constructor = function(this__57)
    return nil;
  end;
  WordBoundaryMatcher = temper.type('WordBoundaryMatcher', Matcher);
  WordBoundaryMatcher.methods.matches = function(this__20, str__133, index__134)
    local code1__136, code2__137;
    code1__136 = temper.listed_getor(str__133, (index__134 - 1.0), -1.0);
    code2__137 = temper.listed_getor(str__133, index__134, -1.0);
    return temper.generic_ne(isCodePointWordChar__102(code1__136), isCodePointWordChar__102(code2__137));
  end;
  WordBoundaryMatcher.methods.toString = function(this__21)
    return '\\b';
  end;
  WordBoundaryMatcher.methods.width = function(this__22)
    return 0.0;
  end;
  WordBoundaryMatcher.constructor = function(this__62)
    return nil;
  end;
  WordClassMatcher = temper.type('WordClassMatcher', Matcher);
  WordClassMatcher.methods.matches = function(this__23, str__144, index__145)
    local code__147;
    code__147 = temper.listed_getor(str__144, index__145, -1.0);
    return isCodePointWordChar__102(code__147);
  end;
  WordClassMatcher.methods.toString = function(this__24)
    return '\\w';
  end;
  WordClassMatcher.constructor = function(this__67)
    return nil;
  end;
  SpaceClassMatcher = temper.type('SpaceClassMatcher', Matcher);
  SpaceClassMatcher.methods.matches = function(this__25, str__152, index__153)
    local return__73, code__155;
    code__155 = temper.listed_getor(str__152, index__153, -1.0);
    if (code__155 == 9.0) then
      return__73 = true;
    elseif (code__155 == 10.0) then
      return__73 = true;
    elseif (code__155 == 11.0) then
      return__73 = true;
    elseif (code__155 == 13.0) then
      return__73 = true;
    else
      return__73 = (code__155 == 32.0);
    end
    return return__73;
  end;
  SpaceClassMatcher.methods.toString = function(this__26)
    return '\\s';
  end;
  SpaceClassMatcher.constructor = function(this__71)
    return nil;
  end;
  AnyMatcher = temper.type('AnyMatcher', Matcher);
  AnyMatcher.methods.matches = function(this__27, str__160, index__161)
    local t_101;
    t_101 = temper.list_length(str__160);
    return (index__161 ~= t_101);
  end;
  AnyMatcher.methods.toString = function(this__28)
    return '.';
  end;
  AnyMatcher.constructor = function(this__75)
    return nil;
  end;
  BitSetMatcher = temper.type('BitSetMatcher', Matcher);
  BitSetMatcher.methods.matches = function(this__29, str__169, index__170)
    local c__172;
    c__172 = temper.listed_getor(str__169, index__170, -1.0);
    return temper.generic_eq(temper.densebitvector_get(this__29.bitset__166, c__172), this__29.want__167);
  end;
  BitSetMatcher.methods.toString = function(this__30)
    local return__82;
    if this__30.want__167 then
      return__82 = '[^...]';
    else
      return__82 = '[...]';
    end
    return return__82;
  end;
  BitSetMatcher.constructor = function(this__79, bitset__176, want__177)
    this__79.bitset__166 = bitset__176;
    this__79.want__167 = want__177;
    return nil;
  end;
  BitSetMatcher.get.bitset = function(this__236)
    return this__236.bitset__166;
  end;
  BitSetMatcher.get.want = function(this__240)
    return this__240.want__167;
  end;
  CharCodeMatcher = temper.type('CharCodeMatcher', Matcher);
  CharCodeMatcher.constructor = function(this__31, point__180)
    this__31.code__178 = point__180;
    return nil;
  end;
  CharCodeMatcher.methods.matches = function(this__32, str__183, index__184)
    local c__186;
    c__186 = temper.listed_getor(str__183, index__184, -1.0);
    return (c__186 == this__32.code__178);
  end;
  CharCodeMatcher.methods.toString = function(this__33)
    return temper.concat('#', temper.int_tostring(this__33.code__178));
  end;
  CharCodeMatcher.get.code = function(this__244)
    return this__244.code__178;
  end;
  StartGroupMatcher = temper.type('StartGroupMatcher', Matcher);
  StartGroupMatcher.constructor = function(this__34, str__191)
    this__34.name__189 = str__191;
    return nil;
  end;
  StartGroupMatcher.methods.matches = function(this__35, str__194, index__195)
    return true;
  end;
  StartGroupMatcher.methods.toString = function(this__36)
    return temper.concat('<', this__36.name__189, '>');
  end;
  StartGroupMatcher.methods.width = function(this__37)
    return 0.0;
  end;
  StartGroupMatcher.get.name = function(this__248)
    return this__248.name__189;
  end;
  EndGroupMatcher = temper.type('EndGroupMatcher', Matcher);
  EndGroupMatcher.constructor = function(this__38, str__203)
    this__38.name__201 = str__203;
    return nil;
  end;
  EndGroupMatcher.methods.matches = function(this__39, str__206, index__207)
    return true;
  end;
  EndGroupMatcher.methods.toString = function(this__40)
    return temper.concat('</', this__40.name__201, '>');
  end;
  EndGroupMatcher.methods.width = function(this__41)
    return 0.0;
  end;
  EndGroupMatcher.get.name = function(this__252)
    return this__252.name__201;
  end;
  CharMatcher = temper.type('CharMatcher', Matcher);
  CharMatcher.constructor = function(this__42, str__216)
    this__42.char__213 = str__216;
    this__42.code__214 = ord(str__216);
    return nil;
  end;
  CharMatcher.methods.matches = function(this__43, str__219, index__220)
    local c__222;
    c__222 = temper.listed_getor(str__219, index__220, -1.0);
    return (c__222 == this__43.code__214);
  end;
  CharMatcher.methods.toString = function(this__44)
    return this__44.char__213;
  end;
  CharMatcher.get.char = function(this__256)
    return this__256.char__213;
  end;
  CharMatcher.get.code = function(this__260)
    return this__260.code__214;
  end;
  EpsilonMatcher = temper.type('EpsilonMatcher', Matcher);
  EpsilonMatcher.methods.matches = function(this__45, str__226, index__227)
    return true;
  end;
  EpsilonMatcher.methods.toString = function(this__46)
    return '\xce\xb5';
  end;
  EpsilonMatcher.methods.width = function(this__47)
    return 0.0;
  end;
  EpsilonMatcher.constructor = function(this__97)
    return nil;
  end;
  isCodePointWordChar__102 = function(code__104)
    local return__48, t_102, t_103, t_104;
    if (48.0 <= code__104) then
      t_102 = (code__104 <= 57.0);
    else
      t_102 = false;
    end
    if t_102 then
      return__48 = true;
    else
      if (65.0 <= code__104) then
        t_103 = (code__104 <= 90.0);
      else
        t_103 = false;
      end
      if t_103 then
        return__48 = true;
      else
        if (97.0 <= code__104) then
          t_104 = (code__104 <= 122.0);
        else
          t_104 = false;
        end
        if t_104 then
          return__48 = true;
        else
          return__48 = (code__104 == 95.0);
        end
      end
    end
    return return__48;
  end;
  exports = {};
  exports.Matcher = Matcher;
  exports.BeginMatcher = BeginMatcher;
  exports.EndMatcher = EndMatcher;
  exports.WordBoundaryMatcher = WordBoundaryMatcher;
  exports.WordClassMatcher = WordClassMatcher;
  exports.SpaceClassMatcher = SpaceClassMatcher;
  exports.AnyMatcher = AnyMatcher;
  exports.BitSetMatcher = BitSetMatcher;
  exports.CharCodeMatcher = CharCodeMatcher;
  exports.StartGroupMatcher = StartGroupMatcher;
  exports.EndGroupMatcher = EndGroupMatcher;
  exports.CharMatcher = CharMatcher;
  exports.EpsilonMatcher = EpsilonMatcher;
  return exports;
end
package.preload["temper-regex-engine/engines/nfa/stack"] = function()
  local temper = require('temper-core');
  local State, Stack, StackStart, StackSlot, exports;
  State = temper.import('temper-regex-engine/engines/nfa/state', 'State');
  Stack = temper.type('Stack');
  Stack.get.next = function(this__0)
    return__5 = temper.virtual();
  end;
  StackStart = temper.type('StackStart', Stack);
  StackStart.constructor = function(this__1)
    local t_110;
    this__1.index__18 = -1.0;
    t_110 = State(-1.0);
    this__1.state__19 = t_110;
    return nil;
  end;
  StackStart.get.next = function(this__2)
    return this__2;
  end;
  StackStart.get.index = function(this__35)
    return this__35.index__18;
  end;
  StackStart.get.state = function(this__39)
    return this__39.state__19;
  end;
  StackSlot = temper.type('StackSlot', Stack);
  StackSlot.get.next = function(this__3)
    return this__3.slot__26;
  end;
  StackSlot.constructor = function(this__10, index__30, state__31, slot__32)
    this__10.index__24 = index__30;
    this__10.state__25 = state__31;
    this__10.slot__26 = slot__32;
    return nil;
  end;
  StackSlot.get.index = function(this__43)
    return this__43.index__24;
  end;
  StackSlot.get.state = function(this__47)
    return this__47.state__25;
  end;
  StackSlot.get.slot = function(this__51)
    return this__51.slot__26;
  end;
  exports = {};
  exports.Stack = Stack;
  exports.StackStart = StackStart;
  exports.StackSlot = StackSlot;
  return exports;
end
package.preload["temper-regex-engine/engines/dfa/builder"] = function()
  local temper = require('temper-core');
  local RegexNode, Repeat, Sequence, Capture, CodePart, CodePoints, Special, SpecialSet, CodeRange, ItemizedRegex, CodeSet, Or, entire, oneOrMore, optional, Group, Regex, Begin, Dot, End, WordBoundary, Digit, Space, Word, TemperRegex, regexToString, RegexBuilderEdge, RegexBuilder, exports;
  RegexNode = temper.import('std/regex', 'RegexNode');
  Repeat = temper.import('std/regex', 'Repeat');
  Sequence = temper.import('std/regex', 'Sequence');
  Capture = temper.import('std/regex', 'Capture');
  CodePart = temper.import('std/regex', 'CodePart');
  CodePoints = temper.import('std/regex', 'CodePoints');
  Special = temper.import('std/regex', 'Special');
  SpecialSet = temper.import('std/regex', 'SpecialSet');
  CodeRange = temper.import('std/regex', 'CodeRange');
  ItemizedRegex = temper.import('std/regex', 'ItemizedRegex');
  CodeSet = temper.import('std/regex', 'CodeSet');
  Or = temper.import('std/regex', 'Or');
  entire = temper.import('std/regex', 'entire');
  oneOrMore = temper.import('std/regex', 'oneOrMore');
  optional = temper.import('std/regex', 'optional');
  Group = temper.import('std/regex', 'Group');
  Regex = temper.import('std/regex', 'Regex');
  Begin = temper.import('std/regex', 'Begin');
  Dot = temper.import('std/regex', 'Dot');
  End = temper.import('std/regex', 'End');
  WordBoundary = temper.import('std/regex', 'WordBoundary');
  Digit = temper.import('std/regex', 'Digit');
  Space = temper.import('std/regex', 'Space');
  Word = temper.import('std/regex', 'Word');
  TemperRegex = temper.import('temper-regex-engine/regex', 'TemperRegex');
  regexToString = temper.import('temper-regex-engine/util', 'regexToString');
  RegexBuilderEdge = temper.type('RegexBuilderEdge');
  RegexBuilderEdge.constructor = function(this__26, from__72, to__73, regex__74)
    this__26.from__68 = from__72;
    this__26.to__69 = to__73;
    this__26.regex__70 = regex__74;
    return nil;
  end;
  RegexBuilderEdge.get.from = function(this__141)
    return this__141.from__68;
  end;
  RegexBuilderEdge.get.to = function(this__145)
    return this__145.to__69;
  end;
  RegexBuilderEdge.get.regex = function(this__149)
    return this__149.regex__70;
  end;
  RegexBuilder = temper.type('RegexBuilder');
  RegexBuilder.constructor = function(this__17)
    local t_280;
    t_280 = temper.listbuilder_constructor();
    this__17.list__75 = t_280;
    return nil;
  end;
  RegexBuilder.methods.has = function(this__18, from__79, to__80)
    local return__29, t_281, t_282, t_283, t_284, i__82;
    ::continue_31::i__82 = 0.0;
    while true do
      local edge__83;
      t_281 = temper.listbuilder_length(this__18.list__75);
      if not (i__82 < t_281) then
        break;
      else
      end
      t_283 = temper.listed_get(this__18.list__75, i__82);
      edge__83 = t_283;
      if temper.str_eq(edge__83.to, to__80) then
        t_282 = edge__83.from;
        t_284 = temper.str_eq(t_282, from__79);
      else
        t_284 = false;
      end
      if t_284 then
        return__29 = true;
        goto break_30;
      else
      end
      i__82 = (i__82 + 1.0);
    end
    return__29 = false;
    ::break_30::return return__29;
  end;
  RegexBuilder.methods.find = function(this__19, from__85, to__86)
    local return__30, t_285, t_286, t_287, t_288, i__88;
    ::continue_33::i__88 = 0.0;
    while true do
      local edge__89;
      t_285 = temper.listbuilder_length(this__19.list__75);
      if not (i__88 < t_285) then
        break;
      else
      end
      t_287 = temper.listed_get(this__19.list__75, i__88);
      edge__89 = t_287;
      if temper.str_eq(edge__89.to, to__86) then
        t_286 = edge__89.from;
        t_288 = temper.str_eq(t_286, from__85);
      else
        t_288 = false;
      end
      if t_288 then
        return__30 = edge__89.regex;
        goto break_32;
      else
      end
      i__88 = (i__88 + 1.0);
    end
    temper.bubble();
    ::break_32::return return__30;
  end;
  RegexBuilder.methods.forEachWentFrom = function(this__20, to__91, cb__92)
    local t_289, t_290, t_291, t_292, t_293, t_294, ls__94, i__95, i__97;
    ls__94 = temper.listbuilder_constructor();
    i__95 = 0.0;
    while true do
      local edge__96;
      t_289 = temper.listbuilder_length(this__20.list__75);
      if not (i__95 < t_289) then
        break;
      else
      end
      t_292 = temper.listed_get(this__20.list__75, i__95);
      edge__96 = t_292;
      if temper.str_eq(edge__96.to, to__91) then
        t_290 = edge__96.from;
        t_293 = temper.str_ne(t_290, to__91);
      else
        t_293 = false;
      end
      if t_293 then
        temper.listbuilder_add(ls__94, edge__96);
      else
      end
      i__95 = (i__95 + 1.0);
    end
    i__97 = 0.0;
    while true do
      t_291 = temper.listbuilder_length(ls__94);
      if not (i__97 < t_291) then
        break;
      else
      end
      t_294 = temper.listed_get(ls__94, i__97);
      cb__92(t_294);
      i__97 = (i__97 + 1.0);
    end
    return nil;
  end;
  RegexBuilder.methods.forEachGoesTo = function(this__21, from__99, cb__100)
    local t_295, t_296, t_297, t_298, t_299, t_300, ls__102, i__103, i__105;
    ls__102 = temper.listbuilder_constructor();
    i__103 = 0.0;
    while true do
      local edge__104;
      t_295 = temper.listbuilder_length(this__21.list__75);
      if not (i__103 < t_295) then
        break;
      else
      end
      t_298 = temper.listed_get(this__21.list__75, i__103);
      edge__104 = t_298;
      if temper.str_eq(edge__104.from, from__99) then
        t_296 = edge__104.to;
        t_299 = temper.str_ne(t_296, from__99);
      else
        t_299 = false;
      end
      if t_299 then
        temper.listbuilder_add(ls__102, edge__104);
      else
      end
      i__103 = (i__103 + 1.0);
    end
    i__105 = 0.0;
    while true do
      t_297 = temper.listbuilder_length(ls__102);
      if not (i__105 < t_297) then
        break;
      else
      end
      t_300 = temper.listed_get(ls__102, i__105);
      cb__100(t_300);
      i__105 = (i__105 + 1.0);
    end
    return nil;
  end;
  RegexBuilder.methods.simplify = function(this__22, node__107)
    local t_301, me__109;
    me__109 = this__22;
    if this__22:has(node__107, node__107) then
      local self__110, r1__111, fn__551;
      t_301 = this__22:find(node__107, node__107);
      self__110 = t_301;
      r1__111 = regexToString(self__110);
      fn__551 = function(wentFrom__112)
        local t_302, r0__114, fn__544;
        t_302 = wentFrom__112.regex;
        r0__114 = regexToString(t_302);
        fn__544 = function(goesTo__115)
          local t_303, t_304, t_305, t_306, t_307, t_308, t_309, t_310, t_311, t_312, t_313, t_314, t_315, r2__117;
          t_315 = goesTo__115.regex;
          r2__117 = regexToString(t_315);
          if temper.str_eq(r1__111, r0__114) then
            if temper.str_eq(r1__111, r2__117) then
              t_303 = wentFrom__112.from;
              t_304 = goesTo__115.to;
              t_305 = Sequence(temper.listof(wentFrom__112.regex, Repeat(self__110, 1.0, temper.null, false)));
              me__109:add(t_303, t_304, t_305);
            else
              t_306 = wentFrom__112.from;
              t_307 = goesTo__115.to;
              t_308 = Sequence(temper.listof(Repeat(self__110, 1.0, temper.null, false), goesTo__115.regex));
              me__109:add(t_306, t_307, t_308);
            end
          elseif temper.str_eq(r1__111, r2__117) then
            t_309 = wentFrom__112.from;
            t_310 = goesTo__115.to;
            t_311 = Sequence(temper.listof(wentFrom__112.regex, Repeat(self__110, 1.0, temper.null, false)));
            me__109:add(t_309, t_310, t_311);
          else
            t_312 = wentFrom__112.from;
            t_313 = goesTo__115.to;
            t_314 = Sequence(temper.listof(wentFrom__112.regex, Repeat(self__110, 0.0, temper.null, false), goesTo__115.regex));
            me__109:add(t_312, t_313, t_314);
          end
          return nil;
        end;
        me__109:forEachGoesTo(node__107, fn__544);
        return nil;
      end;
      me__109:forEachWentFrom(node__107, fn__551);
    else
      local fn__550;
      fn__550 = function(wentFrom__118)
        local fn__512;
        fn__512 = function(goesTo__120)
          local t_316, t_317, t_318;
          t_316 = wentFrom__118.from;
          t_317 = goesTo__120.to;
          t_318 = Sequence(temper.listof(wentFrom__118.regex, goesTo__120.regex));
          me__109:add(t_316, t_317, t_318);
          return nil;
        end;
        me__109:forEachGoesTo(node__107, fn__512);
        return nil;
      end;
      me__109:forEachWentFrom(node__107, fn__550);
    end
    return nil;
  end;
  RegexBuilder.methods.add = function(this__23, from__123, to__124, regex__125)
    temper.listbuilder_add(this__23.list__75, RegexBuilderEdge(from__123, to__124, regex__125));
    return nil;
  end;
  RegexBuilder.methods.dumpInternal = function(this__24)
    local t_319, fn__497;
    t_319 = this__24.list__75;
    fn__497 = function(cur__129)
      local t_320, t_321;
      t_320 = cur__129.from;
      t_321 = cur__129.regex;
      return temper.concat(t_320, ' -> /', regexToString(t_321), '/ -> ', cur__129.to);
    end;
    return temper.listed_join(t_319, '\n', fn__497);
  end;
  RegexBuilder.methods.toRegexList = function(this__25)
    local t_322, t_323, t_324, t_325, t_326, t_327, t_328, t_329, t_330, done__133, j__134, ret__136, j__137;
    done__133 = temper.mapbuilder_constructor();
    temper.mapbuilder_set(done__133, '#begin', true);
    j__134 = 0.0;
    while true do
      local cur__135, local_331, local_332, local_333;
      t_322 = temper.listbuilder_length(this__25.list__75);
      if not (j__134 < t_322) then
        break;
      else
      end
      t_326 = temper.listed_get(this__25.list__75, j__134);
      cur__135 = t_326;
      local_331, local_332, local_333 = temper.pcall(function()
        t_327 = temper.mapped_get(done__133, cur__135.from);
        t_328 = t_327;
      end);
      if local_331 then
      else
        t_328 = false;
      end
      if not t_328 then
        temper.mapbuilder_set(done__133, cur__135.from, true);
        t_323 = cur__135.from;
        this__25:simplify(t_323);
      else
      end
      j__134 = (j__134 + 1.0);
    end
    ret__136 = temper.listbuilder_constructor();
    j__137 = 0.0;
    while true do
      local cur__138;
      t_324 = temper.listbuilder_length(this__25.list__75);
      if not (j__137 < t_324) then
        break;
      else
      end
      t_329 = temper.listed_get(this__25.list__75, j__137);
      cur__138 = t_329;
      if temper.str_eq(cur__138.from, '#begin') then
        t_325 = cur__138.to;
        t_330 = temper.str_eq(t_325, '#end');
      else
        t_330 = false;
      end
      if t_330 then
        temper.listbuilder_add(ret__136, cur__138.regex);
      else
      end
      j__137 = (j__137 + 1.0);
    end
    return temper.listbuilder_tolist(ret__136);
  end;
  RegexBuilder.get.list = function(this__153)
    return this__153.list__75;
  end;
  exports = {};
  exports.RegexBuilderEdge = RegexBuilderEdge;
  exports.RegexBuilder = RegexBuilder;
  return exports;
end
package.preload["temper-regex-engine/engines/dfa/dfa"] = function()
  local temper = require('temper-core');
  local RegexNode, CodePoints, CodeRange, CodeSet, Or, Sequence, Capture, CodePart, Special, SpecialSet, ItemizedRegex, Repeat, entire, oneOrMore, optional, Group, Regex, Begin, Dot, End, WordBoundary, Digit, Space, Word, TemperRegexNFA, Engine, State, Matcher, BeginMatcher, EndMatcher, WordBoundaryMatcher, WordClassMatcher, SpaceClassMatcher, AnyMatcher, BitSetMatcher, CharCodeMatcher, StartGroupMatcher, EndGroupMatcher, CharMatcher, EpsilonMatcher, TemperRegex, regexToString, chr, TransitionTable, TransitionTableEntry, toVec, fromVec, RegexBuilder, TemperRegexPatterns, console_356, TemperRegexDFA, emptyList__129, mapToList__78, validFor__79, exports;
  RegexNode = temper.import('std/regex', 'RegexNode');
  CodePoints = temper.import('std/regex', 'CodePoints');
  CodeRange = temper.import('std/regex', 'CodeRange');
  CodeSet = temper.import('std/regex', 'CodeSet');
  Or = temper.import('std/regex', 'Or');
  Sequence = temper.import('std/regex', 'Sequence');
  Capture = temper.import('std/regex', 'Capture');
  CodePart = temper.import('std/regex', 'CodePart');
  Special = temper.import('std/regex', 'Special');
  SpecialSet = temper.import('std/regex', 'SpecialSet');
  ItemizedRegex = temper.import('std/regex', 'ItemizedRegex');
  Repeat = temper.import('std/regex', 'Repeat');
  entire = temper.import('std/regex', 'entire');
  oneOrMore = temper.import('std/regex', 'oneOrMore');
  optional = temper.import('std/regex', 'optional');
  Group = temper.import('std/regex', 'Group');
  Regex = temper.import('std/regex', 'Regex');
  Begin = temper.import('std/regex', 'Begin');
  Dot = temper.import('std/regex', 'Dot');
  End = temper.import('std/regex', 'End');
  WordBoundary = temper.import('std/regex', 'WordBoundary');
  Digit = temper.import('std/regex', 'Digit');
  Space = temper.import('std/regex', 'Space');
  Word = temper.import('std/regex', 'Word');
  TemperRegexNFA = temper.import('temper-regex-engine/engines/nfa/nfa', 'TemperRegexNFA');
  Engine = temper.import('temper-regex-engine/engines/nfa/engine', 'Engine');
  State = temper.import('temper-regex-engine/engines/nfa/state', 'State');
  Matcher = temper.import('temper-regex-engine/engines/nfa/matcher', 'Matcher');
  BeginMatcher = temper.import('temper-regex-engine/engines/nfa/matcher', 'BeginMatcher');
  EndMatcher = temper.import('temper-regex-engine/engines/nfa/matcher', 'EndMatcher');
  WordBoundaryMatcher = temper.import('temper-regex-engine/engines/nfa/matcher', 'WordBoundaryMatcher');
  WordClassMatcher = temper.import('temper-regex-engine/engines/nfa/matcher', 'WordClassMatcher');
  SpaceClassMatcher = temper.import('temper-regex-engine/engines/nfa/matcher', 'SpaceClassMatcher');
  AnyMatcher = temper.import('temper-regex-engine/engines/nfa/matcher', 'AnyMatcher');
  BitSetMatcher = temper.import('temper-regex-engine/engines/nfa/matcher', 'BitSetMatcher');
  CharCodeMatcher = temper.import('temper-regex-engine/engines/nfa/matcher', 'CharCodeMatcher');
  StartGroupMatcher = temper.import('temper-regex-engine/engines/nfa/matcher', 'StartGroupMatcher');
  EndGroupMatcher = temper.import('temper-regex-engine/engines/nfa/matcher', 'EndGroupMatcher');
  CharMatcher = temper.import('temper-regex-engine/engines/nfa/matcher', 'CharMatcher');
  EpsilonMatcher = temper.import('temper-regex-engine/engines/nfa/matcher', 'EpsilonMatcher');
  TemperRegex = temper.import('temper-regex-engine/regex', 'TemperRegex');
  regexToString = temper.import('temper-regex-engine/util', 'regexToString');
  chr = temper.import('temper-regex-engine/util', 'chr');
  TransitionTable = temper.import('temper-regex-engine/engines/dfa/table', 'TransitionTable');
  TransitionTableEntry = temper.import('temper-regex-engine/engines/dfa/table', 'TransitionTableEntry');
  toVec = temper.import('temper-regex-engine/engines/dfa/table', 'toVec');
  fromVec = temper.import('temper-regex-engine/engines/dfa/table', 'fromVec');
  RegexBuilder = temper.import('temper-regex-engine/engines/dfa/builder', 'RegexBuilder');
  TemperRegexPatterns = temper.import('temper-regex-engine/engines/patterns', 'TemperRegexPatterns');
  console_356 = 0.0;
  TemperRegexDFA = temper.type('TemperRegexDFA', TemperRegex);
  TemperRegexDFA.get.nstates = function(this__37)
    return temper.listbuilder_length(this__37.nfa__155.states);
  end;
  TemperRegexDFA.constructor = function(this__38, regex__159)
    local t_357, t_358, t_359, t_360, t_361, t_362, t_363, t_364, t_365, t_366, t_367, t_368, t_369, t_370, t_371, t_372, t_373, t_374, t_375, t_376, t_377, t_378, t_379, t_380, t_381, t_382, t_383, t_384, t_385, t_386, i__161, pairs__164, i__165, i__173, index__174, i__175, mapBuilder__178, i__179, t_387;
    this__38.nsyms__150 = 0.0;
    t_383 = temper.mapbuilder_constructor();
    this__38.symbols__151 = t_383;
    t_384 = (TemperRegexNFA(regex__159)).engine;
    this__38.rawNfa__154 = t_384;
    t_385 = this__38.rawNfa__154:opt();
    this__38.nfa__155 = t_385;
    t_386 = TransitionTable(this__38.nstates);
    this__38.table__152 = t_386;
    i__161 = 0.0;
    while true do
      local state__162, j__163;
      t_357 = this__38.nstates;
      if not (i__161 < t_357) then
        break;
      else
      end
      t_371 = temper.listed_get(this__38.nfa__155.states, i__161);
      state__162 = t_371;
      j__163 = 0.0;
      while true do
        t_358 = temper.listbuilder_length(state__162.next);
        if not (j__163 < t_358) then
          break;
        else
        end
        t_372 = temper.listed_get(state__162.next, j__163);
        t_359 = t_372.matcher;
        this__38:addSymbolsFrom(t_359);
        j__163 = (j__163 + 1.0);
      end
      i__161 = (i__161 + 1.0);
    end
    pairs__164 = temper.mapped_tolist(this__38.symbols__151);
    i__165 = 0.0;
    while true do
      local state__166, val__167, j__168, ent__172;
      t_360 = this__38.nstates;
      if not (i__165 < t_360) then
        break;
      else
      end
      t_373 = temper.listed_get(this__38.nfa__155.states, i__165);
      state__166 = t_373;
      val__167 = temper.listbuilder_constructor();
      j__168 = 0.0;
      while (j__168 < this__38.nsyms__150) do
        local cur__169, k__170;
        cur__169 = temper.listbuilder_constructor();
        k__170 = 0.0;
        while true do
          local next__171;
          t_361 = temper.listbuilder_length(state__166.next);
          if not (k__170 < t_361) then
            break;
          else
          end
          t_374 = temper.listed_get(state__166.next, k__170);
          next__171 = t_374;
          t_362 = next__171.matcher;
          t_363 = validFor__79(t_362);
          t_375 = temper.list_get(pairs__164, j__168);
          if temper.densebitvector_get(t_363, t_375.key) then
            temper.listbuilder_add(cur__169, next__171.toState.id);
          else
          end
          k__170 = (k__170 + 1.0);
        end
        temper.listbuilder_add(val__167, toVec(temper.listbuilder_tolist(cur__169), this__38.nstates));
        j__168 = (j__168 + 1.0);
      end
      ent__172 = TransitionTableEntry(toVec(temper.listof(state__166.id), this__38.nstates), temper.listbuilder_tolist(val__167));
      temper.listbuilder_add(this__38.table__152.table, ent__172);
      i__165 = (i__165 + 1.0);
    end
    i__173 = 0.0;
    while true do
      t_364 = this__38.nstates;
      if not (i__173 < t_364) then
        break;
      else
      end
      t_376 = temper.listed_get(this__38.table__152.table, i__173);
      t_365 = this__38.nstates;
      this__38:buildTable(t_376, t_365);
      i__173 = (i__173 + 1.0);
    end
    index__174 = temper.mapbuilder_constructor();
    temper.mapbuilder_set(index__174, '', 0.0);
    i__175 = 0.0;
    while true do
      local tent__176, name__177;
      ::continue_37::t_366 = temper.listbuilder_length(this__38.table__152.table);
      if not (i__175 < t_366) then
        break;
      else
      end
      t_377 = temper.listed_get(this__38.table__152.table, i__175);
      tent__176 = t_377;
      t_367 = tent__176.key;
      name__177 = this__38:nameFor(t_367);
      if temper.str_eq(name__177, '') then
        goto break_36;
      else
      end
      t_368 = tent__176.key;
      temper.mapbuilder_set(index__174, this__38:nameFor(t_368), (i__175 + 1.0));
      ::break_36::i__175 = (i__175 + 1.0);
    end
    mapBuilder__178 = temper.mapbuilder_constructor();
    i__179 = 0.0;
    while true do
      local tent__180, subBuilder__181, j__182, ci__184;
      t_369 = temper.listbuilder_length(this__38.table__152.table);
      if not (i__179 < t_369) then
        break;
      else
      end
      t_378 = temper.listed_get(this__38.table__152.table, i__179);
      tent__180 = t_378;
      subBuilder__181 = temper.mapbuilder_constructor();
      j__182 = 0.0;
      while (j__182 < this__38.nsyms__150) do
        local value__183;
        t_379 = temper.list_get(tent__180.val, j__182);
        t_380 = temper.mapped_get(index__174, this__38:nameFor(t_379));
        value__183 = t_380;
        t_381 = temper.list_get(pairs__164, j__182);
        temper.mapbuilder_set(subBuilder__181, t_381.key, value__183);
        j__182 = (j__182 + 1.0);
      end
      t_370 = tent__180.key;
      t_382 = temper.mapped_get(index__174, this__38:nameFor(t_370));
      ci__184 = t_382;
      temper.mapbuilder_set(mapBuilder__178, ci__184, mapToList__78(temper.mapped_tomap(subBuilder__181), 0.0));
      i__179 = (i__179 + 1.0);
    end
    t_387 = temper.mapped_tomap(mapBuilder__178);
    this__38.map__153 = mapToList__78(t_387, temper.listof());
    return nil;
  end;
  TemperRegexDFA.methods.addCodePoint = function(this__39, c__186)
    local local_388, local_389, local_390;
    local_388, local_389, local_390 = temper.pcall(function()
      temper.mapped_get(this__39.symbols__151, c__186);
    end);
    if local_388 then
    else
      local newSym__188;
      newSym__188 = this__39.nsyms__150;
      this__39.nsyms__150 = (this__39.nsyms__150 + 1.0);
      temper.mapbuilder_set(this__39.symbols__151, c__186, newSym__188);
    end
    return nil;
  end;
  TemperRegexDFA.methods.addCodePointRange = function(this__40, min__190, max__191)
    local i__193;
    i__193 = min__190;
    while (i__193 <= max__191) do
      this__40:addCodePoint(i__193);
      i__193 = (i__193 + 1.0);
    end
    return nil;
  end;
  TemperRegexDFA.methods.nameFor = function(this__41, vec__195)
    local t_392, t_393, fn__1515;
    t_392 = this__41.nstates;
    t_393 = fromVec(vec__195, t_392);
    fn__1515 = function(s__197)
      return temper.int_tostring(s__197);
    end;
    return temper.listed_join(t_393, '|', fn__1515);
  end;
  TemperRegexDFA.methods.buildEngine = function(this__42)
    local t_394, t_395, t_396, t_397, t_398, t_399, t_400, t_401, t_402, t_403, t_404, t_405, t_406, t_407, nstates__201, index__202, i__203, dfa__206, dfaStates__207, i__208, pairs__210, i__211;
    nstates__201 = temper.listbuilder_length(this__42.nfa__155.states);
    index__202 = temper.mapbuilder_constructor();
    temper.mapbuilder_set(index__202, '', -1.0);
    i__203 = 0.0;
    while true do
      local tent__204, name__205;
      ::continue_39::t_394 = temper.listbuilder_length(this__42.table__152.table);
      if not (i__203 < t_394) then
        break;
      else
      end
      t_400 = temper.listed_get(this__42.table__152.table, i__203);
      tent__204 = t_400;
      t_395 = tent__204.key;
      name__205 = this__42:nameFor(t_395);
      if temper.str_eq(name__205, '') then
        goto break_38;
      else
      end
      t_396 = tent__204.key;
      temper.mapbuilder_set(index__202, this__42:nameFor(t_396), i__203);
      ::break_38::i__203 = (i__203 + 1.0);
    end
    dfa__206 = Engine();
    dfaStates__207 = temper.listbuilder_constructor();
    i__208 = 0.0;
    while true do
      local tent__209;
      t_397 = temper.listbuilder_length(this__42.table__152.table);
      if not (i__208 < t_397) then
        break;
      else
      end
      t_401 = temper.listed_get(this__42.table__152.table, i__208);
      tent__209 = t_401;
      if (i__208 == 0.0) then
        temper.listbuilder_add(dfaStates__207, dfa__206.startState);
      elseif temper.densebitvector_get(tent__209.key, 1.0) then
        temper.listbuilder_add(dfaStates__207, dfa__206.endState);
      else
        temper.listbuilder_add(dfaStates__207, dfa__206:newState());
      end
      i__208 = (i__208 + 1.0);
    end
    pairs__210 = temper.mapped_tolist(this__42.symbols__151);
    i__211 = 0.0;
    while true do
      local tent__212, state__213, j__214;
      t_398 = temper.listbuilder_length(this__42.table__152.table);
      if not (i__211 < t_398) then
        break;
      else
      end
      t_402 = temper.listed_get(this__42.table__152.table, i__211);
      tent__212 = t_402;
      t_403 = temper.listed_get(dfaStates__207, i__211);
      state__213 = t_403;
      j__214 = 0.0;
      while (j__214 < this__42.nsyms__150) do
        local value__215;
        t_404 = temper.list_get(tent__212.val, j__214);
        t_405 = temper.mapped_get(index__202, this__42:nameFor(t_404));
        value__215 = t_405;
        if (value__215 ~= -1.0) then
          t_406 = temper.list_get(pairs__210, j__214);
          t_399 = CharCodeMatcher(t_406.key);
          t_407 = temper.listed_get(dfaStates__207, value__215);
          state__213:addNext(t_399, t_407);
        else
        end
        j__214 = (j__214 + 1.0);
      end
      i__211 = (i__211 + 1.0);
    end
    return dfa__206:opt();
  end;
  TemperRegexDFA.methods.buildTable = function(this__43, tent__217, nstates__218)
    local t_408, t_409, t_410, t_411, t_412, t_413, i__220;
    i__220 = 0.0;
    while (i__220 < this__43.nsyms__150) do
      local newKey__221;
      t_409 = temper.list_get(tent__217.val, i__220);
      newKey__221 = t_409;
      if (temper.list_length(fromVec(newKey__221, nstates__218)) >= 1.0) then
        t_408 = this__43.table__152:has(newKey__221);
        t_410 = not t_408;
      else
        t_410 = false;
      end
      if t_410 then
        local allVals__222, j__223, ent__229;
        allVals__222 = temper.listbuilder_constructor();
        j__223 = 0.0;
        while (j__223 < this__43.nsyms__150) do
          local newVal__224, k__225;
          newVal__224 = temper.densebitvector_constructor(0.0);
          k__225 = 0.0;
          while (k__225 < nstates__218) do
            if temper.densebitvector_get(newKey__221, k__225) then
              local ent__226, bv__227, l__228;
              t_411 = this__43.table__152:get(toVec(temper.listof(k__225), nstates__218));
              ent__226 = t_411;
              t_412 = this__43.table__152:get(toVec(temper.listof(k__225), nstates__218));
              t_413 = temper.list_get(t_412.val, j__223);
              bv__227 = t_413;
              l__228 = 0.0;
              while (l__228 < nstates__218) do
                if temper.densebitvector_get(bv__227, l__228) then
                  temper.densebitvector_set(newVal__224, l__228, true);
                else
                end
                l__228 = (l__228 + 1.0);
              end
            else
            end
            k__225 = (k__225 + 1.0);
          end
          temper.listbuilder_add(allVals__222, newVal__224);
          j__223 = (j__223 + 1.0);
        end
        ent__229 = TransitionTableEntry(newKey__221, temper.listbuilder_tolist(allVals__222));
        temper.listbuilder_add(this__43.table__152.table, ent__229);
        this__43:buildTable(ent__229, nstates__218);
      else
      end
      i__220 = (i__220 + 1.0);
    end
    return nil;
  end;
  TemperRegexDFA.methods.addSymbolsFrom = function(this__44, next__231)
    local t_414, t_415, t_416, t_417;
    if temper.instance_of(next__231, WordClassMatcher) then
      temper.cast_to(next__231, WordClassMatcher);
      this__44:addCodePointRange(48.0, 57.0);
      this__44:addCodePointRange(65.0, 90.0);
      this__44:addCodePointRange(97.0, 122.0);
    elseif temper.instance_of(next__231, SpaceClassMatcher) then
      temper.cast_to(next__231, SpaceClassMatcher);
      this__44:addCodePoint(9.0);
      this__44:addCodePoint(10.0);
      this__44:addCodePoint(11.0);
      this__44:addCodePoint(13.0);
      this__44:addCodePoint(32.0);
    elseif temper.instance_of(next__231, BitSetMatcher) then
      temper.cast_to(next__231, BitSetMatcher);
    elseif temper.instance_of(next__231, CharCodeMatcher) then
      t_416 = temper.cast_to(next__231, CharCodeMatcher);
      t_414 = t_416.code;
      this__44:addCodePoint(t_414);
    elseif temper.instance_of(next__231, CharMatcher) then
      t_417 = temper.cast_to(next__231, CharMatcher);
      t_415 = t_417.code;
      this__44:addCodePoint(t_415);
    elseif temper.instance_of(next__231, AnyMatcher) then
      temper.cast_to(next__231, AnyMatcher);
      this__44:addCodePoint(9.0);
      this__44:addCodePoint(10.0);
      this__44:addCodePoint(11.0);
      this__44:addCodePoint(13.0);
      this__44:addCodePoint(32.0);
      this__44:addCodePointRange(32.0, 126.0);
    elseif temper.instance_of(next__231, EpsilonMatcher) then
      temper.cast_to(next__231, EpsilonMatcher);
    elseif temper.instance_of(next__231, StartGroupMatcher) then
      temper.cast_to(next__231, StartGroupMatcher);
    elseif temper.instance_of(next__231, EndGroupMatcher) then
      temper.cast_to(next__231, EndGroupMatcher);
    elseif temper.instance_of(next__231, WordBoundaryMatcher) then
      temper.cast_to(next__231, WordBoundaryMatcher);
      temper.log('WordBoundaryMatcher');
      temper.bubble();
    elseif temper.instance_of(next__231, EndMatcher) then
      temper.cast_to(next__231, EndMatcher);
      temper.log('EndMatcher');
      temper.bubble();
    elseif temper.instance_of(next__231, BeginMatcher) then
      temper.cast_to(next__231, BeginMatcher);
      temper.log('BeginMatcher');
      temper.bubble();
    else
    end
    return nil;
  end;
  TemperRegexDFA.methods.foundAfter = function(this__45, str__234, place__235)
    local return__68, t_418, t_419, state__237;
    ::continue_41::state__237 = 1.0;
    while true do
      if (state__237 == 0.0) then
        return__68 = false;
        goto break_40;
      else
      end
      if (state__237 == 2.0) then
        return__68 = true;
        goto break_40;
      else
      end
      if temper.string_hasindex(str__234, place__235) then
        return__68 = false;
        goto break_40;
      else
      end
      t_418 = temper.listed_getor(temper.listed_getor(this__45.map__153, state__237, emptyList__129), temper.string_codeat(str__234, place__235), 0.0);
      state__237 = t_418;
      t_419 = temper.string_next(str__234, place__235);
      place__235 = t_419;
    end
    ::break_40::return return__68;
  end;
  TemperRegexDFA.methods.found = function(this__46, str__239)
    local return__69, t_420, place__241;
    ::continue_43::place__241 = 1.0;
    while true do
      if this__46:foundAfter(str__239, place__241) then
        return__69 = true;
        goto break_42;
      elseif temper.string_hasindex(str__239, place__241) then
        t_420 = temper.string_next(str__239, place__241);
        place__241 = t_420;
      else
        return__69 = false;
        goto break_42;
      end
    end
    ::break_42::return return__69;
  end;
  TemperRegexDFA.methods.find = function(this__47, str__243)
    local return__70, t_421, place__245;
    ::continue_45::place__245 = 1.0;
    while true do
      if this__47:foundAfter(str__243, place__245) then
        return__70 = true;
        goto break_44;
      elseif temper.string_hasindex(str__243, place__245) then
        t_421 = temper.string_next(str__243, place__245);
        place__245 = t_421;
      else
        return__70 = false;
        goto break_44;
      end
    end
    ::break_44::return return__70;
  end;
  TemperRegexDFA.methods.toMarkdownTable = function(this__48)
    return this__48.table__152:toMarkdownWith(this__48.symbols__151);
  end;
  TemperRegexDFA.methods.toDot = function(this__49)
    local nfaDot1__250, nfaDot2__251, tableDot__252, dfaDot__253;
    nfaDot1__250 = this__49.rawNfa__154:toDotSub('nfa2', '#FFE0FF');
    nfaDot2__251 = this__49.nfa__155:toDotSub('nfa1', '#E0E0FF');
    tableDot__252 = this__49.table__152:toDotWith(this__49.symbols__151, '#E0FFFF');
    dfaDot__253 = this__49:buildEngine():toDotSub('dfa', '#E0FFE0');
    return temper.concat('digraph {\n  ', nfaDot1__250, '\n  ', nfaDot2__251, '\n  table[shape=none label=<', tableDot__252, '>];\n  ', dfaDot__253, '\n}\n');
  end;
  TemperRegexDFA.methods.toPatterns = function(this__50, isMatch__255)
    local regexToStringChr__257;
    regexToStringChr__257 = function(r__258)
      return regexToString(r__258);
    end;
    return TemperRegexPatterns(temper.listed_map(this__50:toRegexList(), regexToStringChr__257), isMatch__255);
  end;
  TemperRegexDFA.methods.toRegex = function(this__51)
    return Or(this__51:toRegexList());
  end;
  TemperRegexDFA.methods.toRegexList = function(this__52)
    local t_422, t_423, t_424, t_425, t_426, t_427, t_428, t_429, t_430, t_431, t_432, t_433, t_434, t_435, t_436, t_437, builder__264, syms__265, i__266;
    builder__264 = RegexBuilder();
    syms__265 = temper.mapped_tolist(this__52.symbols__151);
    i__266 = 0.0;
    while true do
      local tent__267, kname__268, tmap__269, j__270, ls__273, j__274;
      ::continue_47::t_422 = temper.listbuilder_length(this__52.table__152.table);
      if not (i__266 < t_422) then
        break;
      else
      end
      t_427 = temper.listed_get(this__52.table__152.table, i__266);
      tent__267 = t_427;
      t_423 = tent__267.key;
      kname__268 = this__52:nameFor(t_423);
      if temper.str_eq(kname__268, '') then
        goto break_46;
      else
      end
      tmap__269 = temper.mapbuilder_constructor();
      j__270 = 0.0;
      while (j__270 < this__52.nsyms__150) do
        local val__271, local_438, local_439, local_440, got__272;
        t_428 = temper.list_get(tent__267.val, j__270);
        val__271 = this__52:nameFor(t_428);
        local_438, local_439, local_440 = temper.pcall(function()
          t_429 = temper.mapped_get(tmap__269, val__271);
          t_430 = t_429;
        end);
        if local_438 then
        else
          t_424 = temper.listbuilder_constructor();
          t_430 = t_424;
        end
        got__272 = t_430;
        if temper.str_ne(val__271, '') then
          t_431 = temper.list_get(syms__265, j__270);
          temper.listbuilder_add(got__272, t_431.key);
          temper.mapbuilder_set(tmap__269, val__271, got__272);
        else
        end
        j__270 = (j__270 + 1.0);
      end
      ls__273 = temper.mapped_tolist(tmap__269);
      if (i__266 == 0.0) then
        builder__264:add('#begin', kname__268, Sequence(temper.listof()));
      else
      end
      if (i__266 == 1.0) then
        builder__264:add(kname__268, '#end', Sequence(temper.listof()));
      else
      end
      j__274 = 0.0;
      while true do
        local vals__275;
        t_425 = temper.list_length(ls__273);
        if not (j__274 < t_425) then
          break;
        else
        end
        t_432 = temper.list_get(ls__273, j__274);
        vals__275 = t_432.value;
        if (temper.listbuilder_length(vals__275) == 1.0) then
          local points__276;
          t_433 = temper.list_get(ls__273, j__274);
          points__276 = CodePoints(temper.listed_join(t_433.value, '', chr));
          t_434 = temper.list_get(ls__273, j__274);
          builder__264:add(kname__268, t_434.key, points__276);
        else
          local parts__277, bits__278, max__279, k__280, start__282, k__283;
          parts__277 = temper.listbuilder_constructor();
          bits__278 = temper.densebitvector_constructor(0.0);
          max__279 = 0.0;
          k__280 = 0.0;
          while true do
            local chrv__281;
            t_426 = temper.listbuilder_length(vals__275);
            if not (k__280 < t_426) then
              break;
            else
            end
            t_435 = temper.listed_get(vals__275, k__280);
            chrv__281 = t_435;
            if (chrv__281 > max__279) then
              max__279 = chrv__281;
            else
            end
            temper.densebitvector_set(bits__278, chrv__281, true);
            k__280 = (k__280 + 1.0);
          end
          start__282 = -1.0;
          k__283 = 0.0;
          while (k__283 <= max__279) do
            if temper.densebitvector_get(bits__278, k__283) then
              local s__284;
              s__284 = k__283;
              while true do
                if not temper.densebitvector_get(bits__278, k__283) then
                  break;
                else
                end
                k__283 = (k__283 + 1.0);
              end
              if ((k__283 - s__284) <= 2.0) then
                local l__285;
                l__285 = s__284;
                while (l__285 < k__283) do
                  t_436 = temper.string_fromcodepoint(l__285);
                  temper.listbuilder_add(parts__277, CodePoints(t_436));
                  l__285 = (l__285 + 1.0);
                end
              else
                temper.listbuilder_add(parts__277, CodeRange(s__284, (k__283 - 1.0)));
              end
            else
            end
            k__283 = (k__283 + 1.0);
          end
          t_437 = temper.list_get(ls__273, j__274);
          builder__264:add(kname__268, t_437.key, CodeSet(temper.listbuilder_tolist(parts__277)));
        end
        j__274 = (j__274 + 1.0);
      end
      ::break_46::i__266 = (i__266 + 1.0);
    end
    return builder__264:toRegexList();
  end;
  TemperRegexDFA.methods.toRegexString = function(this__53)
    local t_442;
    t_442 = this__53:toRegex();
    return regexToString(t_442);
  end;
  TemperRegexDFA.get.nsyms = function(this__310)
    return this__310.nsyms__150;
  end;
  TemperRegexDFA.get.symbols = function(this__314)
    return this__314.symbols__151;
  end;
  TemperRegexDFA.get.table = function(this__318)
    return this__318.table__152;
  end;
  TemperRegexDFA.get.map = function(this__322)
    return this__322.map__153;
  end;
  TemperRegexDFA.get.rawNfa = function(this__326)
    return this__326.rawNfa__154;
  end;
  TemperRegexDFA.get.nfa = function(this__330)
    return this__330.nfa__155;
  end;
  emptyList__129 = temper.listof();
  mapToList__78 = function(map__130, defaultValue__131)
    local t_443, t_444, t_445, t_446, ls__133, max__134, i__135, ret__137, i__138;
    ls__133 = temper.mapped_tolist(map__130);
    max__134 = 0.0;
    i__135 = 0.0;
    while true do
      local key__136;
      t_443 = temper.list_length(ls__133);
      if not (i__135 < t_443) then
        break;
      else
      end
      t_444 = temper.list_get(ls__133, i__135);
      key__136 = t_444.key;
      if (key__136 > max__134) then
        max__134 = key__136;
      else
      end
      i__135 = (i__135 + 1.0);
    end
    ret__137 = temper.listbuilder_constructor();
    i__138 = 0.0;
    while (i__138 <= max__134) do
      local local_447, local_448, local_449;
      local_447, local_448, local_449 = temper.pcall(function()
        t_445 = temper.mapped_get(map__130, i__138);
        t_446 = t_445;
      end);
      if local_447 then
      else
        t_446 = defaultValue__131;
      end
      temper.listbuilder_add(ret__137, t_446);
      i__138 = (i__138 + 1.0);
    end
    return temper.listbuilder_tolist(ret__137);
  end;
  validFor__79 = function(next__139)
    local t_451, t_452, valid__143, validPoint__141, validRange__142;
    valid__143 = temper.densebitvector_constructor(0.0);
    validPoint__141 = function(c__144)
      temper.densebitvector_set(valid__143, c__144, true);
      return nil;
    end;
    validRange__142 = function(min__146, max__147)
      local i__149;
      i__149 = min__146;
      while (i__149 <= max__147) do
        validPoint__141(i__149);
        i__149 = (i__149 + 1.0);
      end
      return nil;
    end;
    if temper.instance_of(next__139, WordClassMatcher) then
      temper.cast_to(next__139, WordClassMatcher);
      validRange__142(48.0, 57.0);
      validRange__142(65.0, 90.0);
      validRange__142(97.0, 122.0);
    elseif temper.instance_of(next__139, SpaceClassMatcher) then
      temper.cast_to(next__139, SpaceClassMatcher);
      validPoint__141(9.0);
      validPoint__141(10.0);
      validPoint__141(11.0);
      validPoint__141(13.0);
      validPoint__141(32.0);
    elseif temper.instance_of(next__139, BitSetMatcher) then
      temper.cast_to(next__139, BitSetMatcher);
    elseif temper.instance_of(next__139, CharMatcher) then
      t_451 = temper.cast_to(next__139, CharMatcher);
      validPoint__141(t_451.code);
    elseif temper.instance_of(next__139, CharCodeMatcher) then
      t_452 = temper.cast_to(next__139, CharCodeMatcher);
      validPoint__141(t_452.code);
    elseif temper.instance_of(next__139, AnyMatcher) then
      temper.cast_to(next__139, AnyMatcher);
    elseif temper.instance_of(next__139, EpsilonMatcher) then
      temper.cast_to(next__139, EpsilonMatcher);
    elseif temper.instance_of(next__139, WordBoundaryMatcher) then
      temper.cast_to(next__139, WordBoundaryMatcher);
      temper.log('WordBoundaryMatcher');
      temper.bubble();
    elseif temper.instance_of(next__139, EndMatcher) then
      temper.cast_to(next__139, EndMatcher);
      temper.log('EndMatcher');
      temper.bubble();
    elseif temper.instance_of(next__139, BeginMatcher) then
      temper.cast_to(next__139, BeginMatcher);
      temper.log('BeginMatcher');
      temper.bubble();
    else
    end
    return valid__143;
  end;
  exports = {};
  exports.TemperRegexDFA = TemperRegexDFA;
  return exports;
end
package.preload["temper-regex-engine/engines/dfa/table"] = function()
  local temper = require('temper-core');
  local TemperRegex, Matcher, BeginMatcher, EndMatcher, WordBoundaryMatcher, WordClassMatcher, SpaceClassMatcher, AnyMatcher, BitSetMatcher, CharCodeMatcher, StartGroupMatcher, EndGroupMatcher, CharMatcher, EpsilonMatcher, TransitionTableEntry, TransitionTable, toVec, fromVec, exports;
  TemperRegex = temper.import('temper-regex-engine/regex', 'TemperRegex');
  Matcher = temper.import('temper-regex-engine/engines/nfa/matcher', 'Matcher');
  BeginMatcher = temper.import('temper-regex-engine/engines/nfa/matcher', 'BeginMatcher');
  EndMatcher = temper.import('temper-regex-engine/engines/nfa/matcher', 'EndMatcher');
  WordBoundaryMatcher = temper.import('temper-regex-engine/engines/nfa/matcher', 'WordBoundaryMatcher');
  WordClassMatcher = temper.import('temper-regex-engine/engines/nfa/matcher', 'WordClassMatcher');
  SpaceClassMatcher = temper.import('temper-regex-engine/engines/nfa/matcher', 'SpaceClassMatcher');
  AnyMatcher = temper.import('temper-regex-engine/engines/nfa/matcher', 'AnyMatcher');
  BitSetMatcher = temper.import('temper-regex-engine/engines/nfa/matcher', 'BitSetMatcher');
  CharCodeMatcher = temper.import('temper-regex-engine/engines/nfa/matcher', 'CharCodeMatcher');
  StartGroupMatcher = temper.import('temper-regex-engine/engines/nfa/matcher', 'StartGroupMatcher');
  EndGroupMatcher = temper.import('temper-regex-engine/engines/nfa/matcher', 'EndGroupMatcher');
  CharMatcher = temper.import('temper-regex-engine/engines/nfa/matcher', 'CharMatcher');
  EpsilonMatcher = temper.import('temper-regex-engine/engines/nfa/matcher', 'EpsilonMatcher');
  TransitionTableEntry = temper.type('TransitionTableEntry');
  TransitionTableEntry.methods.toMarkdownWith = function(this__10, nsyms__68)
    local t_335, fn__480, keyStr__70, t_336, fn__479, valStrs__73;
    t_335 = fromVec(this__10.key__65, nsyms__68);
    fn__480 = function(id__71)
      return temper.concat('q', temper.int_tostring(id__71));
    end;
    keyStr__70 = temper.listed_join(t_335, ',', fn__480);
    t_336 = this__10.val__66;
    fn__479 = function(vec__74)
      local return__24, vec__76;
      vec__76 = fromVec(vec__74, nsyms__68);
      if (temper.list_length(vec__76) == 0.0) then
        return__24 = '-';
      else
        local fn__471;
        fn__471 = function(id__77)
          return temper.concat('q', temper.int_tostring(id__77));
        end;
        return__24 = temper.listed_join(vec__76, ',', fn__471);
      end
      return return__24;
    end;
    valStrs__73 = temper.listed_join(t_336, ' | ', fn__479);
    return temper.concat('| ', keyStr__70, ' | ', valStrs__73, ' |');
  end;
  TransitionTableEntry.methods.toDotWith = function(this__11, nsyms__80)
    local t_337, fn__461, keyStr__82, t_338, fn__460, valStrs__85;
    t_337 = fromVec(this__11.key__65, nsyms__80);
    fn__461 = function(id__83)
      return temper.concat('q', temper.int_tostring(id__83));
    end;
    keyStr__82 = temper.listed_join(t_337, '', fn__461);
    t_338 = this__11.val__66;
    fn__460 = function(vec__86)
      local return__28, t_339, vec__88;
      vec__88 = fromVec(vec__86, nsyms__80);
      if (temper.list_length(vec__88) == 0.0) then
        return__28 = '<TD>-</TD>';
      else
        local fn__452;
        fn__452 = function(id__89)
          return temper.concat('q', temper.int_tostring(id__89));
        end;
        t_339 = temper.listed_join(vec__88, ',', fn__452);
        return__28 = temper.concat('<TD>', t_339, '</TD>');
      end
      return return__28;
    end;
    valStrs__85 = temper.listed_join(t_338, '', fn__460);
    return temper.concat('<TR><TD>', keyStr__82, '</TD>', valStrs__85, '</TR>');
  end;
  TransitionTableEntry.constructor = function(this__19, key__92, val__93)
    this__19.key__65 = key__92;
    this__19.val__66 = val__93;
    return nil;
  end;
  TransitionTableEntry.get.key = function(this__151)
    return this__151.key__65;
  end;
  TransitionTableEntry.get.val = function(this__155)
    return this__155.val__66;
  end;
  TransitionTable = temper.type('TransitionTable');
  TransitionTable.constructor = function(this__12, size__97)
    local t_340;
    this__12.nsyms__94 = size__97;
    t_340 = temper.listbuilder_constructor();
    this__12.table__95 = t_340;
    return nil;
  end;
  TransitionTable.methods.has = function(this__13, key__100)
    local return__31, local_341, local_342, local_343;
    local_341, local_342, local_343 = temper.pcall(function()
      this__13:get(key__100);
      return__31 = true;
    end);
    if local_341 then
    else
      return__31 = false;
    end
    return return__31;
  end;
  TransitionTable.methods.get = function(this__14, key__103)
    local return__32, t_345, t_346, i__105;
    ::continue_35::i__105 = 0.0;
    while true do
      local cur__107, ret__108, j__109;
      t_345 = temper.listbuilder_length(this__14.table__95);
      if not (i__105 < t_345) then
        break;
      else
      end
      t_346 = temper.listed_get(this__14.table__95, i__105);
      cur__107 = t_346;
      ret__108 = true;
      j__109 = 0.0;
      while (j__109 < this__14.nsyms__94) do
        if temper.generic_ne(temper.densebitvector_get(key__103, j__109), temper.densebitvector_get(cur__107.key, j__109)) then
          ret__108 = false;
          break;
        else
        end
        j__109 = (j__109 + 1.0);
      end
      if ret__108 then
        return__32 = cur__107;
        goto break_34;
      else
      end
      i__105 = (i__105 + 1.0);
    end
    temper.bubble();
    ::break_34::return return__32;
  end;
  TransitionTable.methods.toMarkdownWith = function(this__15, map__111)
    local t_347, t_348, l__113, size__114, t_349, fn__422, inner__115, header__118, i__119, ls__120, i__121, noop__123, dash__126;
    l__113 = temper.mapped_tolist(map__111);
    size__114 = this__15.nsyms__94;
    t_349 = this__15.table__95;
    fn__422 = function(ent__116)
      return ent__116:toMarkdownWith(size__114);
    end;
    inner__115 = temper.listed_join(t_349, '\n', fn__422);
    header__118 = temper.listbuilder_constructor();
    temper.listbuilder_add(header__118, 'state');
    i__119 = 0.0;
    while (i__119 < this__15.nsyms__94) do
      temper.listbuilder_add(header__118, '');
      i__119 = (i__119 + 1.0);
    end
    ls__120 = temper.mapped_tolist(map__111);
    i__121 = 0.0;
    while true do
      local ent__122;
      t_347 = temper.list_length(ls__120);
      if not (i__121 < t_347) then
        break;
      else
      end
      t_348 = temper.list_get(ls__120, i__121);
      ent__122 = t_348;
      temper.listbuilder_set(header__118, (ent__122.value + 1.0), temper.concat('#', temper.int_tostring(ent__122.key)));
      i__121 = (i__121 + 1.0);
    end
    noop__123 = function(s__124)
      return s__124;
    end;
    dash__126 = function(s__127)
      return '---';
    end;
    return temper.concat('\n|', temper.listed_join(header__118, '|', noop__123), '|\n|', temper.listed_join(header__118, '|', dash__126), '|\n', inner__115, '\n');
  end;
  TransitionTable.methods.toDotWith = function(this__16, map__130, color__131)
    local t_350, t_351, l__133, size__134, t_352, fn__403, inner__135, header__138, i__139, ls__140, i__141, noop__143, dash__146, t_353;
    l__133 = temper.mapped_tolist(map__130);
    size__134 = this__16.nsyms__94;
    t_352 = this__16.table__95;
    fn__403 = function(ent__136)
      return ent__136:toDotWith(size__134);
    end;
    inner__135 = temper.listed_join(t_352, '', fn__403);
    header__138 = temper.listbuilder_constructor();
    temper.listbuilder_add(header__138, '<TD>state</TD>');
    i__139 = 0.0;
    while (i__139 < this__16.nsyms__94) do
      temper.listbuilder_add(header__138, '');
      i__139 = (i__139 + 1.0);
    end
    ls__140 = temper.mapped_tolist(map__130);
    i__141 = 0.0;
    while true do
      local ent__142;
      t_350 = temper.list_length(ls__140);
      if not (i__141 < t_350) then
        break;
      else
      end
      t_351 = temper.list_get(ls__140, i__141);
      ent__142 = t_351;
      temper.listbuilder_set(header__138, (ent__142.value + 1.0), temper.concat('<TD>#', temper.int_tostring(ent__142.key), '</TD>'));
      i__141 = (i__141 + 1.0);
    end
    noop__143 = function(s__144)
      return s__144;
    end;
    dash__146 = function(s__147)
      return '---';
    end;
    t_353 = temper.listed_join(header__138, '', noop__143);
    return temper.concat('<TABLE border="0" cellspacing="5" bgcolor="', color__131, '"><TR>', t_353, '</TR>', inner__135, '</TABLE>');
  end;
  TransitionTable.get.nsyms = function(this__159)
    return this__159.nsyms__94;
  end;
  TransitionTable.get.table = function(this__163)
    return this__163.table__95;
  end;
  toVec = function(ls__55, size__56)
    local t_354, t_355, vec__58, i__59;
    vec__58 = temper.densebitvector_constructor(0.0);
    i__59 = 0.0;
    while true do
      t_354 = temper.list_length(ls__55);
      if not (i__59 < t_354) then
        break;
      else
      end
      t_355 = temper.list_get(ls__55, i__59);
      temper.densebitvector_set(vec__58, t_355, true);
      i__59 = (i__59 + 1.0);
    end
    return vec__58;
  end;
  fromVec = function(vec__60, size__61)
    local key__63, i__64;
    key__63 = temper.listbuilder_constructor();
    i__64 = 0.0;
    while (i__64 < size__61) do
      if temper.densebitvector_get(vec__60, i__64) then
        temper.listbuilder_add(key__63, i__64);
      else
      end
      i__64 = (i__64 + 1.0);
    end
    return temper.listbuilder_tolist(key__63);
  end;
  exports = {};
  exports.TransitionTableEntry = TransitionTableEntry;
  exports.TransitionTable = TransitionTable;
  exports.toVec = toVec;
  exports.fromVec = fromVec;
  return exports;
end
