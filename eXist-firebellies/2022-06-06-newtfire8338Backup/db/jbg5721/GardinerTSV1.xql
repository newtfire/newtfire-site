xquery version "3.1";
declare variable $tsv :=
string-join(
let $drafts := collection('/db/starwars/')
    for $d in $drafts
let $draft := $d//draft ! normalize-space() => distinct-values()
let $speaker := $d//sp/@spk ! normalize-space() => distinct-values()
for $s in $speaker
    
return  concat("Draft:", "&#x9;", $draft, "&#x9;", "Character:", "&#x9;", $s), "&#10;");
$tsv



(:  :let $filetsv := "starWarsCharacters.tsv"
let $doc-db-uri := xmldb:store("/db/jbg5721/", $filetsv, $tsv, "text/plain")
return $doc-db-uri :)

