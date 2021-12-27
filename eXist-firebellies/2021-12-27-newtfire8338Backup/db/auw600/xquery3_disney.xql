xquery version "3.1";
let $disneySongs := collection('/db/disneySongs/')
for $d in $disneySongs
let $title:=$d//title
let $lines := $d //ln => count()
let $stlgth := $d//song/string-length()
let $shortest := min($stlgth)
let $longest := max($stlgth)
let $info := concat($title,", line count = ", $lines,",string length = ",$stlgth)
where $stlgth eq $longest
order by $stlgth descending

return $info