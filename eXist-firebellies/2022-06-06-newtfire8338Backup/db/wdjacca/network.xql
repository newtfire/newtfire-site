xquery version "3.1";
declare variable $ThisFileContent := 
string-join(
    let $collection := collection('/db/disneySongs')
    let $composers := $collection//composer ! normalize-space() => distinct-values()
    for $c in $composers
    let $songTitles := $collection//metadata [.//composer ! normalize-space() = $c]/title ! normalize-space() => distinct-values()
    for $s in $songTitles
    return 
        concat("composer", "&#x9;", $c, "&#x9;", "song title", "&#x9;", $s), "&#10;");
        
let $filename := "network1.tsv"
let $doc-db-uri := xmldb:store("/db/wdjacca/", $filename, $ThisFileContent, "text/plain")
return $doc-db-uri
(: View this TSV (text/plain) file at http://newtfire.org:8338/exist/rest/db/wdjacca/network1.tsv  :)
