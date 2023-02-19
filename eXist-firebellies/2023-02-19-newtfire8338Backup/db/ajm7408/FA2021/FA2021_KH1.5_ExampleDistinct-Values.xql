xquery version "3.1";
let $kh1.5 := doc('/db/kingdomofhearts/FA2021_Scripts/FA2021_Kingdom_hearts_1.5_script.xml')/*
let $gameTitle := $kh1.5//heading/gameInfo/gameTitle
let $cutscene := $kh1.5//cutscene
let $cutLocs := $cutscene/@location ! string()
let $distinctLocs := $cutLocs => distinct-values()
for $dl in $distinctLocs
let $dl-cutLocs := $cutscene[@location = $dl]
let $dl-cutNums := $dl-cutLocs/@cutNum ! string()
let $bundled-cutNums := string-join($dl-cutNums, ', ')
return concat($gameTitle, ', ', $dl, ": ", $bundled-cutNums)

(:  :for $c in $cutscene
let $type := $c/@type ! data()
let $cutNum := $c/@cutNum ! data()
let $loc := $c/@location ! data()
order by $loc
return concat($gameTitle, ', ', 'Cutscene ', $cutNum, ': ', $type, ', ', $loc) :)