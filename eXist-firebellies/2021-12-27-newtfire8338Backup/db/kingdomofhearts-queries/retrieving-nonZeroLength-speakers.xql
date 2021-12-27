xquery version "3.1";
let $KingdomHearts := collection('/db/kingdomofhearts')
let $speakers := $KingdomHearts//speaker
let $speakerNonPars := $speakers[matches(., "^[^(]+$")]/text()[matches(., "\S+")] => sort()
let $speakerPars := $speakers[matches(text(), "\s+\(.+?\)")] ! tokenize(., "\s+\(.+?\)")[1] ! normalize-space() => sort()
(: ebb: Some of your speakers have untagged parentheses in them, as in <speaker>Sora (thinking)</speaker>. So this $speakerPars variable collects those and gets just the name before the parentheses. :)
let $allSpeakers := ($speakerPars, $speakerNonPars) => distinct-values() => sort()
return $speakerPars
