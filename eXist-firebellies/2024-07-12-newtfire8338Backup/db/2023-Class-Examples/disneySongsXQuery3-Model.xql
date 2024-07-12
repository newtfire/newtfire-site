xquery version "3.1";
let $disneySongs := collection('/db/disneySongs/')/*
let $songCount :=
    for $d in $disneySongs
    let $songLength := $d//song ! string-length()
    return $songLength
let $maxCount := $songCount => max()
let $minCount := $songCount => min()
for $d in $disneySongs
    let $dTitle := $d//metadata/title
    let $dLength := $d//song ! string-length()
    where $dLength = $maxCount or $dLength = $minCount
    return $dTitle

(:   :let $songInfo :=
    for $i in $disneySongs
    let $title := $i//metadata/title
    let $movie := $i//metadata/origin/movie
    let $songLength := $i//song/string-length()
    where $songLength=$maxCount or $songLength=$minCount
return ($title || " From: " || $movie || " Song Length: " ||
$songLength )
return $songInfo :)
