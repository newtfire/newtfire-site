xquery version "3.1";
declare variable $ThisFileContent := string-join(

    
let $corpus := collection('/db/harryPotter/') 
let $speeches := ($corpus//sp[contains(@who, "LUCIUS")]/text() ! normalize-space(),  $corpus//sp[contains(@who, "DRACO")]/text() ! normalize-space(), $corpus//sp[contains(@who, "NARCISSA")]/text() ! normalize-space())
return
    
$speeches,  "&#10;") 

;
$ThisFileContent

(:   :let $filename := "malfoySpeeches.txt"
let $doc-db-uri := xmldb:store("/db/bca5125", $filename, $ThisFileContent, "text/plain")
return $doc-db-uri  :)
(: output at :http://newtfire.org:8338/exist/rest/db/bca5125/allSpeeches.txt ) :)   