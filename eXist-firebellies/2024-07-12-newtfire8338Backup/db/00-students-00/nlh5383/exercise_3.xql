xquery version "3.1";
let $disneySongs := collection('/db/disneySongs/')/*
let $allSongs :=
    for $d in $disneySongs
        let $songTitle := $d//title
        let $songLyrics := $d//song
        let $songLength := $songLyrics => string-length()
        where $songLength > 0
        order by $songLength
        return $songLength
let $maxSongLength := $allSongs => max()
for $d in $disneySongs
    let $songTitle := $d//title
    let $songLength := $d//song ! string-length()
    where $songLength = $maxSongLength
    return $songTitle
