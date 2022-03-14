xquery version "3.1";
(:  :declare variable $thisFileContent :=:)
<html>
<head>All Songs</head>
<body><ul>{
let $disneyColl := collection('/db/disneySongs')
for $d in $disneyColl
let $title := $d//title/text()
return <li>{$title}</li>}
</ul></body></html>
(: ;
let $filename := "songlist.html"
let $doc-db-uri := xmldb:store("/db/wdjacca/", $filename, $thisFileContent)
return $doc-db-uri   
(: View this SVG at http://newtfire.org:8338/exist/rest/db/wdjacca/movieData.svg  :):)