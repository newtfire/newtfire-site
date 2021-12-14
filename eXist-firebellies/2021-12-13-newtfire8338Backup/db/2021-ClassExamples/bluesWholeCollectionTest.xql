xquery version "3.1";
declare variable $ThisFileContent := string-join( 
let $blues := collection('/db/blues/')
let $lyrics := $blues//l[contains(text(), "Chicago")]
let $words := $lyrics ! translate(., '0123456789()!?*.,', '')  ! normalize-space()
return $words, "&#10;") ;

let $filename := "wholeCollectionLyrics.txt"
let $doc-db-uri := xmldb:store("/db/2021-ClassExamples/", $filename, $ThisFileContent, "text/plain")
return $doc-db-uri 

(: (: output: http://newtfire.org:8338/exist/rest/db/2021-ClassExamples/wholeCollectionLyrics.txt :) :)
