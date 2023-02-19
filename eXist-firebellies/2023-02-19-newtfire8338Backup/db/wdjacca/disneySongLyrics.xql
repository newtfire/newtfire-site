xquery version "3.1";
declare variable $ThisFileContent := string-join(
let $disneySongs := collection('/db/disneySongs/')
let $songs := $disneySongs//song ! normalize-space()
   (: normalize-space() basically combines the string() function and removes spaces between nodes, :)
   (: so it's an efficient text-scraper. :)
return $songs, "&#10;");
   (: We're using our newline character here to put a hard return between songs :)

let $filename := "disneySongLyrics.txt"
let $doc-db-uri := xmldb:store("/db/wdjacca/", $filename, $ThisFileContent, "text/plain")
return $doc-db-uri 
(: View this text file at http://newtfire.org:8338/exist/rest/db/wdjacca/disneySongLyrics.txt  :)
