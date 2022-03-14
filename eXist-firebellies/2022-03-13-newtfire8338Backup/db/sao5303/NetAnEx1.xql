xquery version "3.1";

declare variable $ThisFileContent :=
string-join(
let $blues := collection('/db/blues')    
let $artists := $blues//artist ! normalize-space() => distinct-values() => sort()    
for $a in $artists
let $titles := $blues[.//artist ! normalize-space() = $a]//title ! normalize-space() => distinct-values()
    for $t in $titles
    let $songwriters := $blues [.//title ! normalize-space()= $t]//songwriter ! normalize-space() => distinct-values()
    for $s in $songwriters
        let $tokens := substring-after($s, 'by ') ! tokenize(.,' / ') ! normalize-space() => distinct-values()
        for $k in $tokens
        
        return concat ($a, "&#x9;", $t, "&#x9;", $k), "&#10;");
        (:$ThisFileContent:)
        
        
        
        
        
        let $filename :="BluesHWToBeFixed.tsv"
        let $doc-db-uri := xmldb:store("/db/sao5303", $filename, $ThisFileContent, "text/plain")
        return $doc-db-uri
(: output at :http://newtfire.org:8338/exist/rest/db/sao5303/BluesHWToBeFixed.tsv ) :)      