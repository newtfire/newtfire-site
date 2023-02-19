xquery version "3.1";
declare variable $ThisFileContent := string-join( 
let $blues := collection('/db/blues')
for $b in $blues
let $sixties := $b//date ! normalize-space() ! xs:gYear(.)
  where $sixties > xs:gYear("1959")
and $sixties < xs:gYear("1970")
let $sixtiesLyr := $b//l/text()
let $words := $sixtiesLyr ! translate(., '0123456789()!?*.,', '')  ! normalize-space()
return $words, "&#10;") ;

let $filename := "sixtiesLyricsNLP.txt"
let $doc-db-uri := xmldb:store("/db/mqb5995/", $filename, $ThisFileContent, "text/plain")
return $doc-db-uri 

(: (: output: http://newtfire.org:8338/exist/rest/db/mqb5995/sixtiesLyricsNLP.txt :) :)


