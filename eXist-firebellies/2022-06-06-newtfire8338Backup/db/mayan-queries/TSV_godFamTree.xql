xquery version "3.1";
let $godIndex := doc('/db/mayan/PV_characterIndex.xml')
let $indexChars := $godIndex//character
for $i in $indexChars
let $ID := $i/@xml:id ! string() 
let $godName := $i/name/text()
let $family := $i//family/*
for $f in $family
where $i//family => count() > 0
let $famMember := $f/name() ! string()
let $famName := $f[substring-after(./@idref ! data(), '#') = $ID]/name
let $famID := substring-after($f/@idref ! data(), '#')
return concat($godName, "&#x9;", $famMember, "&#x9;", $famName, "&#x9;", $famID)

