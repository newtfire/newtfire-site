xquery version "3.1";
let $lrcoll := collection('/db/letsrock/')/*
let $songs := $lrcoll//song
let $istories := $lrcoll//i/@story ! string()
let $distinctStories := $istories => distinct-values()
for $ds in $distinctStories
let $ds-songs := $songs[descendant::i[@story= $ds]]
(: I could also write: 
 : let $ds-songs := $songs[.//i[@story = $ds]]
 : but this will not work:
 : let $ds-songs := $songs[//i[@story = $ds]]
 :  :)
let $ds-songTitles := $ds-songs//sname ! string()
let $bundled-songTitles := string-join($ds-songTitles, ', ')
return concat($ds, ": ", $bundled-songTitles)
