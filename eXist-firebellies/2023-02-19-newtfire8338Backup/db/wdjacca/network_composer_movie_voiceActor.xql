xquery version "3.1";
declare variable $ThisFileContent :=
string-join(
    let $collection := collection('/db/disneySongs')
    let $movie := $collection//movie
    for $m in $movie
    let $composers := $collection[.//movie = $m]//composer ! normalize-space() => distinct-values()
    for $c in $composers
    let $voiceActor := $collection[.//composer ! normalize-space() = $c]//voiceActor ! normalize-space() => distinct-values()
    for $v in $voiceActor
    let $songTitles := $collection//metadata [.//voiceActor ! normalize-space() = $v]/title ! normalize-space() => distinct-values()
    for $s in $songTitles
    return 
        concat("movie","&#x9;", $m, "&#x9;", "composer", "&#x9;", $c, "&#x9;", "voice actor", "&#x9;", $v, "&#x9;", "song title", "&#x9;", $s), "&#10;");
        
let $filename := "network3.tsv"
let $doc-db-uri := xmldb:store("/db/wdjacca/", $filename, $ThisFileContent, "text/plain")
return $doc-db-uri
(: View this TSV (text/plain) file at http://newtfire.org:8338/exist/rest/db/wdjacca/network1.tsv  :)
