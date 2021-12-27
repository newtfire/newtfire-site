xquery version "3.1";
declare variable $ThisFileContent := string-join(
let $grimm := doc('/db/grimm/fairyTales.xml')
let $chapters := $grimm//chapter//p
return $chapters ! string(), "&#10;");
$ThisFileContent
(:  :let $filename := "grimmwhole.txt"
let $doc-db-uri := xmldb:store("/db/stf5123/", $filename, $ThisFileContent, "text/plain")
return $doc-db-uri :)
