xquery version "3.1";
let $autoColl := collection('/db/auto')/*
let $entries := $autoColl//entry
let $built := $entries/built/@when ! data()
let $name := $entries/name ! normalize-space()
return concat(string-join($built), ': ', string-join($name))
(: Think about: Why is THIS FLWOR bad? Why do we need the For statements in FLWOR? :)