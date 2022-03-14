xquery version "3.1";
(:  :collection('/db/letsrock')//line[i[@story = "pot"]]/@n ! data() :)

(:  :doc('/db/smashtiers/supersmashtierlist.xml')//char[game[@n = "2"]]/@id ! data() :)

let $smashcall:= doc('/db/smashtiers/supersmashtierlist.xml')/*
let $char := $smashcall//char
(:  if using let statement :let $game3char := $char[game[@n='3']]
return $game3char :)
for $c in $char
where $c/game[@n='3']
let $cid:= $c/@id ! string()
order by $cid
return $cid