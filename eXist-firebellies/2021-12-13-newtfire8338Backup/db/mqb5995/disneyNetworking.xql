xquery version "3.1";
declare variable $ThisFileContent :=
string-join(
let $disneySongs := collection('/db/disneySongs')
let $voiceactors := $disneySongs//voiceActor ! normalize-space() => distinct-values()
for $v in $voiceactors
    let $vMovies := $disneySongs[.//voiceActor ! normalize-space() = $v]//movie ! normalize-space() => distinct-values()
        for $m in $vMovies
        let $composers := $disneySongs[.//movie ! normalize-space() = $m]//composer
            for $c in $composers
return
    concat ($v, "&#x9;", $m, "&#x9;", $c), "&#10;") ;
    
let $filename := "DisneyNetwork.tsv"
let $doc-db-uri := xmldb:store("/db/mqb5995", $filename, $ThisFileContent, "text/plain")
return $doc-db-uri
(: output: http://newtfire.org:8338/exist/rest/db/mqb5995/DisneyNetwork.tsv :)