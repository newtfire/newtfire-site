xquery version "3.1";
let $corpus := collection('/db/harryPotter/')
let $corpusXML := $corpus//xml
for $s in $corpusXML
   let $title := $s//header/title/text()
   let $ThisFileContent := string-join($s//sp/text(), "&#10;")
   let $filename := $title
   let $doc-db-uri := xmldb:store("/db/bca5125", $filename, $ThisFileContent, "text/plain")
   return $doc-db-uri
(: output at :http://newtfire.org:8338/exist/rest/db/bca5125/allSpeeches.txt ) :)   