xquery version "3.1";
declare variable $ThisFileContent := string-join( 
let $blues := collection('/db/blues')
for $b in $blues
let $twenties := $b//date ! normalize-space() ! xs:gYear(.)
(:  :"1929" and "1928" and "1927" and "1926" and "1925" and "1924" and "1923" and "1922" and "1921" and "1920"]:)
  where $twenties > xs:gYear("1919")
and $twenties < xs:gYear("1930")
let $twentiesLyr := $b//l/text()
let $words := $twentiesLyr ! translate(., '0123456789()!?*.,', '')  ! normalize-space()
return $words, "&#10;") ;

let $filename := "twentiesLyricsNLP.txt"
let $doc-db-uri := xmldb:store("/db/mqb5995/", $filename, $ThisFileContent, "text/plain")
return $doc-db-uri 

(: (: output: http://newtfire.org:8338/exist/rest/db/mqb5995/twentiesLyricsNLP.txt :) :)

(:  :let $dates := $blues//date
return$dates:)
