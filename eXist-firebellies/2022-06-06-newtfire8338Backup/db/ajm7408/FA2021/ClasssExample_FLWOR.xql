xquery version "3.1";
let $autoColl := collection('/db/auto')/*
let $entries := $autoColl//entry
for $e in $entries
let $name := $e/name
let $built := $e/built/@when ! data()
(:  :let $built := $entries/built/@when ! data()
let $name := $entries/name ! normalize-space() :)
return concat($built, ': ', $name)
(: Think about: Why is THIS FLWOR bad? Why do we need the For statements in FLWOR? :)