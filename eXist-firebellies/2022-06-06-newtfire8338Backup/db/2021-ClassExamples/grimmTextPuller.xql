xquery version "3.1";
declare variable $ThisFileContent := string-join( 
let $grimm := doc('/db/grimm/fairyTales.xml')
let $chapter := $grimm//chapter[title = "THE ROBBER BRIDEGROOM"]
return $chapter ! string(), "&#10;") ;


let $filename := "grimmRobberBridegroom.txt"
let $doc-db-uri := xmldb:store("/db/2021-ClassExamples/", $filename, $ThisFileContent, "text/plain")
return $doc-db-uri 
(: View this text file at http://newtfire.org:8338/exist/rest/db/2021-ClassExamples/grimmRobberBridegroom.txt  :)
