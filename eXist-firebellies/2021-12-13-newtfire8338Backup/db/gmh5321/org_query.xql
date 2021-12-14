xquery version "3.1";
let $treecoll := collection('/db/btrees/articles/')/*
let $org := $treecoll//org ! string() =>  distinct-values() => sort()
for $o in $org
    return
        
        <li>{$o}</li>

