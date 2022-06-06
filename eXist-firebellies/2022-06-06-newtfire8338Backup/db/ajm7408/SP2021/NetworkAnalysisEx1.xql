xquery version "3.1";
declare variable $ThisFileContent :=
string-join (
let $disneySongs := collection('/db/disneySongs')
let $voiceActors := $disneySongs//voiceActor ! normalize-space() => distinct-values()
for $v in $voiceActors
    let $vMovies := $disneySongs[.//voiceActor ! normalize-space() = $v]//movie ! normalize-space() => distinct-values()
    for $m in $vMovies
        let $composers := $disneySongs[.//movie ! normalize-space() = $m]//composer
            for $c in $composers
return
    concat($v, "&#x9;", $m, "&#x9;", $c), "&#10;") ;
    (: $ThisFileContent :)
    
let $filename := "MyNetworkData.tsv"
let $doc-db-uri := xmldb:store("/db/ajm7408/", $filename, $ThisFileContent)
return $doc-db-uri
(: View this SVG at http://newtfire.org:8338/exist/rest/db/ajm7408/MyNetworkData.tsv :)