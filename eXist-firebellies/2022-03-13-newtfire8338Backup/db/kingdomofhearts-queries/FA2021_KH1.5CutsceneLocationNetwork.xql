xquery version "3.1";
let $kh1.5 := doc('/db/kingdomofhearts/FA2021_Scripts/FA2021_Kingdom_hearts_1.5_script.xml')/*
let $cutscene := $kh1.5//cutscene
for $c in $cutscene
let $type := $c/@type ! data()
let $loc := $c/@location ! data()
let $speakers := $c/sp/speaker ! normalize-space() => distinct-values()
for $s in $speakers
let $sCount := $c//speaker[. ! normalize-space() = $s] => count()
return  concat($speakers, "&#x9;", "speakers", "&#x9;", $type, "&#x9;", "number of speakers", "&#x9;", $sCount), "&#10;" )