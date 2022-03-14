xquery version "3.1";
let $auto := collection('/db/auto/')/*
let $cars := $auto//entry
for $c in $cars
let $built := $c/built/@when ! string()
let $make := $c/name ! normalize-space()

let $distBuilt := $built => distinct-values()
for $d in $distBuilt 
let $vName := $auto[descendant::built/@when = $d]//name ! string() ! normalize-space()
return concat($d, ': ', string-join($vName, ', '))

