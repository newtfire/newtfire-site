xquery version "3.1";
(: EBB: I've left comments here while we worked on this my office. :)
let $songs := collection('/db/disneySongs/')/xml
let $title := $songs//title
let $songTag := $songs//song
let $allSongLengths := $songTag ! string-length()
let $maxSL := $allSongLengths => max()
let $minSL := $allSongLengths => min()
for $s in $songTag
    (: let's get the title of each song so it can output :)
    let $loopTitle := $s/preceding::title ! string()
    (: Count the lines in the song :)
    let $countLines := $s//ln => count()
    let $songStringLength := $s ! string-length()
    order by $countLines descending
    where $songStringLength = $maxSL or $songStringLength = $minSL
    return ($loopTitle || ' Count of Lines: ' || $countLines || ' Song String-length: ' ||  $songStringLength)
    



 

