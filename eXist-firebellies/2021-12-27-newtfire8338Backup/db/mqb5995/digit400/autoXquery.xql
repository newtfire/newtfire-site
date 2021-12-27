xquery version "3.1";
let $auto := collection('/db/auto')/*
let $entries := $auto//entry
for $e in $entries
let $built := $e/built/@when ! string()
let $name := $e/name ! normalize-space()
 
let $distBuilt := $built => distinct-values()
for $d in $distBuilt
let $carName := $auto[descendant::built/@when = $d]//name ! string() ! normalize-space()

return concat($d, ': ', string-join($carName, ', '))
