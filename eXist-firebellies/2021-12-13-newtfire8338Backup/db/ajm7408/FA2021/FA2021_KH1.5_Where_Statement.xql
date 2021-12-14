xquery version "3.1";
let $kh1.5 := doc('/db/kingdomofhearts/KH1.5_XQuery_ExampleFile.xml')/*
let $cutscenes := $kh1.5//cutscene
let $cutGameplay := $cutscenes[@type = 'Gameplay']
for $c in $cutGameplay
let $cutNum := $c/@cutNum ! data()
let $sp := $c/sp
let $speakers := $sp/speaker => distinct-values()
for $s in $speakers 
where $cutNum >= 5
return concat('In ', $c, $cutNum, 'the speakers are: ', string-join($s, ', '))