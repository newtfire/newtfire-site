xquery version "3.1";
declare variable $ThisFileContent :=
string-join(
let $blues := collection('/db/blues')
let $artists := $blues//artist ! normalize-space() => distinct-values() => sort()
for $a in $artists
let $songwriters := $blues[.//artist ! normalize-space() = $a]//songwriter/text() ! normalize-space()
    (:for $t in $titles
    let $songwriters := $blues[.//title ! normalize-space = $t]//songwriter/text() ! normalize-space():)
    for $s in $songwriters
        (:let $titles := $blues[.//songwriter/text() ! normalize-space = $s]//title/text() ! normalize-space()
        for $t in $titles:)
return concat ($a, "&#x9;", $s), "&#10;") ;
let $filename := "BluesNetwork.tsv"
let $doc-db-uri := xmldb:store("/db/mqb5995", $filename, $ThisFileContent, "text/plain")
return $doc-db-uri
(: (: output: http://newtfire.org:8338/exist/rest/db/mqb5995/BluesNetwork.tsv :) :)

    (:for $a in $artists
    return $a:)
    (:let $songwriters := $blues[.//artist ! normalize-space() = $a]//songwriter
        for $s in $songwriters:)
    (:let $titles := $blues[.//artist ! normalize-space() = $a]//title ! normalize-space() => distinct-values()
        for $t in $titles:)
       (: return $s:)
        (:let $songwriters := $blues[.//title ! normalize-space() = $t]//songwriter
            for $s in $songwriters:)