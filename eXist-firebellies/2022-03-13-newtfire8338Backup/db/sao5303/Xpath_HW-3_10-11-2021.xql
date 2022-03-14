xquery version "3.1";

let $car := collection('/db/auto')/*
let $year := $car//built/@when ! string ()=> distinct-values() =>sort()

for $ye in $year
let $name := $car[.//built/@when=$ye]//name/text()

return concat ($ye, ": ", string-join($name, ', '))