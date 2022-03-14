xquery version "3.1";
declare variable $ThisFileContent :=
string-join(
    let $collection := collection('/db/disneySongs/Aladdin')
    let $songTitles := $collection//metadata/title ! normalize-space() => distinct-values()
    for $s in $songTitles
    let $composers := $collection//composer ! normalize-space() => distinct-values()
    for $c in $composers
    let $voiceActor := $collection[.//composer ! normalize-space() = $c]//voiceActor ! normalize-space() => distinct-values()
    for $v in $voiceActor
    let $lyric := $collection[.//composer ! normalize-space() = $c]//lyricist ! normalize-space() => distinct-values()
    for $l in $lyric
    return 
        concat("composer", "&#x9;", $c, "&#x9;", "voice actor", "&#x9;", $v, "&#x9;", "lyricist", "&#x9;", $l, "&#x9;", "song title", "&#x9;", $s), "&#10;");
        
let $filename := "network6.tsv"
let $doc-db-uri := xmldb:store("/db/wdjacca/", $filename, $ThisFileContent, "text/plain")
return $doc-db-uri
(: View this TSV (text/plain) file at http://newtfire.org:8338/exist/rest/db/wdjacca/network1.tsv  :)


