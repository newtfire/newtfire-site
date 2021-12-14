xquery version "3.1";
declare variable $thisFileContent :=
<html>
<head>Song Counts</head>
<body><table><tr><th>Movie</th><th>Song Count</th></tr>{
let $disneycollection := collection('/db/disneySongs/Aladdin')
let $movie := $disneycollection//movie => distinct-values()
for $m in $movie
let $songCount := $disneycollection[.//movie =$m]//title => count()
order by $songCount
return <tr><td>{$m}</td><td>{$songCount}</td></tr>}

</table></body></html>
;
let $filename := "aladdinsongcount.html"
let $doc-db-uri := xmldb:store("/db/wdjacca/", $filename, $thisFileContent)
return $doc-db-uri   
(: View this SVG at http://newtfire.org:8338/exist/rest/db/wdjacca/movieData.svg  :)