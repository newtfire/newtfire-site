xquery version "3.1";
let $autoColl := collection('/db/auto')/*
let $entries := $autoColl//entry
let $wheelbases := $entries//wheelbase
let $wheelbaseUnits := $wheelbases/@unit => distinct-values()
let $wheelbaseSize := $wheelbases/@quant ! data() => distinct-values() => sort()
for $w in $wheelbaseSize
where $w < 2000
let $smallCars := $entries[.//wheelbase/@quant = $w]/name ! string()
(: If you see a cardinality error, set a new for loop: there may be more than one car with this wheelbase. :)
for $s in $smallCars
return concat($s, ", wheelbase size: ", $w)