xquery version "3.1";
let $kh1.5 := doc('/db/kingdomofhearts/FA2021_Scripts/FA2021_Kingdom_hearts_1.5_script.xml')/*
let $cutscene := $kh1.5//cutscene
let $cutLocs := $cutscene/@location ! string() => distinct-values() => sort()
for $l in $cutLocs
return
<li><a href="kh1.5GetCutNums.php?location={$l}">{$l}</a></li>