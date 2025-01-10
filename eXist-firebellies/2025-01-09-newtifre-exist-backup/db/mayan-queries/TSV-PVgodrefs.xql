xquery version "3.1";
declare variable $ThisFileContent:=

string-join(
let $godIndex := doc('/db/mayan/PV_characterIndex.xml')
let $PV := doc('/db/mayan/popolVuh.xml')/*
let $indexChars := $godIndex//character
let $chars := $PV//character/@idref ! string() 
let $distChars := $chars => distinct-values() 
let $parts := $PV//part
for $p in $parts
let $gods := $p//character/@idref ! normalize-space() => distinct-values() 
for $g in $gods
let $godID := substring-after($g, "#")
let $godName := $godIndex//id($godID)/name ! string()
let $part := $p[.//character/@idref ! normalize-space() = $g]
let $partTitle := $p/head ! normalize-space()
let $partNumber := $p/@n ! data()
let $book := $PV//book[.//part/head ! normalize-space() = $partTitle]/@n ! data()
let $godCount := $part//character[./@idref ! normalize-space() = $g] => count()

return 
     concat("god ID:", "&#x9;", $godID, "&#x9;", "god name:", "&#x9;", $godName, "&#x9;", "part title:", "&#x9;", $partTitle, "&#x9;", "part number:", "&#x9;", $partNumber, "&#x9;", "number of times referenced in this part:", "&#x9;", $godCount, "&#x9;", "book number:", "&#x9;", $book), "&#10;" );
 
let $filename := "network_PVgodRefs.tsv"
let $doc-db-uri := xmldb:store("/db/mayan-queries/", $filename, $ThisFileContent, "text/plain")
return $doc-db-uri 

(:  :View this TSV at http://newtfire.org:8338/exist/rest/db/mayan-queries/network_PVgodRefs.tsv :)