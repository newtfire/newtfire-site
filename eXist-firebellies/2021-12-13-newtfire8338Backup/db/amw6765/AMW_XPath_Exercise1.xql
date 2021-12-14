xquery version "3.1";
let $autoColl := collection('/db/auto')/*
let $entries := $autoColl//entry
for $entry in $entries
let $name := $entry/name
let $built := $entry/built/@when ! data()
return concat($name, ' !!!!SCREAM ', $built)

(:  :let $smashcoll := doc('/db/smashtiers/supersmashtierlist.xml')/*
let $char := $smashcoll//char
for $c in $char
where $c/game[@n="3"]
let $cid := $c/@id ! string()
order by $cid descending
return $cid :)



(:  :doc('/db/smashtiers/supersmashtierlist.xml')//char[game[@n="3"]][game[@n="2"]][game[@n="4"]]/@id ! string() :)
