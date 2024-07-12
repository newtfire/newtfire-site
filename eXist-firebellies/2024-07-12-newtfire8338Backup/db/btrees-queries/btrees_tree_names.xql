xquery version "3.1";

let $btrees := collection('/db/btrees/')/*
let $entries := $btrees//entry
for $e in $entries
let $cname := $e/cname ! data() 

return 
    
    <h3>{$cname}</h3>

