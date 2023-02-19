xquery version "3.1";
<html>
    <head><title>Disney Song Lengths</title>
    </head>
<body>
    <h1>What are the Longest and Shortest Disney Songs?</h1>
<ul>
{
let $disneySongs := collection('/db/disneySongs/')//xml
let $songCount := $disneySongs
let $songLengthsAll :=
                 for $d in $disneySongs
                 let $length := $d//song ! normalize-space() ! string-length()
                 return $length
let $maxSongLength := $songLengthsAll => max()
let $minSongLength := $songLengthsAll => min()
for $d at $pos in $disneySongs
    let $title := $d//metadata/title
    let $lineCount := $d//ln => count()
    let $songStrings := $d//song ! normalize-space() 
    let $songSL := $songStrings ! string-length()
    (: where $songSL = $maxSongLength :)
    (:return concat($title ! string(), 'has string-length of: ', $songSL):)
    return 
      <li>{$title} at position {$pos} has length of {$songSL}</li>
      

}
  
  </ul>
  </body>
</html>

