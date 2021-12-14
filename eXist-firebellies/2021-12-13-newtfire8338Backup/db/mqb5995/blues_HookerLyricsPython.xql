xquery version "3.1";
declare variable $ThisFileContent := string-join( 
let $blues := collection('/db/blues')
let $JLHooker := $blues[.//artist ! normalize-space() = "John Lee Hooker"]
(:  :for $j in $JLHooker :)
let $JLHlyrics := $JLHooker//lyrics
let $JLHlines := $JLHlyrics//l
let $words := $JLHlines ! translate(., '0123456789()!?*.', '')  ! normalize-space()
(:  :let $wordsOfInterest := $words[string-length() > 0] ! lower-case(.) ! normalize-space() => distinct-values()
let $nocomma := $wordsOfInterest ! tokenize(., ',')
let $clean := $nocomma[string-length() > 0] ! normalize-space()
let $clean2 := $clean ! tokenize(., '"+')
let $done := $clean2[string-length() > 0] ! normalize-space() => distinct-values()
let $donedone := $done ! translate(., '0123456789()!?*.', '') ! tokenize(., ' ') ! normalize-space() => distinct-values() 
let $final := $donedone => distinct-values() :)
return $words, "&#10;") ;

let $filename := "JLHooker_Words_ebb.txt"
let $doc-db-uri := xmldb:store("/db/mqb5995/", $filename, $ThisFileContent, "text/plain")
return $doc-db-uri 



(: (: output: http://newtfire.org:8338/exist/rest/db/mqb5995/JLHooker_Words_ebb.txt :) :)