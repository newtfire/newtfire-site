xquery version "3.1";

declare variable $ThisFileContent := string-join(
let $KingdomHearts := doc('/db/kingdomofhearts/Kingdom_hearts_1.5_script.xml/')
let $speeches := $KingdomHearts//sp/text() ! normalize-space()
(: If you want to ignore (screen out) child elements, like say <stage> if it's embedded inside <sp>, then step into the text() node. 
 : That keeps the "scraping" shallow, so you get ONLY the text that's immediately inside <sp>. :)
return $speeches, "&#10;");
  

let $filename := "pythonHW_1_sampleTEXT_temp_ebb.txt"
let $doc-db-uri := xmldb:store("/db/sao5303/", $filename, $ThisFileContent, "text/plain")
return $doc-db-uri 
(: View this text file at http://newtfire.org:8338/exist/rest/db/sao5303/pythonHW_1_sampleTEXT_temp_ebb.txt  :)