xquery version "3.1";
let $KingdomHearts := collection('/db/kingdomofhearts')
let $speakers := $KingdomHearts//speaker/text()
let $speakerNonPars := $speakers[not(matches(., "\s+\(.+?\)"))] ! normalize-space() 
let $speakerPars := $speakers[matches(., "\s+\(.+?\)")] ! tokenize(., "\s+\(.+?\)")[1] ! normalize-space() 
let $allSpeakers := ($speakerPars, $speakerNonPars) => distinct-values()
for $a in $allSpeakers
let $gameTitles := $KingdomHearts[.//speaker/text() ! tokenize(., "\s+\(.+?\)")[1] ! normalize-space() = $a]//title
for $g in $gameTitles
let $countSp := $KingdomHearts[.//title = $g]//sp[.//speaker/text() ! tokenize(., "\s+\(.+?\)")[1] ! normalize-space() = $a] => count()
order by $countSp descending          
return $a || ", " || $g || ", "  || $countSp





