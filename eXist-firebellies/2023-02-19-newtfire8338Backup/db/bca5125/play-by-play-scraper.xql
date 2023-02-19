xquery version "3.1";
declare variable $ThisFileContent := string-join(

    
(:  :let $corpus := collection('/db/harryPotter/') :)
let $playfile := 
let $speeches := $play//sp/text()
return
    
$speeches,  "&#10;") 

;

let $filename := "allSpeeches.txt"
let $doc-db-uri := xmldb:store("/db/bca5125", $filename, $ThisFileContent, "text/plain")
return $doc-db-uri  
(: output at :http://newtfire.org:8338/exist/rest/db/bca5125/allSpeeches.txt ) :)   