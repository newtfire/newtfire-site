xquery version "3.1";
declare default element namespace "http://www.tei-c.org/ns/1.0";
let $shakes:=collection('/db/apps/shakespeare/data/')
for $s in $shakes
let $titles:=$s//title/string()
let $root:=$s/TEI
let $fallstaff:=$root[//speaker/string()="Falstaff"]
for $f in $fallstaff
let $ftitles:=$f//titleStmt/title/string()
let $fcount:=$shakes//speaker[./text()="Falstaff"]=>count()
return $fcount
