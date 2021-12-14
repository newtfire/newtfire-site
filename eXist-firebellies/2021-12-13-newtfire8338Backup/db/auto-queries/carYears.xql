xquery version "3.1";
let $autocoll := collection('/db/auto/')/*
let $built := $autocoll//built
let $years := $built/@when ! string() =>  distinct-values() => sort()
for $y in $years
(:  :let $names:= $autocoll[.//built/@when= $y]//name :)
return 
<li>{$y}</li>
(: ebb: That's enough for a simple PHP page that offers year options to start. :)