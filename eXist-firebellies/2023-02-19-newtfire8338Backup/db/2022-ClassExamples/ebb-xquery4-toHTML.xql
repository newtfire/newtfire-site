xquery version "3.1";
let $disneySongs := collection('/db/disneySongs/')//xml
(:  From earlier homework on string lengths and line counts :for $d in $disneySongs :)
(:  :    let $title := $d//metadata/title :)
(:  :    let $lineCount := count($d//ln) :)
(:  : let $stringLengthsAll :=
(:  :   for $d in $disneySongs
    let $length := $d//song ! normalize-space() ! string-length()
    return $length :)
(:  :let $maxSongLength := $stringLengthsAll => max()
(:   :let $minSongLength := $stringLengthsAll => min() :)
let $songStrings := $d//song ! string()  :)
let $songSL := $d//song ! normalize-space() :)
(:   :let $songSL := $songStrings ! string-length() :)

let $composers := $disneySongs//composer ! normalize-space() => 
distinct-values() => sort()
for $c at $pos in $composers
let $cMatch := $disneySongs[descendant::composer ! normalize-space() = $c]
let $cTitles := $cMatch//metadata/title ! normalize-space() => distinct-values() => sort() => string-join(', ')
let $cSongLengths := 
          for $m in $cMatch
          let $length := $m//song ! normalize-space() ! string-length()
          return $length => sort()
let $maxSongLength := $cSongLengths => max()
return
<tr>
    <td>{$pos}</td>
    <td>{$c}</td>
    <td>Longest song has this many characters: {$maxSongLength}</td>
    <!-- I wonder if the longest song by line is the same as the longest song by max Song Length? Also, which song(s) are these by title? -->
    
</tr>
