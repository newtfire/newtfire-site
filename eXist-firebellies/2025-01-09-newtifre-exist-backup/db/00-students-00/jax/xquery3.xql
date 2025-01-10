xquery version "3.1";
let $disneySongs := collection('/db/disneySongs/')/*

let $songLengthsAll :=
    for $d in $disneySongs
    let $length := string-length($d)
    return $length
let $maxSongLength := max($songLengthsAll)
let $minSongLength := min($songLengthsAll)

(: for $d in $disneySongs
let $titles := $d//title
let $lines := $d//ln
let $linecount := count($lines)
return ($titles ||": "||$length :)
return $minSongLength