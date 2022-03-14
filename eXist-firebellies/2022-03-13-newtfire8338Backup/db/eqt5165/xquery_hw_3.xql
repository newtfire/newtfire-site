xquery version "3.1";

let $car := collection('/db/auto')/*
let $year := $car//built/@when ! string ()=> distinct-values() =>sort()

for $y in $year
let $name := $car[.//built/@when=$y]//name/text()

return concat ($y, ": ", string-join($name, ', '))