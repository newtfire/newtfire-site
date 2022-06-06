xquery version "3.1";
let $ac := doc('/db/assassinsCreed/assassinscreedodyssey.xml')
let $intro := $ac//intro
let $chapNums := $ac//chapterNum
let $sections := ($intro, $chapNums)

for $s at $pos in $sections
let $sectionTitle := 
    if ($s//chapTitles)
        then $s//chapTitles/string() ! normalize-space()
    else "intro"
let $speeches := $s//sp => count()
let $speakers := $s//speaker
let $distSpeakers := $speakers ! normalize-space() => distinct-values()
let $countSpeakers := $distSpeakers => count()
order by $speeches descending
(: :concat($pos, " ",$sectionTitle, "; ", "# of speeches: ", $speeches,"; ","# of distinct speakers: ", $countSpeakers) :)
return