xquery version "3.1";
declare variable $ThisFileContent := string-join(
let $disneySongs := collection('/db/starwars/fixed/')
let $songs := $disneySongs//setting ! normalize-space()
   (: normalize-space() basically combines the string() function and removes spaces between nodes, :)
   (: so it's an efficient text-scraper. :)
return $songs, "&#10;");
   (: We're using our newline character here to put a hard return between songs :)

let $filename := "starwarsSetting.txt"
let $doc-db-uri := xmldb:store("/db/jbg5721/", $filename, $ThisFileContent, "text/plain")
return $doc-db-uri 
(: View this text file at http://exist.newtfire.org/exist/rest/db/2021-ClassExamples/disneySongLyrics.txt  :)