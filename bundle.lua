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
  TemperRegex.constructor = function(this__0, data__33)
    temper.virtual();
    return nil;
  end;
  TemperRegex.methods.split = function(this__1, text__36, replace__37)
    return__5 = temper.virtual();
  end;
  TemperRegex.methods.found = function(this__2, text__40)
    return__6 = temper.virtual();
  end;
  TemperRegex.methods.find = function(this__3, text__43)
    return__7 = temper.virtual();
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
    local t_434, t_435, t_436, t_437;
    t_434 = this__9.engine__86;
    t_435 = temper.float64_toint(temper.mul(this__9.score__87, 100.0));
    t_436 = temper.int_tofloat64(t_435);
    t_437 = temper.fdiv(t_436, 100.0);
    return temper.concat(t_434, ': ', temper.float64_tostring(t_437));
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
    local t_438, t_439, t_440, fn__540, fn__539;
    this__10.time__93 = getTime__101;
    t_438 = temper.listbuilder_constructor();
    this__10.engines__94 = t_438;
    t_439 = temper.listbuilder_constructor();
    this__10.checks__95 = t_439;
    t_440 = temper.listbuilder_constructor();
    this__10.regex__96 = t_440;
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
    local t_441;
    t_441 = parse(str__126);
    this__17:addRegex(t_441);
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
    local t_442, t_443, t_444, t_445, t_446, t_447, t_448, t_449, t_450, t_451, t_452, t_453, t_454, runs__153, i__154;
    runs__153 = temper.listbuilder_constructor();
    i__154 = 0.0;
    while true do
      local engine__155, count__156, total__157, j__158;
      t_442 = temper.listbuilder_length(this__24.engines__94);
      if not (i__154 < t_442) then
        break;
      else
      end
      t_448 = temper.listed_get(this__24.engines__94, i__154);
      engine__155 = t_448;
      count__156 = 0.0;
      total__157 = 0.0;
      j__158 = 0.0;
      while true do
        local re__159, tcre__160, k__161;
        t_443 = temper.listbuilder_length(this__24.regex__96);
        if not (j__158 < t_443) then
          break;
        else
        end
        t_449 = temper.listed_get(this__24.regex__96, j__158);
        re__159 = t_449;
        tcre__160 = engine__155:invoke(re__159);
        k__161 = 0.0;
        while true do
          local check__162, iters__163, found__164, beginTime__165, endTime__167, ms__168, score__169, thisRun__170;
          t_444 = temper.listbuilder_length(this__24.checks__95);
          if not (k__161 < t_444) then
            break;
          else
          end
          t_450 = temper.listed_get(this__24.checks__95, k__161);
          check__162 = t_450;
          iters__163 = 1.0;
          t_445 = this__24:isFound(tcre__160, check__162);
          found__164 = t_445;
          beginTime__165 = this__24.time__93();
          while true do
            local l__166;
            l__166 = 0.0;
            while (l__166 < iters__163) do
              t_446 = this__24:isFound(tcre__160, check__162);
              found__164 = t_446;
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
          t_451 = temper.int_tofloat64(iters__163);
          t_452 = temper.fdiv(t_451, ms__168);
          score__169 = t_452;
          count__156 = temper.add(count__156, 1.0);
          total__157 = temper.add(total__157, score__169);
          thisRun__170 = SingleResult(engine__155.name, check__162, regexToString(re__159), found__164, score__169);
          this__24.onSingleResultCallback__97(thisRun__170);
          temper.listbuilder_add(runs__153, thisRun__170);
          k__161 = (k__161 + 1.0);
        end
        j__158 = (j__158 + 1.0);
      end
      t_454 = this__24.onEngineResultCallback__98;
      t_447 = engine__155.name;
      t_453 = temper.fdiv(total__157, count__156);
      t_454(EngineResult__8(t_447, t_453));
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
  local RegexNode, Capture, CodePart, Special, SpecialSet, CodeRange, ItemizedRegex, CodeSet, Repeat, entire, oneOrMore, optional, Group, Regex, Begin, Dot, End, Digit, Space, Word, CodePoints, Or, Sequence, WordBoundary, TemperRegexNFA, t_455, idStart__25, idNumber__26, word__27, nfa__28, t_456, t_457, found__30, exports;
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
  t_455 = 0.0;
  idStart__25 = (Or(temper.listof(CodePoints('a'), CodePoints('b'), CodePoints('c'))):compiled()).data;
  idNumber__26 = (Or(temper.listof(CodePoints('1'), CodePoints('2'), CodePoints('3'))):compiled()).data;
  word__27 = Sequence(temper.listof(WordBoundary, idStart__25, idNumber__26, WordBoundary));
  nfa__28 = TemperRegexNFA(word__27);
  temper.log(nfa__28:toString());
  t_456 = nil;
  t_456 = word__27:find('1a b2 c3');
  t_457 = nil;
  t_457 = temper.mapped_get(t_456, 'full');
  found__30 = t_457.value;
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
    local return__4, t_258, t_259, t_260, i__15;
    ::continue_31::i__15 = 0.0;
    while true do
      t_258 = temper.list_length(this__2.tries__6);
      if not (i__15 < t_258) then
        break;
      else
      end
      t_260 = this__2.check__7;
      t_259 = temper.list_get(this__2.tries__6, i__15);
      if t_260(str__13, t_259) then
        return__4 = true;
        goto break_30;
      else
      end
      i__15 = (i__15 + 1.0);
    end
    return__4 = false;
    ::break_30::return return__4;
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
  Engine.constructor = function(this__22)
    local t_111, t_112, t_113, t_114;
    t_111 = temper.listbuilder_constructor();
    this__22.states__96 = t_111;
    t_112 = this__22:newState();
    this__22.startState__97 = t_112;
    t_113 = this__22:newState();
    this__22.endState__98 = t_113;
    t_114 = EpsilonMatcher();
    this__22.epsilon__99 = t_114;
    return nil;
  end;
  Engine.methods.opt = function(this__23)
    local cur__104, t_115;
    cur__104 = this__23;
    t_115 = cur__104:optDeadCode();
    cur__104 = t_115;
    return cur__104;
  end;
  Engine.methods.optDeadCode = function(this__24)
    local unopt__108, opt__109, map__110, visit__107;
    unopt__108 = this__24;
    opt__109 = Engine();
    map__110 = temper.mapbuilder_constructor();
    visit__107 = function(state__111)
      local return__35, t_116, t_117, t_118, t_119, t_120, t_121, t_122, t_123, t_124, t_125, t_126, t_127, t_128, t_129, t_130, optId__113, local_131, local_132, local_133, outState__114, i__115;
      ::continue_19::local_131, local_132, local_133 = temper.pcall(function()
        t_116 = state__111.id;
        t_129 = temper.mapped_get(map__110, t_116);
        optId__113 = t_129;
      end);
      if local_131 then
      else
        optId__113 = -1.0;
      end
      if (optId__113 >= 0.0) then
        t_117 = opt__109.states;
        return__35 = temper.listed_get(t_117, optId__113);
        goto break_18;
      else
      end
      t_118 = unopt__108.startState;
      if temper.generic_eq(state__111, t_118) then
        t_119 = opt__109.startState;
        outState__114 = t_119;
      else
        t_120 = unopt__108.endState;
        if temper.generic_eq(state__111, t_120) then
          t_121 = opt__109.endState;
          outState__114 = t_121;
        else
          t_122 = opt__109:newState();
          outState__114 = t_122;
        end
      end
      t_123 = state__111.id;
      t_124 = outState__114.id;
      temper.mapbuilder_set(map__110, t_123, t_124);
      i__115 = 0.0;
      while true do
        local next__116;
        t_125 = temper.listbuilder_length(state__111.next);
        if not (i__115 < t_125) then
          break;
        else
        end
        t_130 = temper.listed_get(state__111.next, i__115);
        next__116 = t_130;
        t_126 = next__116.matcher;
        t_127 = next__116.toState;
        t_128 = visit__107(t_127);
        outState__114:addNext(t_126, t_128);
        i__115 = (i__115 + 1.0);
      end
      return__35 = outState__114;
      ::break_18::return return__35;
    end;
    visit__107(this__24.startState__97);
    return opt__109;
  end;
  Engine.methods.optEpsilonEllison = function(this__25)
    local unopt__120, opt__121, map__122, visit__119;
    unopt__120 = this__25;
    opt__121 = Engine();
    map__122 = temper.mapbuilder_constructor();
    visit__119 = function(state__123)
      local return__37, t_135, t_136, t_137, t_138, t_139, t_140, t_141, t_142, t_143, t_144, t_145, t_146, t_147, t_148, optId__126, local_149, local_150, local_151, outState__127, added__128, count__129, isFinal__130, add__125, i__136;
      ::continue_21::local_149, local_150, local_151 = temper.pcall(function()
        t_135 = state__123.id;
        t_145 = temper.mapped_get(map__122, t_135);
        optId__126 = t_145;
      end);
      if local_149 then
      else
        optId__126 = -1.0;
      end
      if (optId__126 >= 0.0) then
        t_136 = opt__121.states;
        return__37 = temper.listed_get(t_136, optId__126);
        goto break_20;
      else
      end
      t_137 = unopt__120.startState;
      if temper.generic_eq(state__123, t_137) then
        t_138 = opt__121.startState;
        t_146 = t_138;
      else
        t_139 = unopt__120.endState;
        if temper.generic_eq(state__123, t_139) then
          t_140 = opt__121.endState;
          t_146 = t_140;
        else
          t_141 = opt__121:newState();
          t_146 = t_141;
        end
      end
      outState__127 = t_146;
      t_142 = state__123.id;
      t_143 = outState__127.id;
      temper.mapbuilder_set(map__122, t_142, t_143);
      added__128 = temper.densebitvector_constructor(0.0);
      count__129 = 0.0;
      isFinal__130 = false;
      add__125 = function(matcher__131, toState__132)
        local return__38, t_153, t_154, t_155, t_156, t_157, t_158, t_159, t_160;
        ::continue_23::t_153 = unopt__120.epsilon;
        if temper.generic_eq(matcher__131, t_153) then
          local i__134;
          t_154 = toState__132.id;
          if temper.densebitvector_get(added__128, t_154) then
            return__38 = nil;
            goto break_22;
          else
          end
          t_155 = toState__132.id;
          temper.densebitvector_set(added__128, t_155, true);
          if (toState__132.id == 1.0) then
            isFinal__130 = true;
            return__38 = nil;
            goto break_22;
          else
          end
          i__134 = 0.0;
          while true do
            local next__135;
            t_156 = temper.listbuilder_length(toState__132.next);
            if not (i__134 < t_156) then
              break;
            else
            end
            t_160 = temper.listed_get(toState__132.next, i__134);
            next__135 = t_160;
            t_157 = next__135.matcher;
            t_158 = next__135.toState;
            add__125(t_157, t_158);
            i__134 = (i__134 + 1.0);
          end
        else
          count__129 = (count__129 + 1.0);
          t_159 = visit__119(toState__132);
          outState__127:addNext(matcher__131, t_159);
        end
        return__38 = nil;
        ::break_22::return return__38;
      end;
      i__136 = 0.0;
      while true do
        local next__137;
        t_144 = temper.listbuilder_length(state__123.next);
        if not (i__136 < t_144) then
          break;
        else
        end
        t_147 = temper.listed_get(state__123.next, i__136);
        next__137 = t_147;
        add__125(next__137.matcher, next__137.toState);
        i__136 = (i__136 + 1.0);
      end
      if (count__129 == 0.0) then
        t_148 = true;
      else
        t_148 = isFinal__130;
      end
      if t_148 then
        return__37 = opt__121.endState;
        goto break_20;
      else
      end
      return__37 = outState__127;
      ::break_20::return return__37;
    end;
    visit__119(this__25.startState__97);
    return opt__121;
  end;
  Engine.methods.newState = function(this__26)
    local ret__140;
    ret__140 = State(temper.listbuilder_length(this__26.states__96));
    temper.listbuilder_add(this__26.states__96, ret__140);
    return ret__140;
  end;
  Engine.methods.split = function(this__27, str__142)
    local t_161, t_162, t_163, t_164, t_165, t_166, codePoints__144, stackStart__145, badNext__146, last__147, ret__148, i__149, cur__161, j__162;
    codePoints__144 = temper.listed_map(temper.string_split(str__142, ''), ord);
    stackStart__145 = StackStart();
    badNext__146 = Next(this__27.endState__98, this__27.epsilon__99);
    last__147 = 0.0;
    ret__148 = temper.listbuilder_constructor();
    i__149 = 0.0;
    while true do
      local stack__150;
      t_161 = temper.list_length(codePoints__144);
      if not (i__149 < t_161) then
        break;
      else
      end
      t_162 = StackSlot(i__149, this__27.startState__97, stackStart__145);
      stack__150 = t_162;
      while temper.generic_ne(stack__150, stackStart__145) do
        local index__151, state__152, next__155, len__156, c__157;
        index__151 = stack__150.index;
        state__152 = stack__150.state;
        t_163 = stack__150.next;
        stack__150 = t_163;
        if (state__152.id == this__27.endState__98.id) then
          local cur__153, j__154;
          cur__153 = temper.listbuilder_constructor();
          j__154 = last__147;
          while (j__154 < i__149) do
            temper.listbuilder_add(cur__153, temper.listed_getor(codePoints__144, j__154, 0.0));
            j__154 = (j__154 + 1.0);
          end
          i__149 = (index__151 - 1.0);
          last__147 = index__151;
          temper.listbuilder_add(ret__148, temper.listed_join(cur__153, '', chr));
          break;
        else
        end
        next__155 = state__152.next;
        len__156 = temper.listbuilder_length(next__155);
        c__157 = 0.0;
        while (c__157 < len__156) do
          local matcher__159, toState__160;
          t_164 = temper.listed_getor(next__155, c__157, badNext__146);
          matcher__159 = t_164.matcher;
          toState__160 = t_164.toState;
          if matcher__159:matches(codePoints__144, index__151) then
            t_165 = StackSlot((index__151 + matcher__159:width()), toState__160, stack__150);
            stack__150 = t_165;
          else
          end
          c__157 = (c__157 + 1.0);
        end
      end
      i__149 = (i__149 + 1.0);
    end
    cur__161 = temper.listbuilder_constructor();
    j__162 = last__147;
    while true do
      t_166 = temper.list_length(codePoints__144);
      if not (j__162 < t_166) then
        break;
      else
      end
      temper.listbuilder_add(cur__161, temper.listed_getor(codePoints__144, j__162, 0.0));
      j__162 = (j__162 + 1.0);
    end
    temper.listbuilder_add(ret__148, temper.listed_join(cur__161, '', chr));
    return ret__148;
  end;
  Engine.methods.found = function(this__28, str__164)
    local return__41, t_167, t_168, t_169, t_170, t_171, codePoints__166, stackStart__167, badNext__168, i__169;
    ::continue_25::codePoints__166 = temper.listed_map(temper.string_split(str__164, ''), ord);
    stackStart__167 = StackStart();
    badNext__168 = Next(this__28.endState__98, this__28.epsilon__99);
    i__169 = 0.0;
    while true do
      local stack__170;
      t_167 = temper.list_length(codePoints__166);
      if not (i__169 < t_167) then
        break;
      else
      end
      t_168 = StackSlot(i__169, this__28.startState__97, stackStart__167);
      stack__170 = t_168;
      while temper.generic_ne(stack__170, stackStart__167) do
        local index__171, state__172, next__173, len__174, c__175;
        index__171 = stack__170.index;
        state__172 = stack__170.state;
        t_169 = stack__170.next;
        stack__170 = t_169;
        if (state__172.id == this__28.endState__98.id) then
          return__41 = true;
          goto break_24;
        else
        end
        next__173 = state__172.next;
        len__174 = temper.listbuilder_length(next__173);
        c__175 = 0.0;
        while (c__175 < len__174) do
          local matcher__177, toState__178;
          t_170 = temper.listed_getor(next__173, c__175, badNext__168);
          matcher__177 = t_170.matcher;
          toState__178 = t_170.toState;
          if matcher__177:matches(codePoints__166, index__171) then
            t_171 = StackSlot((index__171 + matcher__177:width()), toState__178, stack__170);
            stack__170 = t_171;
          else
          end
          c__175 = (c__175 + 1.0);
        end
      end
      i__169 = (i__169 + 1.0);
    end
    return__41 = false;
    ::break_24::return return__41;
  end;
  Engine.methods.find = function(this__29, str__180)
    local return__42, t_172, t_173, t_174, t_175, t_176, t_177, t_178, t_179, t_180, t_181, t_182, t_183, t_184, t_185, groups__182, pending__183, codePoints__184, stackStart__185, badNext__186, i__187;
    ::continue_27::groups__182 = temper.mapbuilder_constructor();
    pending__183 = temper.mapbuilder_constructor();
    codePoints__184 = temper.listed_map(temper.string_split(str__180, ''), ord);
    stackStart__185 = StackStart();
    badNext__186 = Next(this__29.endState__98, this__29.epsilon__99);
    i__187 = 0.0;
    while true do
      local stack__188;
      t_172 = temper.list_length(codePoints__184);
      if not (i__187 < t_172) then
        break;
      else
      end
      t_173 = StackSlot(i__187, this__29.startState__97, stackStart__185);
      stack__188 = t_173;
      while temper.generic_ne(stack__188, stackStart__185) do
        local index__189, state__190, next__200, len__201, c__202;
        index__189 = stack__188.index;
        state__190 = stack__188.state;
        t_174 = stack__188.next;
        stack__188 = t_174;
        if (state__190.id == this__29.endState__98.id) then
          local ret__191, keys__192, i__193, str__198, j__199;
          ret__191 = temper.mapbuilder_constructor();
          keys__192 = temper.mapped_keys(groups__182);
          i__193 = 0.0;
          while true do
            local key__194, val__195, str__196, j__197;
            ::continue_29::t_175 = temper.listed_length(keys__192);
            if not (i__193 < t_175) then
              break;
            else
            end
            t_181 = temper.listed_get(keys__192, i__193);
            key__194 = t_181;
            t_182 = temper.mapped_get(groups__182, key__194);
            val__195 = t_182;
            if (val__195.value < 0.0) then
              goto break_28;
            else
            end
            str__196 = temper.listbuilder_constructor();
            t_176 = val__195.key;
            j__197 = t_176;
            while true do
              t_177 = val__195.value;
              if not (j__197 < t_177) then
                break;
              else
              end
              temper.listbuilder_add(str__196, temper.listed_getor(codePoints__184, j__197, 0.0));
              j__197 = (j__197 + 1.0);
            end
            temper.mapbuilder_set(ret__191, key__194, Group(key__194, temper.listed_join(str__196, '', chr), val__195.key));
            ::break_28::i__193 = (i__193 + 1.0);
          end
          str__198 = temper.listbuilder_constructor();
          j__199 = i__187;
          while (j__199 < index__189) do
            temper.listbuilder_add(str__198, temper.listed_getor(codePoints__184, j__199, 0.0));
            j__199 = (j__199 + 1.0);
          end
          if not temper.mapped_has(ret__191, 'full') then
            temper.mapbuilder_set(ret__191, 'full', Group('full', temper.listed_join(str__198, '', chr), i__187));
          else
          end
          return__42 = ret__191;
          goto break_26;
        else
        end
        next__200 = state__190.next;
        len__201 = temper.listbuilder_length(next__200);
        c__202 = 0.0;
        while (c__202 < len__201) do
          local matcher__204, toState__205;
          t_178 = temper.listed_getor(next__200, c__202, badNext__186);
          matcher__204 = t_178.matcher;
          toState__205 = t_178.toState;
          if matcher__204:matches(codePoints__184, index__189) then
            if temper.instance_of(matcher__204, StartGroupMatcher) then
              t_183 = temper.cast_to(matcher__204, StartGroupMatcher);
              temper.mapbuilder_set(pending__183, t_183.name, index__189);
            elseif temper.instance_of(matcher__204, EndGroupMatcher) then
              t_184 = temper.cast_to(matcher__204, EndGroupMatcher);
              t_179 = t_184.name;
              t_185 = temper.mapped_get(pending__183, t_184.name);
              temper.mapbuilder_set(groups__182, t_179, temper.pair_constructor(t_185, index__189));
            else
            end
            t_180 = StackSlot((index__189 + matcher__204:width()), toState__205, stack__188);
            stack__188 = t_180;
          else
          end
          c__202 = (c__202 + 1.0);
        end
      end
      i__187 = (i__187 + 1.0);
    end
    return__42 = temper.map_constructor(temper.listof());
    ::break_26::return return__42;
  end;
  Engine.methods.toString = function(this__30)
    local count__208, t_186, fn__1066, inner__209;
    count__208 = 0.0;
    t_186 = this__30.states__96;
    fn__1066 = function(state__210)
      local name__212, t_187, fn__1059;
      name__212 = temper.concat('q', temper.int_tostring(state__210.id));
      t_187 = state__210.next;
      fn__1059 = function(next__213)
        local line__215, nexts__216, t_188;
        line__215 = temper.int_tostring(count__208);
        count__208 = (count__208 + 1.0);
        nexts__216 = temper.int_tostring(next__213.toState.id);
        t_188 = next__213.matcher:toString();
        return temper.concat('\n  ', name__212, ' -> q', nexts__216, ' [label="', t_188, '"];');
      end;
      return temper.listed_join(t_187, '', fn__1059);
    end;
    inner__209 = temper.listed_join(t_186, '', fn__1066);
    return temper.concat('digraph {\n  rankdir="LR";', inner__209, '\n}');
  end;
  Engine.methods.toDotSub = function(this__31, gname__218, color__219)
    local count__221, used__222, t_189, fn__1042, inner__223, t_194, fn__1041, decls__231;
    count__221 = 0.0;
    used__222 = temper.mapbuilder_constructor();
    t_189 = this__31.states__96;
    fn__1042 = function(state__224)
      local name__226, t_190, t_191, fn__1032;
      name__226 = temper.concat('q', temper.int_tostring(state__224.id));
      t_190 = state__224.id;
      temper.mapbuilder_set(used__222, t_190, true);
      t_191 = state__224.next;
      fn__1032 = function(next__227)
        local line__229, nexts__230, t_192, t_193;
        line__229 = temper.int_tostring(count__221);
        count__221 = (count__221 + 1.0);
        nexts__230 = temper.int_tostring(next__227.toState.id);
        t_192 = next__227.toState.id;
        temper.mapbuilder_set(used__222, t_192, true);
        t_193 = next__227.matcher:toString();
        return temper.concat('\n    ', gname__218, '_', name__226, ' -> ', gname__218, '_q', nexts__230, ' [label="', t_193, '"];');
      end;
      return temper.listed_join(t_191, '', fn__1032);
    end;
    inner__223 = temper.listed_join(t_189, '', fn__1042);
    t_194 = this__31.states__96;
    fn__1041 = function(state__232)
      local return__49, t_195, t_196, t_197, local_198, local_199, local_200;
      local_198, local_199, local_200 = temper.pcall(function()
        t_195 = state__232.id;
        t_196 = temper.mapped_get(used__222, t_195);
        t_197 = t_196;
      end);
      if local_198 then
      else
        t_197 = false;
      end
      if t_197 then
        local name__234, label__235, shape__236;
        name__234 = temper.concat('q', temper.int_tostring(state__232.id));
        if (state__232.id == 0.0) then
          label__235 = 'start';
        elseif (state__232.id == 1.0) then
          label__235 = 'end';
        else
          label__235 = name__234;
        end
        shape__236 = 'ellipse';
        return__49 = temper.concat('\n    ', gname__218, '_', name__234, ' [shape="', shape__236, '"] [label="', label__235, '"];');
      else
        return__49 = '';
      end
      return return__49;
    end;
    decls__231 = temper.listed_join(t_194, '', fn__1041);
    return temper.concat('subgraph ', gname__218, ' {\n    node [style=filled color="', color__219, '"];\n    color="#E7E7E7";\n    label="NFA";\n    rankdir="LR";', decls__231, inner__223, '\n  }');
  end;
  Engine.get.states = function(this__239)
    return this__239.states__96;
  end;
  Engine.get.startState = function(this__243)
    return this__243.startState__97;
  end;
  Engine.get.endState = function(this__247)
    return this__247.endState__98;
  end;
  Engine.get.epsilon = function(this__251)
    return this__251.epsilon__99;
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
  TemperRegexNFA.constructor = function(this__21, regex__76)
    local t_202, t_203, t_204, t_205;
    t_202 = Engine();
    this__21.engine__74 = t_202;
    t_203 = this__21.engine__74.startState;
    t_204 = this__21.engine__74.endState;
    this__21:buildRegex(regex__76, t_203, t_204);
    t_205 = this__21.engine__74:opt();
    this__21.engine__74 = t_205;
    return nil;
  end;
  TemperRegexNFA.methods.buildRegex = function(this__22, regex__79, input__80, output__81)
    local t_206, t_207, t_208, t_209, t_210, t_211, t_212, t_213, t_214, t_215, t_216, t_217, t_218, t_219, t_220, t_221, t_222, t_223, t_224, t_225, t_226, t_227, t_228, t_229, t_230, t_231, t_232, t_233, t_234, t_235, t_236, t_237, t_238, t_239, t_240, t_241, t_242, t_243, t_244, t_245, t_246, t_247, t_248, t_249, t_250, t_251, t_252, t_253, t_254, t_255, t_256, t_257, split__85, lastState__86, i__87, bitset__89, j__90, i__95, lastState__96, i__97, nextState__102, j__103, bitset__105, i__106;
    if temper.instance_of(regex__79, Capture) then
      local mid1__83, mid2__84;
      t_240 = temper.cast_to(regex__79, Capture);
      mid1__83 = this__22.engine__74:newState();
      mid2__84 = this__22.engine__74:newState();
      t_206 = StartGroupMatcher(t_240.name);
      input__80:addNext(t_206, mid1__83);
      t_207 = t_240.item;
      this__22:buildRegex(t_207, mid1__83, mid2__84);
      mid2__84:addNext(EndGroupMatcher(t_240.name), output__81);
    elseif temper.instance_of(regex__79, CodePoints) then
      t_241 = temper.cast_to(regex__79, CodePoints);
      split__85 = temper.string_split(t_241.value, '');
      lastState__86 = input__80;
      i__87 = 0.0;
      while true do
        t_208 = temper.list_length(split__85);
        if not (i__87 < t_208) then
          break;
        else
        end
        t_209 = temper.list_length(split__85);
        if (i__87 == (t_209 - 1.0)) then
          t_242 = temper.list_get(split__85, i__87);
          t_210 = CharMatcher(t_242);
          lastState__86:addNext(t_210, output__81);
        else
          local curState__88;
          curState__88 = this__22.engine__74:newState();
          t_243 = temper.list_get(split__85, i__87);
          t_211 = CharMatcher(t_243);
          lastState__86:addNext(t_211, curState__88);
          lastState__86 = curState__88;
        end
        i__87 = (i__87 + 1.0);
      end
    elseif temper.instance_of(regex__79, CodeSet) then
      t_244 = temper.cast_to(regex__79, CodeSet);
      bitset__89 = temper.densebitvector_constructor(0.0);
      j__90 = 0.0;
      while true do
        local subRegex__91, split__93, i__94;
        t_212 = temper.list_length(t_244.items);
        if not (j__90 < t_212) then
          break;
        else
        end
        t_245 = temper.list_get(t_244.items, j__90);
        subRegex__91 = t_245;
        if temper.instance_of(subRegex__91, CodeRange) then
          local i__92;
          t_246 = temper.cast_to(subRegex__91, CodeRange);
          t_213 = t_246.min;
          i__92 = t_213;
          while true do
            t_214 = t_246.max;
            if not (i__92 <= t_214) then
              break;
            else
            end
            temper.densebitvector_set(bitset__89, i__92, true);
            i__92 = (i__92 + 1.0);
          end
        elseif temper.instance_of(subRegex__91, CodePoints) then
          t_247 = temper.cast_to(subRegex__91, CodePoints);
          split__93 = temper.string_split(t_247.value, '');
          i__94 = 0.0;
          while true do
            t_215 = temper.list_length(split__93);
            if not (i__94 < t_215) then
              break;
            else
            end
            t_248 = temper.list_get(split__93, i__94);
            temper.densebitvector_set(bitset__89, temper.string_codeat(t_248, 1.0), true);
            i__94 = (i__94 + 1.0);
          end
        else
        end
        j__90 = (j__90 + 1.0);
      end
      t_216 = BitSetMatcher(bitset__89, not t_244.negated);
      input__80:addNext(t_216, output__81);
    elseif temper.instance_of(regex__79, Or) then
      t_249 = temper.cast_to(regex__79, Or);
      i__95 = 0.0;
      while true do
        t_217 = temper.list_length(t_249.items);
        if not (i__95 < t_217) then
          break;
        else
        end
        t_250 = temper.list_get(t_249.items, i__95);
        this__22:buildRegex(t_250, input__80, output__81);
        i__95 = (i__95 + 1.0);
      end
    elseif temper.instance_of(regex__79, Repeat) then
      t_251 = temper.cast_to(regex__79, Repeat);
      lastState__96 = input__80;
      i__97 = 0.0;
      while true do
        local curState__98;
        t_218 = t_251.min;
        if not (i__97 < t_218) then
          break;
        else
        end
        curState__98 = this__22.engine__74:newState();
        t_219 = t_251.item;
        this__22:buildRegex(t_219, lastState__96, curState__98);
        lastState__96 = curState__98;
        i__97 = (i__97 + 1.0);
      end
      t_252 = t_251.max;
      if (t_252 ~= temper.null) then
        local max__99, i__100;
        t_253 = t_251.max;
        max__99 = temper.cast_to_int(t_253);
        t_220 = t_251.min;
        i__100 = t_220;
        while (i__100 < max__99) do
          local curState__101;
          curState__101 = this__22.engine__74:newState();
          if t_251.reluctant then
            t_221 = t_251.item;
            this__22:buildRegex(t_221, lastState__96, curState__101);
            t_222 = this__22.engine__74.epsilon;
            lastState__96:addNext(t_222, output__81);
          else
            t_223 = this__22.engine__74.epsilon;
            lastState__96:addNext(t_223, output__81);
            t_224 = t_251.item;
            this__22:buildRegex(t_224, lastState__96, curState__101);
          end
          lastState__96 = curState__101;
          i__100 = (i__100 + 1.0);
        end
        t_225 = this__22.engine__74.epsilon;
        lastState__96:addNext(t_225, output__81);
      elseif t_251.reluctant then
        t_226 = t_251.item;
        this__22:buildRegex(t_226, lastState__96, lastState__96);
        t_227 = this__22.engine__74.epsilon;
        lastState__96:addNext(t_227, output__81);
      else
        t_228 = this__22.engine__74.epsilon;
        lastState__96:addNext(t_228, output__81);
        t_229 = t_251.item;
        this__22:buildRegex(t_229, lastState__96, lastState__96);
      end
    elseif temper.instance_of(regex__79, Sequence) then
      t_254 = temper.cast_to(regex__79, Sequence);
      nextState__102 = output__81;
      t_230 = temper.list_length(t_254.items);
      j__103 = (t_230 - 1.0);
      while (j__103 >= 0.0) do
        local curState__104;
        if (j__103 == 0.0) then
          t_255 = input__80;
        else
          t_231 = this__22.engine__74:newState();
          t_255 = t_231;
        end
        curState__104 = t_255;
        t_256 = temper.list_get(t_254.items, j__103);
        this__22:buildRegex(t_256, curState__104, nextState__102);
        nextState__102 = curState__104;
        j__103 = (j__103 - 1.0);
      end
      if (temper.list_length(t_254.items) == 0.0) then
        t_232 = this__22.engine__74.epsilon;
        input__80:addNext(t_232, nextState__102);
      else
      end
    elseif temper.instance_of(regex__79, Special) then
      t_257 = temper.cast_to(regex__79, Special);
      if temper.generic_eq(t_257, Begin) then
        t_233 = BeginMatcher();
        input__80:addNext(t_233, output__81);
      elseif temper.generic_eq(t_257, Dot) then
        t_234 = AnyMatcher();
        input__80:addNext(t_234, output__81);
      elseif temper.generic_eq(t_257, End) then
        t_235 = EndMatcher();
        input__80:addNext(t_235, output__81);
      elseif temper.generic_eq(t_257, WordBoundary) then
        t_236 = WordBoundaryMatcher();
        input__80:addNext(t_236, output__81);
      elseif temper.generic_eq(t_257, Digit) then
        bitset__105 = temper.densebitvector_constructor(64.0);
        i__106 = 48.0;
        while (i__106 <= 57.0) do
          temper.densebitvector_set(bitset__105, i__106, true);
          i__106 = (i__106 + 1.0);
        end
        t_237 = BitSetMatcher(bitset__105, true);
        input__80:addNext(t_237, output__81);
      elseif temper.generic_eq(t_257, Space) then
        t_238 = SpaceClassMatcher();
        input__80:addNext(t_238, output__81);
      elseif temper.generic_eq(t_257, Word) then
        t_239 = WordClassMatcher();
        input__80:addNext(t_239, output__81);
      else
        temper.bubble();
      end
    else
    end
    return nil;
  end;
  TemperRegexNFA.methods.split = function(this__23, str__108)
    return this__23.engine__74:split(str__108);
  end;
  TemperRegexNFA.methods.found = function(this__24, str__111)
    return this__24.engine__74:found(str__111);
  end;
  TemperRegexNFA.methods.find = function(this__25, text__114)
    return this__25.engine__74:find(text__114);
  end;
  TemperRegexNFA.methods.toString = function(this__26)
    return this__26.engine__74:toString();
  end;
  TemperRegexNFA.get.engine = function(this__120)
    return this__120.engine__74;
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
    local t_261;
    t_261 = temper.listbuilder_constructor();
    this__17.list__75 = t_261;
    return nil;
  end;
  RegexBuilder.methods.has = function(this__18, from__79, to__80)
    local return__29, t_262, t_263, t_264, t_265, i__82;
    ::continue_33::i__82 = 0.0;
    while true do
      local edge__83;
      t_262 = temper.listbuilder_length(this__18.list__75);
      if not (i__82 < t_262) then
        break;
      else
      end
      t_264 = temper.listed_get(this__18.list__75, i__82);
      edge__83 = t_264;
      if temper.str_eq(edge__83.to, to__80) then
        t_263 = edge__83.from;
        t_265 = temper.str_eq(t_263, from__79);
      else
        t_265 = false;
      end
      if t_265 then
        return__29 = true;
        goto break_32;
      else
      end
      i__82 = (i__82 + 1.0);
    end
    return__29 = false;
    ::break_32::return return__29;
  end;
  RegexBuilder.methods.find = function(this__19, from__85, to__86)
    local return__30, t_266, t_267, t_268, t_269, i__88;
    ::continue_35::i__88 = 0.0;
    while true do
      local edge__89;
      t_266 = temper.listbuilder_length(this__19.list__75);
      if not (i__88 < t_266) then
        break;
      else
      end
      t_268 = temper.listed_get(this__19.list__75, i__88);
      edge__89 = t_268;
      if temper.str_eq(edge__89.to, to__86) then
        t_267 = edge__89.from;
        t_269 = temper.str_eq(t_267, from__85);
      else
        t_269 = false;
      end
      if t_269 then
        return__30 = edge__89.regex;
        goto break_34;
      else
      end
      i__88 = (i__88 + 1.0);
    end
    temper.bubble();
    ::break_34::return return__30;
  end;
  RegexBuilder.methods.forEachWentFrom = function(this__20, to__91, cb__92)
    local t_270, t_271, t_272, t_273, t_274, t_275, ls__94, i__95, i__97;
    ls__94 = temper.listbuilder_constructor();
    i__95 = 0.0;
    while true do
      local edge__96;
      t_270 = temper.listbuilder_length(this__20.list__75);
      if not (i__95 < t_270) then
        break;
      else
      end
      t_273 = temper.listed_get(this__20.list__75, i__95);
      edge__96 = t_273;
      if temper.str_eq(edge__96.to, to__91) then
        t_271 = edge__96.from;
        t_274 = temper.str_ne(t_271, to__91);
      else
        t_274 = false;
      end
      if t_274 then
        temper.listbuilder_add(ls__94, edge__96);
      else
      end
      i__95 = (i__95 + 1.0);
    end
    i__97 = 0.0;
    while true do
      t_272 = temper.listbuilder_length(ls__94);
      if not (i__97 < t_272) then
        break;
      else
      end
      t_275 = temper.listed_get(ls__94, i__97);
      cb__92(t_275);
      i__97 = (i__97 + 1.0);
    end
    return nil;
  end;
  RegexBuilder.methods.forEachGoesTo = function(this__21, from__99, cb__100)
    local t_276, t_277, t_278, t_279, t_280, t_281, ls__102, i__103, i__105;
    ls__102 = temper.listbuilder_constructor();
    i__103 = 0.0;
    while true do
      local edge__104;
      t_276 = temper.listbuilder_length(this__21.list__75);
      if not (i__103 < t_276) then
        break;
      else
      end
      t_279 = temper.listed_get(this__21.list__75, i__103);
      edge__104 = t_279;
      if temper.str_eq(edge__104.from, from__99) then
        t_277 = edge__104.to;
        t_280 = temper.str_ne(t_277, from__99);
      else
        t_280 = false;
      end
      if t_280 then
        temper.listbuilder_add(ls__102, edge__104);
      else
      end
      i__103 = (i__103 + 1.0);
    end
    i__105 = 0.0;
    while true do
      t_278 = temper.listbuilder_length(ls__102);
      if not (i__105 < t_278) then
        break;
      else
      end
      t_281 = temper.listed_get(ls__102, i__105);
      cb__100(t_281);
      i__105 = (i__105 + 1.0);
    end
    return nil;
  end;
  RegexBuilder.methods.simplify = function(this__22, node__107)
    local t_282, me__109;
    me__109 = this__22;
    if this__22:has(node__107, node__107) then
      local self__110, r1__111, fn__551;
      t_282 = this__22:find(node__107, node__107);
      self__110 = t_282;
      r1__111 = regexToString(self__110);
      fn__551 = function(wentFrom__112)
        local t_283, r0__114, fn__544;
        t_283 = wentFrom__112.regex;
        r0__114 = regexToString(t_283);
        fn__544 = function(goesTo__115)
          local t_284, t_285, t_286, t_287, t_288, t_289, t_290, t_291, t_292, t_293, t_294, t_295, t_296, r2__117;
          t_296 = goesTo__115.regex;
          r2__117 = regexToString(t_296);
          if temper.str_eq(r1__111, r0__114) then
            if temper.str_eq(r1__111, r2__117) then
              t_284 = wentFrom__112.from;
              t_285 = goesTo__115.to;
              t_286 = Sequence(temper.listof(wentFrom__112.regex, Repeat(self__110, 1.0, temper.null, false)));
              me__109:add(t_284, t_285, t_286);
            else
              t_287 = wentFrom__112.from;
              t_288 = goesTo__115.to;
              t_289 = Sequence(temper.listof(Repeat(self__110, 1.0, temper.null, false), goesTo__115.regex));
              me__109:add(t_287, t_288, t_289);
            end
          elseif temper.str_eq(r1__111, r2__117) then
            t_290 = wentFrom__112.from;
            t_291 = goesTo__115.to;
            t_292 = Sequence(temper.listof(wentFrom__112.regex, Repeat(self__110, 1.0, temper.null, false)));
            me__109:add(t_290, t_291, t_292);
          else
            t_293 = wentFrom__112.from;
            t_294 = goesTo__115.to;
            t_295 = Sequence(temper.listof(wentFrom__112.regex, Repeat(self__110, 0.0, temper.null, false), goesTo__115.regex));
            me__109:add(t_293, t_294, t_295);
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
          local t_297, t_298, t_299;
          t_297 = wentFrom__118.from;
          t_298 = goesTo__120.to;
          t_299 = Sequence(temper.listof(wentFrom__118.regex, goesTo__120.regex));
          me__109:add(t_297, t_298, t_299);
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
    local t_300, fn__497;
    t_300 = this__24.list__75;
    fn__497 = function(cur__129)
      local t_301, t_302;
      t_301 = cur__129.from;
      t_302 = cur__129.regex;
      return temper.concat(t_301, ' -> /', regexToString(t_302), '/ -> ', cur__129.to);
    end;
    return temper.listed_join(t_300, '\n', fn__497);
  end;
  RegexBuilder.methods.toRegexList = function(this__25)
    local t_303, t_304, t_305, t_306, t_307, t_308, t_309, t_310, t_311, done__133, j__134, ret__136, j__137;
    done__133 = temper.mapbuilder_constructor();
    temper.mapbuilder_set(done__133, '#begin', true);
    j__134 = 0.0;
    while true do
      local cur__135, local_312, local_313, local_314;
      t_303 = temper.listbuilder_length(this__25.list__75);
      if not (j__134 < t_303) then
        break;
      else
      end
      t_307 = temper.listed_get(this__25.list__75, j__134);
      cur__135 = t_307;
      local_312, local_313, local_314 = temper.pcall(function()
        t_308 = temper.mapped_get(done__133, cur__135.from);
        t_309 = t_308;
      end);
      if local_312 then
      else
        t_309 = false;
      end
      if not t_309 then
        temper.mapbuilder_set(done__133, cur__135.from, true);
        t_304 = cur__135.from;
        this__25:simplify(t_304);
      else
      end
      j__134 = (j__134 + 1.0);
    end
    ret__136 = temper.listbuilder_constructor();
    j__137 = 0.0;
    while true do
      local cur__138;
      t_305 = temper.listbuilder_length(this__25.list__75);
      if not (j__137 < t_305) then
        break;
      else
      end
      t_310 = temper.listed_get(this__25.list__75, j__137);
      cur__138 = t_310;
      if temper.str_eq(cur__138.from, '#begin') then
        t_306 = cur__138.to;
        t_311 = temper.str_eq(t_306, '#end');
      else
        t_311 = false;
      end
      if t_311 then
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
  local RegexNode, CodePoints, CodeRange, CodeSet, Or, Sequence, Capture, CodePart, Special, SpecialSet, ItemizedRegex, Repeat, entire, oneOrMore, optional, Group, Regex, Begin, Dot, End, WordBoundary, Digit, Space, Word, TemperRegexNFA, Engine, State, Matcher, BeginMatcher, EndMatcher, WordBoundaryMatcher, WordClassMatcher, SpaceClassMatcher, AnyMatcher, BitSetMatcher, CharCodeMatcher, StartGroupMatcher, EndGroupMatcher, CharMatcher, EpsilonMatcher, TemperRegex, regexToString, chr, TransitionTable, TransitionTableEntry, toVec, fromVec, RegexBuilder, TemperRegexPatterns, console_337, TemperRegexDFA, emptyList__129, mapToList__78, validFor__79, exports;
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
  console_337 = 0.0;
  TemperRegexDFA = temper.type('TemperRegexDFA', TemperRegex);
  TemperRegexDFA.get.nstates = function(this__37)
    return temper.listbuilder_length(this__37.nfa__155.states);
  end;
  TemperRegexDFA.constructor = function(this__38, regex__159)
    local t_338, t_339, t_340, t_341, t_342, t_343, t_344, t_345, t_346, t_347, t_348, t_349, t_350, t_351, t_352, t_353, t_354, t_355, t_356, t_357, t_358, t_359, t_360, t_361, t_362, t_363, t_364, t_365, t_366, t_367, i__161, pairs__164, i__165, i__173, index__174, i__175, mapBuilder__178, i__179, t_368;
    this__38.nsyms__150 = 0.0;
    t_364 = temper.mapbuilder_constructor();
    this__38.symbols__151 = t_364;
    t_365 = (TemperRegexNFA(regex__159)).engine;
    this__38.rawNfa__154 = t_365;
    t_366 = this__38.rawNfa__154:opt();
    this__38.nfa__155 = t_366;
    t_367 = TransitionTable(this__38.nstates);
    this__38.table__152 = t_367;
    i__161 = 0.0;
    while true do
      local state__162, j__163;
      t_338 = this__38.nstates;
      if not (i__161 < t_338) then
        break;
      else
      end
      t_352 = temper.listed_get(this__38.nfa__155.states, i__161);
      state__162 = t_352;
      j__163 = 0.0;
      while true do
        t_339 = temper.listbuilder_length(state__162.next);
        if not (j__163 < t_339) then
          break;
        else
        end
        t_353 = temper.listed_get(state__162.next, j__163);
        t_340 = t_353.matcher;
        this__38:addSymbolsFrom(t_340);
        j__163 = (j__163 + 1.0);
      end
      i__161 = (i__161 + 1.0);
    end
    pairs__164 = temper.mapped_tolist(this__38.symbols__151);
    i__165 = 0.0;
    while true do
      local state__166, val__167, j__168, ent__172;
      t_341 = this__38.nstates;
      if not (i__165 < t_341) then
        break;
      else
      end
      t_354 = temper.listed_get(this__38.nfa__155.states, i__165);
      state__166 = t_354;
      val__167 = temper.listbuilder_constructor();
      j__168 = 0.0;
      while (j__168 < this__38.nsyms__150) do
        local cur__169, k__170;
        cur__169 = temper.listbuilder_constructor();
        k__170 = 0.0;
        while true do
          local next__171;
          t_342 = temper.listbuilder_length(state__166.next);
          if not (k__170 < t_342) then
            break;
          else
          end
          t_355 = temper.listed_get(state__166.next, k__170);
          next__171 = t_355;
          t_343 = next__171.matcher;
          t_344 = validFor__79(t_343);
          t_356 = temper.list_get(pairs__164, j__168);
          if temper.densebitvector_get(t_344, t_356.key) then
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
      t_345 = this__38.nstates;
      if not (i__173 < t_345) then
        break;
      else
      end
      t_357 = temper.listed_get(this__38.table__152.table, i__173);
      t_346 = this__38.nstates;
      this__38:buildTable(t_357, t_346);
      i__173 = (i__173 + 1.0);
    end
    index__174 = temper.mapbuilder_constructor();
    temper.mapbuilder_set(index__174, '', 0.0);
    i__175 = 0.0;
    while true do
      local tent__176, name__177;
      ::continue_39::t_347 = temper.listbuilder_length(this__38.table__152.table);
      if not (i__175 < t_347) then
        break;
      else
      end
      t_358 = temper.listed_get(this__38.table__152.table, i__175);
      tent__176 = t_358;
      t_348 = tent__176.key;
      name__177 = this__38:nameFor(t_348);
      if temper.str_eq(name__177, '') then
        goto break_38;
      else
      end
      t_349 = tent__176.key;
      temper.mapbuilder_set(index__174, this__38:nameFor(t_349), (i__175 + 1.0));
      ::break_38::i__175 = (i__175 + 1.0);
    end
    mapBuilder__178 = temper.mapbuilder_constructor();
    i__179 = 0.0;
    while true do
      local tent__180, subBuilder__181, j__182, ci__184;
      t_350 = temper.listbuilder_length(this__38.table__152.table);
      if not (i__179 < t_350) then
        break;
      else
      end
      t_359 = temper.listed_get(this__38.table__152.table, i__179);
      tent__180 = t_359;
      subBuilder__181 = temper.mapbuilder_constructor();
      j__182 = 0.0;
      while (j__182 < this__38.nsyms__150) do
        local value__183;
        t_360 = temper.list_get(tent__180.val, j__182);
        t_361 = temper.mapped_get(index__174, this__38:nameFor(t_360));
        value__183 = t_361;
        t_362 = temper.list_get(pairs__164, j__182);
        temper.mapbuilder_set(subBuilder__181, t_362.key, value__183);
        j__182 = (j__182 + 1.0);
      end
      t_351 = tent__180.key;
      t_363 = temper.mapped_get(index__174, this__38:nameFor(t_351));
      ci__184 = t_363;
      temper.mapbuilder_set(mapBuilder__178, ci__184, mapToList__78(temper.mapped_tomap(subBuilder__181), 0.0));
      i__179 = (i__179 + 1.0);
    end
    t_368 = temper.mapped_tomap(mapBuilder__178);
    this__38.map__153 = mapToList__78(t_368, temper.listof());
    return nil;
  end;
  TemperRegexDFA.methods.addCodePoint = function(this__39, c__186)
    local local_369, local_370, local_371;
    local_369, local_370, local_371 = temper.pcall(function()
      temper.mapped_get(this__39.symbols__151, c__186);
    end);
    if local_369 then
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
    local t_373, t_374, fn__1515;
    t_373 = this__41.nstates;
    t_374 = fromVec(vec__195, t_373);
    fn__1515 = function(s__197)
      return temper.int_tostring(s__197);
    end;
    return temper.listed_join(t_374, '|', fn__1515);
  end;
  TemperRegexDFA.methods.buildEngine = function(this__42)
    local t_375, t_376, t_377, t_378, t_379, t_380, t_381, t_382, t_383, t_384, t_385, t_386, t_387, t_388, nstates__201, index__202, i__203, dfa__206, dfaStates__207, i__208, pairs__210, i__211;
    nstates__201 = temper.listbuilder_length(this__42.nfa__155.states);
    index__202 = temper.mapbuilder_constructor();
    temper.mapbuilder_set(index__202, '', -1.0);
    i__203 = 0.0;
    while true do
      local tent__204, name__205;
      ::continue_41::t_375 = temper.listbuilder_length(this__42.table__152.table);
      if not (i__203 < t_375) then
        break;
      else
      end
      t_381 = temper.listed_get(this__42.table__152.table, i__203);
      tent__204 = t_381;
      t_376 = tent__204.key;
      name__205 = this__42:nameFor(t_376);
      if temper.str_eq(name__205, '') then
        goto break_40;
      else
      end
      t_377 = tent__204.key;
      temper.mapbuilder_set(index__202, this__42:nameFor(t_377), i__203);
      ::break_40::i__203 = (i__203 + 1.0);
    end
    dfa__206 = Engine();
    dfaStates__207 = temper.listbuilder_constructor();
    i__208 = 0.0;
    while true do
      local tent__209;
      t_378 = temper.listbuilder_length(this__42.table__152.table);
      if not (i__208 < t_378) then
        break;
      else
      end
      t_382 = temper.listed_get(this__42.table__152.table, i__208);
      tent__209 = t_382;
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
      t_379 = temper.listbuilder_length(this__42.table__152.table);
      if not (i__211 < t_379) then
        break;
      else
      end
      t_383 = temper.listed_get(this__42.table__152.table, i__211);
      tent__212 = t_383;
      t_384 = temper.listed_get(dfaStates__207, i__211);
      state__213 = t_384;
      j__214 = 0.0;
      while (j__214 < this__42.nsyms__150) do
        local value__215;
        t_385 = temper.list_get(tent__212.val, j__214);
        t_386 = temper.mapped_get(index__202, this__42:nameFor(t_385));
        value__215 = t_386;
        if (value__215 ~= -1.0) then
          t_387 = temper.list_get(pairs__210, j__214);
          t_380 = CharCodeMatcher(t_387.key);
          t_388 = temper.listed_get(dfaStates__207, value__215);
          state__213:addNext(t_380, t_388);
        else
        end
        j__214 = (j__214 + 1.0);
      end
      i__211 = (i__211 + 1.0);
    end
    return dfa__206:opt();
  end;
  TemperRegexDFA.methods.buildTable = function(this__43, tent__217, nstates__218)
    local t_389, t_390, t_391, t_392, t_393, t_394, i__220;
    i__220 = 0.0;
    while (i__220 < this__43.nsyms__150) do
      local newKey__221;
      t_390 = temper.list_get(tent__217.val, i__220);
      newKey__221 = t_390;
      if (temper.list_length(fromVec(newKey__221, nstates__218)) >= 1.0) then
        t_389 = this__43.table__152:has(newKey__221);
        t_391 = not t_389;
      else
        t_391 = false;
      end
      if t_391 then
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
              t_392 = this__43.table__152:get(toVec(temper.listof(k__225), nstates__218));
              ent__226 = t_392;
              t_393 = this__43.table__152:get(toVec(temper.listof(k__225), nstates__218));
              t_394 = temper.list_get(t_393.val, j__223);
              bv__227 = t_394;
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
    local t_395, t_396, t_397, t_398;
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
      t_397 = temper.cast_to(next__231, CharCodeMatcher);
      t_395 = t_397.code;
      this__44:addCodePoint(t_395);
    elseif temper.instance_of(next__231, CharMatcher) then
      t_398 = temper.cast_to(next__231, CharMatcher);
      t_396 = t_398.code;
      this__44:addCodePoint(t_396);
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
    local return__68, t_399, t_400, state__237;
    ::continue_43::state__237 = 1.0;
    while true do
      if (state__237 == 0.0) then
        return__68 = false;
        goto break_42;
      else
      end
      if (state__237 == 2.0) then
        return__68 = true;
        goto break_42;
      else
      end
      if temper.string_hasindex(str__234, place__235) then
        return__68 = false;
        goto break_42;
      else
      end
      t_399 = temper.listed_getor(temper.listed_getor(this__45.map__153, state__237, emptyList__129), temper.string_codeat(str__234, place__235), 0.0);
      state__237 = t_399;
      t_400 = temper.string_next(str__234, place__235);
      place__235 = t_400;
    end
    ::break_42::return return__68;
  end;
  TemperRegexDFA.methods.found = function(this__46, str__239)
    local return__69, t_401, place__241;
    ::continue_45::place__241 = 1.0;
    while true do
      if this__46:foundAfter(str__239, place__241) then
        return__69 = true;
        goto break_44;
      elseif temper.string_hasindex(str__239, place__241) then
        t_401 = temper.string_next(str__239, place__241);
        place__241 = t_401;
      else
        return__69 = false;
        goto break_44;
      end
    end
    ::break_44::return return__69;
  end;
  TemperRegexDFA.methods.find = function(this__47, str__243)
    local return__70, t_402, place__245;
    ::continue_47::place__245 = 1.0;
    while true do
      if this__47:foundAfter(str__243, place__245) then
        return__70 = true;
        goto break_46;
      elseif temper.string_hasindex(str__243, place__245) then
        t_402 = temper.string_next(str__243, place__245);
        place__245 = t_402;
      else
        return__70 = false;
        goto break_46;
      end
    end
    ::break_46::return return__70;
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
    local t_403, t_404, t_405, t_406, t_407, t_408, t_409, t_410, t_411, t_412, t_413, t_414, t_415, t_416, t_417, t_418, builder__264, syms__265, i__266;
    builder__264 = RegexBuilder();
    syms__265 = temper.mapped_tolist(this__52.symbols__151);
    i__266 = 0.0;
    while true do
      local tent__267, kname__268, tmap__269, j__270, ls__273, j__274;
      ::continue_49::t_403 = temper.listbuilder_length(this__52.table__152.table);
      if not (i__266 < t_403) then
        break;
      else
      end
      t_408 = temper.listed_get(this__52.table__152.table, i__266);
      tent__267 = t_408;
      t_404 = tent__267.key;
      kname__268 = this__52:nameFor(t_404);
      if temper.str_eq(kname__268, '') then
        goto break_48;
      else
      end
      tmap__269 = temper.mapbuilder_constructor();
      j__270 = 0.0;
      while (j__270 < this__52.nsyms__150) do
        local val__271, local_419, local_420, local_421, got__272;
        t_409 = temper.list_get(tent__267.val, j__270);
        val__271 = this__52:nameFor(t_409);
        local_419, local_420, local_421 = temper.pcall(function()
          t_410 = temper.mapped_get(tmap__269, val__271);
          t_411 = t_410;
        end);
        if local_419 then
        else
          t_405 = temper.listbuilder_constructor();
          t_411 = t_405;
        end
        got__272 = t_411;
        if temper.str_ne(val__271, '') then
          t_412 = temper.list_get(syms__265, j__270);
          temper.listbuilder_add(got__272, t_412.key);
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
        t_406 = temper.list_length(ls__273);
        if not (j__274 < t_406) then
          break;
        else
        end
        t_413 = temper.list_get(ls__273, j__274);
        vals__275 = t_413.value;
        if (temper.listbuilder_length(vals__275) == 1.0) then
          local points__276;
          t_414 = temper.list_get(ls__273, j__274);
          points__276 = CodePoints(temper.listed_join(t_414.value, '', chr));
          t_415 = temper.list_get(ls__273, j__274);
          builder__264:add(kname__268, t_415.key, points__276);
        else
          local parts__277, bits__278, max__279, k__280, start__282, k__283;
          parts__277 = temper.listbuilder_constructor();
          bits__278 = temper.densebitvector_constructor(0.0);
          max__279 = 0.0;
          k__280 = 0.0;
          while true do
            local chrv__281;
            t_407 = temper.listbuilder_length(vals__275);
            if not (k__280 < t_407) then
              break;
            else
            end
            t_416 = temper.listed_get(vals__275, k__280);
            chrv__281 = t_416;
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
                  t_417 = temper.string_fromcodepoint(l__285);
                  temper.listbuilder_add(parts__277, CodePoints(t_417));
                  l__285 = (l__285 + 1.0);
                end
              else
                temper.listbuilder_add(parts__277, CodeRange(s__284, (k__283 - 1.0)));
              end
            else
            end
            k__283 = (k__283 + 1.0);
          end
          t_418 = temper.list_get(ls__273, j__274);
          builder__264:add(kname__268, t_418.key, CodeSet(temper.listbuilder_tolist(parts__277)));
        end
        j__274 = (j__274 + 1.0);
      end
      ::break_48::i__266 = (i__266 + 1.0);
    end
    return builder__264:toRegexList();
  end;
  TemperRegexDFA.methods.toRegexString = function(this__53)
    local t_423;
    t_423 = this__53:toRegex();
    return regexToString(t_423);
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
    local t_424, t_425, t_426, t_427, ls__133, max__134, i__135, ret__137, i__138;
    ls__133 = temper.mapped_tolist(map__130);
    max__134 = 0.0;
    i__135 = 0.0;
    while true do
      local key__136;
      t_424 = temper.list_length(ls__133);
      if not (i__135 < t_424) then
        break;
      else
      end
      t_425 = temper.list_get(ls__133, i__135);
      key__136 = t_425.key;
      if (key__136 > max__134) then
        max__134 = key__136;
      else
      end
      i__135 = (i__135 + 1.0);
    end
    ret__137 = temper.listbuilder_constructor();
    i__138 = 0.0;
    while (i__138 <= max__134) do
      local local_428, local_429, local_430;
      local_428, local_429, local_430 = temper.pcall(function()
        t_426 = temper.mapped_get(map__130, i__138);
        t_427 = t_426;
      end);
      if local_428 then
      else
        t_427 = defaultValue__131;
      end
      temper.listbuilder_add(ret__137, t_427);
      i__138 = (i__138 + 1.0);
    end
    return temper.listbuilder_tolist(ret__137);
  end;
  validFor__79 = function(next__139)
    local t_432, t_433, valid__143, validPoint__141, validRange__142;
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
      t_432 = temper.cast_to(next__139, CharMatcher);
      validPoint__141(t_432.code);
    elseif temper.instance_of(next__139, CharCodeMatcher) then
      t_433 = temper.cast_to(next__139, CharCodeMatcher);
      validPoint__141(t_433.code);
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
    local t_316, fn__480, keyStr__70, t_317, fn__479, valStrs__73;
    t_316 = fromVec(this__10.key__65, nsyms__68);
    fn__480 = function(id__71)
      return temper.concat('q', temper.int_tostring(id__71));
    end;
    keyStr__70 = temper.listed_join(t_316, ',', fn__480);
    t_317 = this__10.val__66;
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
    valStrs__73 = temper.listed_join(t_317, ' | ', fn__479);
    return temper.concat('| ', keyStr__70, ' | ', valStrs__73, ' |');
  end;
  TransitionTableEntry.methods.toDotWith = function(this__11, nsyms__80)
    local t_318, fn__461, keyStr__82, t_319, fn__460, valStrs__85;
    t_318 = fromVec(this__11.key__65, nsyms__80);
    fn__461 = function(id__83)
      return temper.concat('q', temper.int_tostring(id__83));
    end;
    keyStr__82 = temper.listed_join(t_318, '', fn__461);
    t_319 = this__11.val__66;
    fn__460 = function(vec__86)
      local return__28, t_320, vec__88;
      vec__88 = fromVec(vec__86, nsyms__80);
      if (temper.list_length(vec__88) == 0.0) then
        return__28 = '<TD>-</TD>';
      else
        local fn__452;
        fn__452 = function(id__89)
          return temper.concat('q', temper.int_tostring(id__89));
        end;
        t_320 = temper.listed_join(vec__88, ',', fn__452);
        return__28 = temper.concat('<TD>', t_320, '</TD>');
      end
      return return__28;
    end;
    valStrs__85 = temper.listed_join(t_319, '', fn__460);
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
    local t_321;
    this__12.nsyms__94 = size__97;
    t_321 = temper.listbuilder_constructor();
    this__12.table__95 = t_321;
    return nil;
  end;
  TransitionTable.methods.has = function(this__13, key__100)
    local return__31, local_322, local_323, local_324;
    local_322, local_323, local_324 = temper.pcall(function()
      this__13:get(key__100);
      return__31 = true;
    end);
    if local_322 then
    else
      return__31 = false;
    end
    return return__31;
  end;
  TransitionTable.methods.get = function(this__14, key__103)
    local return__32, t_326, t_327, i__105;
    ::continue_37::i__105 = 0.0;
    while true do
      local cur__107, ret__108, j__109;
      t_326 = temper.listbuilder_length(this__14.table__95);
      if not (i__105 < t_326) then
        break;
      else
      end
      t_327 = temper.listed_get(this__14.table__95, i__105);
      cur__107 = t_327;
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
        goto break_36;
      else
      end
      i__105 = (i__105 + 1.0);
    end
    temper.bubble();
    ::break_36::return return__32;
  end;
  TransitionTable.methods.toMarkdownWith = function(this__15, map__111)
    local t_328, t_329, l__113, size__114, t_330, fn__422, inner__115, header__118, i__119, ls__120, i__121, noop__123, dash__126;
    l__113 = temper.mapped_tolist(map__111);
    size__114 = this__15.nsyms__94;
    t_330 = this__15.table__95;
    fn__422 = function(ent__116)
      return ent__116:toMarkdownWith(size__114);
    end;
    inner__115 = temper.listed_join(t_330, '\n', fn__422);
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
      t_328 = temper.list_length(ls__120);
      if not (i__121 < t_328) then
        break;
      else
      end
      t_329 = temper.list_get(ls__120, i__121);
      ent__122 = t_329;
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
    local t_331, t_332, l__133, size__134, t_333, fn__403, inner__135, header__138, i__139, ls__140, i__141, noop__143, dash__146, t_334;
    l__133 = temper.mapped_tolist(map__130);
    size__134 = this__16.nsyms__94;
    t_333 = this__16.table__95;
    fn__403 = function(ent__136)
      return ent__136:toDotWith(size__134);
    end;
    inner__135 = temper.listed_join(t_333, '', fn__403);
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
      t_331 = temper.list_length(ls__140);
      if not (i__141 < t_331) then
        break;
      else
      end
      t_332 = temper.list_get(ls__140, i__141);
      ent__142 = t_332;
      temper.listbuilder_set(header__138, (ent__142.value + 1.0), temper.concat('<TD>#', temper.int_tostring(ent__142.key), '</TD>'));
      i__141 = (i__141 + 1.0);
    end
    noop__143 = function(s__144)
      return s__144;
    end;
    dash__146 = function(s__147)
      return '---';
    end;
    t_334 = temper.listed_join(header__138, '', noop__143);
    return temper.concat('<TABLE border="0" cellspacing="5" bgcolor="', color__131, '"><TR>', t_334, '</TR>', inner__135, '</TABLE>');
  end;
  TransitionTable.get.nsyms = function(this__159)
    return this__159.nsyms__94;
  end;
  TransitionTable.get.table = function(this__163)
    return this__163.table__95;
  end;
  toVec = function(ls__55, size__56)
    local t_335, t_336, vec__58, i__59;
    vec__58 = temper.densebitvector_constructor(0.0);
    i__59 = 0.0;
    while true do
      t_335 = temper.list_length(ls__55);
      if not (i__59 < t_335) then
        break;
      else
      end
      t_336 = temper.list_get(ls__55, i__59);
      temper.densebitvector_set(vec__58, t_336, true);
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
