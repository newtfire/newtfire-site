xquery version "3.1";
declare variable $ThisFileContent := string-join( 
let $blues := collection('/db/blues')
let $Muddy := $blues[.//artist ! normalize-space() = "Muddy Waters"]
let $MuddyLyrics := $Muddy//lyrics/l/text()
let $words := $MuddyLyrics ! translate(., '0123456789()!?*.', '') ! normalize-space()

return $words, "&#10;") ;

let $filename := "MuddyLyrics.txt"
let $doc-db-uri := xmldb:store("/db/mqb5995/", $filename, $ThisFileContent, "text/plain")
return $doc-db-uri 
