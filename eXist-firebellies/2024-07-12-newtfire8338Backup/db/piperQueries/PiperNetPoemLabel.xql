xquery version "3.1";

declare variable $poetrymaster := 
string-join(
let $poetrycol := collection('/db/piperpoetry/XML')
let $tagpoints := $poetrycol//metaTags/tagPoint/@tag ! normalize-space() => distinct-values()
let $keywords := $poetrycol//poem/line/keyword ! normalize-space() => distinct-values()
let $words := ($tagpoints, $keywords) => sort()
(:  :let $keywords := $poetrycol//keyword ! normalize-space() => distinct-values() => sort() :) 
for $w in $words
let $matchTPoems := $poetrycol//content[descendant::metaTags/tagPoint/@tag ! normalize-space() = $w]
let $matchKPoems := $poetrycol//content[descendant::keyword ! normalize-space() = $w]
let $matchPoems := ($matchTPoems, $matchKPoems)
for $m in $matchPoems 
let $mTitle := $m//poemTitle ! normalize-space()
let $wordType := 
    if ($m//descendant::keyword ! normalize-space() = $w and $m//tagPoint/@tag ! normalize-space() = $w)
        then "both"
    else if ($m//descendant::keyword ! normalize-space() = $w)
       then "keyword"
    else if ($m//tagPoint/@tag ! normalize-space() = $w)
       then "tagpoint"
    else "other"
let $wKPresence := $m//keyword[. ! normalize-space() = $w]
let $wTPresence := $m//tagPoint[@tag ! normalize-space() = $w]
let $wPresence := ($wKPresence, $wTPresence)
let $wCount := $wPresence => count()

return concat($w (:source node:), "&#x9;"(:tab character:), $wordType (:source attribute:), "&#x9;"(:tab character:), "appears this many times in" (:edge connector or shared interaction:), "&#x9;", $wCount (:edge attribute:), "&#x9;", $mTitle (:target node:), "&#x9;"(:tab character:), "poemTitle" (:target attribute:)), "&#10;" ); 

$poetrymaster

(:   :let $filename := "piperNetNew.tsv"
let $doc-db-uri := xmldb:store("/db/piperpoetry/", $filename, $poetrymaster, "text/plain")
return $doc-db-uri :)
(: View this text file at http://newtfire.org:8338/exist/rest/db/piperpoetry/piperNetNew.tsv  :)