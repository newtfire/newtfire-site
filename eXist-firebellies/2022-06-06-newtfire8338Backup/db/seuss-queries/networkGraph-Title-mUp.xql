xquery version "3.1";
declare variable $textFile := 
string-join(
let $seussBooks := collection('/db/seuss/tsg-xml/')
for $s in $seussBooks
    let $sTitle := $s//title ! normalize-space()
    let $char := $s//mUp ! normalize-space() => distinct-values()
        for $m in $char
            return 
                concat("book", "&#x9;", $sTitle, "&#x9;", $char, "&#x9;", $m), "&#10;");

let $filename := "Seuss.tsv"
let $doc-db-uri := xmldb:store("/db/seuss-queries", $filename, $textFile, "text/plain")
return $doc-db-uri
