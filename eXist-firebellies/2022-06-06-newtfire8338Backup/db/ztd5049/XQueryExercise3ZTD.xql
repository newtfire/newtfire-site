xquery version "3.1";
let $disneySongs := collection('/db/disneySongs/')//xml

let $songLengths :=
    for $d in $disneySongs
    let $length := $d//song ! normalize-space() ! string-length()
    return $length
    
let $maxSongLength := $songLengths => max() 
let $minSongLength := $songLengths => min()


for $d in $disneySongs
    let $title := $d//metadata/title (:This returns the song titles of each song in the collection:)
    let $lineCount := $d//ln => count() (:This returns the line count of each song in the collection:)
    let $songStrings := $d//song ! normalize-space() ! string() (:This returns the song lines in string format for each song in the collection:)
    let $songSL := $songStrings ! string-length()
    order by $songSL descending (:Orders the results from greatest to least:)
    
    (:where $songSL = $maxSongLength:) (:Will return the song title and count with maximum string length:)
    (:where $songSL = $minSongLength:) (:Will return the song title and count with minimum string length:)
    

return concat($title, " is ", $songSL, " lines long")
