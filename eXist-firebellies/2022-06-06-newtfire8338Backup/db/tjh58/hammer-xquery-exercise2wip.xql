xquery version "3.1";
declare default element namespace "http://www.tei-c.org/ns/1.0";
let $plays := collection('/db/apps/shakespeare/data/')//TEI
let $speaker := $plays//speaker => distinct-values() => count()
for $p in $plays
where $p gt 50
return $p
