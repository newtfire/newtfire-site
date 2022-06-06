xquery version "3.1";



(: space for svg :)

(: the document and organization :)
let $ac := doc('/db/assassinsCreed/assassinscreedodyssey.xml')
let $intro := $ac//Q{}intro
let $chapters :=$ac//Q{}chapterNum
let $segments :=($intro, $chapters)

(: for loop :)
for $s at $pos in $segments
let $sectionTitle :=
if ($s//Q{}chapTitles)
then  $s//Q{}chapTitles/string() ! normalize-space()
else "intro"

(: Speech/speakers :)
let $speeches := $s//Q{}sp => count() 
let$speakers := $s//Q{}speaker
let $distSpeakers := $speakers ! normalize-space() => distinct-values() 
let $countSpeakers:= $distSpeakers => count() 

(: sorts the parts in descending order :)
order by $countSpeakers descending

order by $pos descending 
(: 
return $countSpeakers
:)

(: effectivley organizes them by position in descending order now :)
 return concat ($pos, ", Section Title: ", $sectionTitle, ", # of speeches: ",$speeches, ", Speaker Count:  ",$countSpeakers ) 


