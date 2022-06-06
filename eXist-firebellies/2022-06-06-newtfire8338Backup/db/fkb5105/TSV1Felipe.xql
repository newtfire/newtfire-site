xquery version "3.1";
declare variable $tsv := 
string-join(
let $swDrafts := collection('/db/starwars/fixed/')
for $d in $swDrafts
   let $draft := $d//draft ! normalize-space() => distinct-values()
let $speaker := $d//sp/@spk ! normalize-space() => distinct-values()
for $s in $speaker
    
return  concat("Draft:", "&#x9;", $draft, "&#x9;", "Character:", "&#x9;", $s), "&#10;");
$tsv

(:  :let $filetsv := "swCharacters.tsv"
let $doc-db-uri := xmldb:store("/db/fkb5105/", $filetsv, $tsv, "text/plain")
return $doc-db-uri :)