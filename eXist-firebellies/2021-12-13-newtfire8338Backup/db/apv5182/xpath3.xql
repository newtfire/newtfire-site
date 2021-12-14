xquery version "3.1";

let $charList := collection('/db/auto')/*
let $type:= $charList//entry/built ! string(@when)
for $years in $type
for $built in $years
let $name := $charList//entry/name ! string()

let $stringjoin := string-join($name,':')
return concat ($built,':',$stringjoin)
