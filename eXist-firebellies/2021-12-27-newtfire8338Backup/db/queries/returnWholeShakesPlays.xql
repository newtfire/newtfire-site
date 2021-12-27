xquery version "3.1";
declare default element namespace "http://www.tei-c.org/ns/1.0";
let $shakes := collection('/db/apps/shakespeare/data/')
let $falstaffPlays := $shakes//TEI[descendant::speaker = "Falstaff"]
let $fplayTitles := $falstaffPlays//titleStmt/title ! string()
for $f in $falstaffPlays
return $f ! base-uri()