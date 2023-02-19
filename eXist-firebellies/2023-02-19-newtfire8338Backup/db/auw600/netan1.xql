xquery version "3.1";
declare variable $ThisFileContent :=
string-join(
let $disneySongs := collection ('/db/disneySongs/')
let $lyricists := $disneySongs//lyricist ! normalize-space()=> distinct-values()
for $l in $lyricists
let $songTitles := $disneySongs//metadata[.//lyricist ! normalize-space()= $l]/title ! normalize-space() => distinct-values()
for $t in $songTitles
let $composers := $disneySongs//metadata[.//title ! normalize-space()= $t]//composer ! normalize-space() => distinct-values()
for $c in $composers

return concat($l, "&#x9;", "lyricist", "&#x9;", $t, "&#x9;", $c, "&#x9;", "composer"),"&#10;");

let $filename := "networkanalysis1.tsv"
let $doc-db-uri := xmldb:store("/db/auw600/", $filename, $ThisFileContent, "text/plain")
return $doc-db-uri
(: View this TSV (text/plain) file at http://newtfire.org:8338/exist/rest/db/auw600/networkanalysis1.tsv  :)