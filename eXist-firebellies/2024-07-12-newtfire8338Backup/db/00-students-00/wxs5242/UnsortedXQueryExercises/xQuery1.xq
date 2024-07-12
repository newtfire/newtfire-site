xquery version "3.1";

let $disneySongs := collection('/db/disneySongs/')/xml

let $songLengthsAll :=
    for $d in $disneySongs
        let $length := $d//song => distinct-values() => sort() => string-length()
        order by $length descending
        return $length
    
let $titleSong :=
    for $d in $disneySongs
        let $title := $d//metadata/title => distinct-values() => sort()
        (:let $count := $d//song/lg/ln => count():)
        return $title

let $maxCount := $songLengthsAll => max()
let $minCount := $songLengthsAll => min()
(:where $maxSongLength :=:) 
(: return $titleSong || " --- " || $maxSongLength :)
for $d in $disneySongs
    let $dTitle := $d//metadata/title
    let $dLength := $d//song ! string-length()
    where $dLength = $maxCount or $dLength = $minCount
    return $dTitle