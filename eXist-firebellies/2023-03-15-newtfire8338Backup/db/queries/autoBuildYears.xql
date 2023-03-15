xquery version "3.1";
let $autoColl := collection('/db/auto')/*
let $entries := $autoColl//entry
let $built := $autoColl//built/@when ! string()
let $buildDistinctYrs := $built => distinct-values()

for $b in $buildDistinctYrs
let $carnames := $entries[.//built/@when = $b]//name ! string()
return concat($b, ': ', string-join($carnames, ', '))