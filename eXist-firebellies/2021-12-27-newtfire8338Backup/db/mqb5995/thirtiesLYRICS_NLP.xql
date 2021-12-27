xquery version "3.1";
declare variable $ThisFileContent := string-join( 
let $blues := collection('/db/blues')
for $b in $blues
let $thirties := $b//date ! normalize-space() ! xs:gYear(.)
  where $thirties > xs:gYear("1929")
and $thirties < xs:gYear("1940")
let $thirtiesLyr := $b//l/text()
let $words := $thirtiesLyr ! translate(., '0123456789()!?*.,', '')  ! normalize-space()
return $words, "&#10;") ;

let $filename := "thirtiesLyricsNLP.txt"
let $doc-db-uri := xmldb:store("/db/mqb5995/", $filename, $ThisFileContent, "text/plain")
return $doc-db-uri 

(: (: output: http://newtfire.org:8338/exist/rest/db/mqb5995/thirtiesLyricsNLP.txt :) :)
