xquery version "3.1";

let $poetrycol := collection('/db/piperpoetry/XML')
let $poetrytext := $poetrycol//poem ! string() ! normalize-space() 
let $poetrymaster := string-join($poetrytext, " ")

let $filename := "poetry-master-doc.txt"
let $doc-db-uri := xmldb:store("/db/piperpoetry/", $filename, $poetrymaster, "text/plain")
return $doc-db-uri 
(: View this text file at http://newtfire.org:8338/exist/rest/db/piperpoetry/poetry-master-doc.txt  :)