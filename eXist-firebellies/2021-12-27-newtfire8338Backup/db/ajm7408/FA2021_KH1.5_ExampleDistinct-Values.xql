xquery version "3.1";
let $kh1.5 := doc('/db/kingdomofhearts/KH1.5_XQuery_ExampleFile.xml')/*
let $gameTitle := $kh1.5//heading/gameInfo/gameTitle
let $cutscene := $kh1.5//cutscene
let $cutLocs := $cutscene/@location ! string()
let $distinctLocs := $cutLocs => distinct-values() => sort()
for $dl in $distinctLocs
let $dl-cutLocs := $cutscene[@location = $dl]
let $dl-cutNums := $dl-cutLocs/@cutNum ! string()
let $bundled-cutNums := string-join($dl-cutNums, ', ')
return concat($gameTitle, ', ', $dl, ": ", 'Cutscenes ', $bundled-cutNums)

(:  :for $c in $cutscene
let $type := $c/@type ! data()
let $cutNum := $c/@cutNum ! data()
let $loc := $c/@location ! data()
order by $loc
return concat($gameTitle, ', ', 'Cutscene ', $cutNum, ': ', $type, ', ', $loc) :)