xquery version "3.1";
(: Yeah I cannot for the life of me figure out what it is youre asking us to do for the SVG portion of this. So i setup as much as I could for it before not knowing what to do. I also know I needed to declare more variables as well. I still didnt understand what the content of the bar graph was supposed to be. And keept getting rest address errors as well. :)
declare variable $ac := doc('/db/assassinsCreed/assassinscreedodyssey.xml');
declare variable $ThisFileContent := 
(: <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 3000 1000">
<g transform="translate(100, 500)"> :)
let $ac := doc('/db/assassinsCreed/assassinscreedodyssey.xml')
let $intro := $ac//Q{}intro
let $chapterNums := $ac//Q{}chapterNum
let $segments := ($intro, $chapterNums)
    for $s at $pos in $segments
let $acTitles := $s//Q{}chapTitles
let $speeches := $s//Q{}sp => count()
let $speakers := $s//Q{}speaker
let $distSpeakers := $speakers ! normalize-space() => distinct-values()
let $countSpeakers := $distSpeakers => count()
(:  :return concat($pos, " ", $acTitles, " ", $speeches, " ", $countSpeakers):)
(: </svg> :)
$ThisFileContent
(:  :let $filename := "AMW_DIGIT_XQueryTest.xql"
let $doc-db-uri := xmldb:store("/db/amw6765/", $filename, $ThisFileContent)
return $doc-db-uri :)
(: View this SVG at http://newtfire.org:8338/exist/rest/db/amw6765/AMW_DIGIT_XQueryTest.svg :)
