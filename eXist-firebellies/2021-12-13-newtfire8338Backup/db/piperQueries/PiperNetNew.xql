xquery version "3.1";

let $poetrycol := collection('/db/piperpoetry/XML')
let $tagpoints := $poetrycol//metaTags/tagPoint/@tag ! normalize-space() => distinct-values() => sort()
(:  :let $keywords := $poetrycol//keyword ! normalize-space() => distinct-values() => sort() :) 
for $t in $tagpoints
let $matchPoems := $poetrycol//content[descendant::metaTags/tagPoint/@tag ! normalize-space() = $t]
for $m in $matchPoems  
let $mTitle := $m//poemTitle ! normalize-space()
let $mKeywords := $m//keyword ! normalize-space() => distinct-values()
for $k in $mKeywords 
let $countk := $m//keyword[. ! normalize-space() = $k] => count()

return concat($t (:source node:), "&#x9;"(:tab character:), "tagpoint", "&#x9;"(:tab character:), $m (:edge connector:), "&#x9;"(:tab character:), "countKeyword", "&#x9;", $countk, "&#x9;", "keyword", "&#x9;"(:tab character:), $k (:target node:))

(: :let $filename := "piperNet.tsv"
let $doc-db-uri := xmldb:store("/db/piperpoetry/", $filename, $poetrymaster, "text/plain")
return $doc-db-uri :)  
(: View this text file at http://newtfire.org:8338/exist/rest/db/piperpoetry/piperNet.tsv  :)