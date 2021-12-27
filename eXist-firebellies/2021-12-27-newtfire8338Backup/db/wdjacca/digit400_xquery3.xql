xquery version "3.1";
let $collection := collection('/db/auto/')/*
let $year := $collection//built/@when => distinct-values()
for $y in $year
let $name := $collection[.//built/@when = $y]//name/text()
return concat($y, ' :', string-join($name,', '))