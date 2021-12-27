xquery version "3.1";
let $kh1.5 := doc('/db/kingdomofhearts/KH1.5_XQuery_ExampleFile.xml')/*
let $gameTitle := $kh1.5//heading/gameInfo/gameTitle
for $gT in $gameTitle
return 
<li><a href="kh1.5GetLocations.php?title={$gT}">{$gT}</a></li>