xquery version "3.1";

let $autoColl := collection('/db/btrees')/*
let $entries := $autoColl//entry
for $e in $entries
let $cname := $e/cname/@when ! data()
let $desc := $e/cname ! normalize-space()
return concat($cname, ': ', $desc)

