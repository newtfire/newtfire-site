xquery version "3.1";
declare variable $thisFileContent :=
<html>
<head>Line Counts</head>
<body><table><tr><th>Movie</th><th>Line Count</th><th>Song Name</th></tr>{
let $disneycollection := collection('/db/disneySongs')
for $d in $disneycollection
let $movie := $d//movie/text() => distinct-values()
let $lineCount := $d//ln => count()
let $song := $d//title/text()
where $movie = "Aladdin"
return <tr><td>{$movie}</td><td>{$lineCount}</td><td>{$song}</td></tr>}

</table></body></html>
;
let $filename := "linecount.html"
let $doc-db-uri := xmldb:store("/db/wdjacca/", $filename, $thisFileContent)
return $doc-db-uri   
(: View this SVG at http://newtfire.org:8338/exist/rest/db/wdjacca/movieData.svg  :)