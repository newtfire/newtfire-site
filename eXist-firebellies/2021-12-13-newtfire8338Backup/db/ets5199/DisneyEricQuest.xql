xquery version "3.1";
declare variable $ThisFileContent :=
string-join(
let $disneySongs :=  collection('/db/disneySongs')
let $voiceActors := $disneySongs//voiceActor ! normalize-space() => distinct-values()
for $v in $voiceActors
    let $vMovies := $disneySongs[.//voiceActor ! normalize-space() = $v]//movie ! normalize-space() => distinct-values()
for $m in $vMovies
    let $composers := $disneySongs[.//movie ! normalize-space() = $m]//composer ! normalize-space() => distinct-values()
        for $c in $composers
    let $title := $disneySongs[.//composer ! normalize-space() = $c]//title ! normalize-space() => distinct-values()
        for $t in $title
return 
    concat($v, "&#x9;", $m, "&#x9;", $c, "&#x9;", $t), "&#10;") ;
    let $filename := "DisneyEricQuest.tsv"
let $doc-db-uri := xmldb:store("/db/ets5199", $filename, $ThisFileContent, "text/plain")
return $doc-db-uri