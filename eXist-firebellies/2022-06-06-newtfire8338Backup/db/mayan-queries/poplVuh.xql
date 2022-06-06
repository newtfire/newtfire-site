xquery version "3.1";
let $autoColl := collection('/mayan/popolVuh')/*
let $entries := $autoColl//entry
for $e in $entries
let $built := $e/built/@when ! data()
let $name := $e/name ! normalize-space()
return concat($built, ': ', $name)
