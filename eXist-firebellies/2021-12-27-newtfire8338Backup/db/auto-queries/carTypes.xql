xquery version "3.1";
declare variable $autoColl := collection('/db/auto/')/*;
let $digTheStyle := $autoColl//bodyStyle
let $distinct := distinct-values($digTheStyle)
for $d in $distinct
return
<li>
    {$d}
    </li>
