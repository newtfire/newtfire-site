xquery version "3.1";
(: This is kind of a clumsy example, but meant to illustrate nested for loops :)
let $mayanColl := doc('/db/mayan/PV_characterIndex.xml')/*
let $characters := $mayanColl//character
for $char in $characters
let $id := $char/@xml:id ! string()
let $name := $char/name ! normalize-space()
where $char//grandChildren
let $grandChildren := $char//grandChildren/*/@idref ! string()
for $g in $grandChildren
return concat($id, ': ', $name, ' grandchildren:', $g)