xquery version "3.1";
let $tollBell := doc( '/db/holmes/TheAdventureoftheTollingBell.xml')
let $speaker := $tollBell//speaker
let $distinctSp := distinct-values($speaker)
let $cast := $tollBell//cast
return $cast