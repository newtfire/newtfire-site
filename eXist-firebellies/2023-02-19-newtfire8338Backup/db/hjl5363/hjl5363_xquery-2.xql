xquery version "3.1";
declare default element namespace "http://www.tei-c.org/ns/1.0";
let $plays := collection('/db/apps/shakespeare/data/')//TEI
let $speaker => distinct-values()
for $p in $plays
let $title in $p
return => distinct-values()
where $p => base-uri()
return $p
return concat()