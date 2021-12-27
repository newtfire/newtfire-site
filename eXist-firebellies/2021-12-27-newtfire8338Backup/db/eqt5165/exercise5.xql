xquery version "3.1";
let $lrcoll := collection('/db/letsrock/')/*
let $songs := $lrcoll//song
let $stories := $lrcoll//i/@story ! string()
let $distinctstories := $stories => distinct-values()
for $ds in $distinctstories
let $ds-songs := $songs [descendant::i[@story= $ds]]
let $count := $ds-songs ! string-length() => distinct-values()
let $ds-title := $ds-songs//sname ! string()
where $count < 2000
return $ds-title