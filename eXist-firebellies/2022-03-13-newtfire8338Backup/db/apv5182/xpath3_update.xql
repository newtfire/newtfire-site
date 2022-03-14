
xquery version "3.1";
let $charList := collection('/db/auto')/*
let $entry:= $charList//entry
for $e in $entry
let $type := $e//built ! string(@when)
for $years in $type
for $built in $years
let $name := $e//name ! string()
let $stringjoin := string-join($name,':')
return concat ($built,':',$stringjoin)
