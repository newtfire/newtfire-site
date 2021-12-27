xquery version "3.1";
declare variable $ThisFileContent := string-join(

    
$corpus := collection('/db/harryPotter/')
let $speeches := $corpus//sp[@who = "" ]/text()
return
    
$speeches,  "&#10;") 

;

let $filename := "SorcerersStone-Speeches.txt"
let $doc-db-uri := xmldb:store("/db/bca5125/output/", $filename, $ThisFileContent, "text/plain")
return $doc-db-uri  
(: output at :http://newtfire.org:8338/exist/rest/db/bca5125/allSpeeches.txt ) :)   