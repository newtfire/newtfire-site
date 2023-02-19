xquery version "3.1";
declare variable $ThisFileContent := string-join( 
let $blues := collection('/db/blues')
let $lyrics := $blues//l/text()
let $words := $lyrics ! translate(., '0123456789()!?*.,', '')  ! normalize-space()
return $words, "&#10;") ;

let $filename := "wholeCollectionLyrics.txt"
let $doc-db-uri := xmldb:store("/db/mqb5995/", $filename, $ThisFileContent, "text/plain")
return $doc-db-uri 

(: (: output: http://newtfire.org:8338/exist/rest/db/mqb5995/wholeCollectionLyrics.txt :) :)