xquery version "3.1";
declare variable $ThisFileContent:= string-join(
(: Hi Rachel! You were missing the string-join() function that needs to unite all these text lines into one big ball of "string"
 : I'm adding it here to wrap around your FLWOR: :)
let $disneySongs := collection('/db/disneySongs')
let $voiceActors := $disneySongs//voiceActor ! normalize-space()=> distinct-values()
for $va in $voiceActors
let $vaMovies := $disneySongs[.//voiceActor ! normalize-space() = $va]//movie !normalize-space() => distinct-values()
for $m in $vaMovies
let $songs := $disneySongs[.//movie ! normalize-space() = $m]//title ! normalize-space() => distinct-values()
for $s in $songs
let $composers := $disneySongs[.//movie ! normalize-space() = $m]//composer ! normalize-space() => distinct-values()
for $c in $composers
return
    concat($va, "&#x9;", "voiceActor", "&#x9;", $m, "&#x9;", $c, "&#x9;", "composer"), "&#10;") ;
    (:Rachel: Here is where the string-join() ends! See how it works? It started at the top of your FLOWR, and it 
    joins each concat line, with a line-return separator. That's the "&#10;" character.:)

let $filename := "disneySongdata2.tsv"
let $doc-db-uri := xmldb:store("/db/rgg5144", $filename, $ThisFileContent, "text/plain")
return $doc-db-uri
(: output at :http://newtfire.org:8338/exist/rest/db/rgg5144/disneySongdata2.tsv ) :)        