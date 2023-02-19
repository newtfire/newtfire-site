xquery version "3.1";
declare variable $ThisFileContent:= string-join(
let $blues := collection('/db/blues')
let $metadata := $blues//metadata
let $bessie := $blues//artist[. ! normalize-space() = "Bessie Smith"]
let $artists := $blues//artist ! normalize-space() => distinct-values() => sort()
for $a in $artists
let $songs := $blues[.//artist ! normalize-space() = $a]
for $s in $songs
let $sTitle := $s//title
let $Authorship := 
    if ($s[contains(.//songInfo, "Muddy") or matches(.//songInfo, "McKinley\s*Morganfield")])
        then "Muddy Waters: songwriter"
    else if ($s[matches(.//songInfo, "Bessie\s*Smith")])
        then "Bessie Smith: songwriter"
    else if ($s[matches(.//songInfo, "B\.?\s*B\.?\s*King")])
        then "B.B. King: songwriter"
    else "other songwriter"

return 
    concat($a, "&#x9;", $sTitle, "&#x9;", $Authorship, "&#10;")
    );

let $filename := "bluesSongsWritByMuddy.tsv"
let $doc-db-uri := xmldb:store("/db/2021-ClassExamples", $filename, $ThisFileContent, "text/plain")
return $doc-db-uri 
(: output at :http://newtfire.org:8338/exist/rest/db/2021-ClassExamples/bluesSongsWritByMuddy.tsv ) :)        


