xquery version "3.1";
let $disneySongs := collection('/db/disneySongs/')
for $d in $disneySongs
let $dtitle:= $d//title
let $lines:= $d//ln => count()
let $stlength:= $d//song/string-length()
order by $stlength descending
let $info:= concat($dtitle,", line count = ", $lines,",string length = ",$stlength)
let $shortest:= min($stlength)
let $longest:= max($stlength)
where $stlength eq $longest
return
