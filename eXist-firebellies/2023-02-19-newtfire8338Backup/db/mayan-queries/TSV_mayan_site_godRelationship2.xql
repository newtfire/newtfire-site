xquery version "3.1";
let $mayan := doc('/db/mayan/sitesIndex.xml/')/*
let $mayanSite := $mayan//site
for $m in $mayanSite
let $name := $m/name
let $structures := $m/structures/building
let $relics := $m/artifacts/relic
for $r in $relics
let $relicType := $r/@type ! data()
for $s in $structure
let $structureType := $s/@type ! data()
let $gods := ($r//deityName ! string(), $s//deityName ! string())[1]
for $g in $gods
    return 
       concat($name, "&#x9;", $relicType, "&#x9;", $structureType, "&#x9;", $g, "&#10;") 






