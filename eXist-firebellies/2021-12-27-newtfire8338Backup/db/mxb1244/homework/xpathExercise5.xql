xquery version "3.1";
let $autoColl := collection('/db/auto')/*
let $entries := $autoColl//entry
let $enginePower := $entries//enginePower
let $enginePowerUnits := $enginePower/@unit => distinct-values()
let $enginePowerSize := $enginePower/@quant ! data() => distinct-values() => sort() 
for $e in $enginePowerSize
where $e >= 9
let $smallCars := $entries[.//enginePower/@quant = $e]/name ! string()
(: If you see a cardinality error, set a new for loop: there may be more than one car with this wheelbase. :)
for $s in $smallCars
return concat($s, ", enginePower: ", $e)