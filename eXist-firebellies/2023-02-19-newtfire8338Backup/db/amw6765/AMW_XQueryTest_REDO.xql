xquery version "3.1";
declare variable $ThisFileContent := 
<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 3000 1000">
<g transform="translate(100, 500)">
{
let $ac := doc('/db/assassinsCreed/assassinscreedodyssey.xml')
let $intro := $ac//Q{}intro
let $chapterNums := $ac//Q{}chapterNum
let $segments := ($intro, $chapterNums)
for $s at $pos in $segments
let $speeches := $s//Q{}sp
let $acTitles := 
    if ($s//Q{}chapTitles)
        then $s//Q{}chapTitles/string() ! normalize-space()
    else "intro"
let $speakers := $s//Q{}speaker
let $distSpeakers := $speakers ! normalize-space() => distinct-values()
let $countSpeakers := $distSpeakers => count()
let $countSpeeches := $speeches  => count()
(:  :return concat($pos, "&#x9;", $acTitles, "&#x9;", $countSpeeches, "&#x9;", $countSpeakers) :)
let $spacer := 65
return
    <g>
        <text x="{$pos * $spacer + 50}" y="75" fill="dark-gray" style="font-family:sans-serif;font-size:20px; writing-mode: tb; glyph-orientation-horizontal: 2">{$acTitles}</text>
        <rect x="{$pos * $spacer}" y="100" width="50" height="{$countSpeeches div 3}" transform="scale(1, -1) translate(0, -100)" fill="red" stroke="black" stroke-width="2"/>
        <text x="{$pos * $spacer + 25}" y="25" fill="dark-gray" style="font-family:sans-serif;font-size:20px; writing-mode: tb; glyph-orientation-horizontal: 2">{$countSpeeches}</text>
        <text x="{$pos * $spacer + 75}" y="25" fill="dark-gray" style="font-family:sans-serif;font-size:20px; writing-mode: tb; glyph-orientation-horizontal: 2">{$countSpeakers}</text>
        <rect x="{$pos * $spacer + 50}" y="100" width="50" height="{$countSpeakers}" transform="scale(1, -1) translate(0, -100)" fill="blue" stroke="black" stroke-width="2"/>
        <text x="2000" y="-300" fill="red" style="font-family:sans-serif;font-size:25px; writing-mode: tb; glyph-orientation-horizontal: 5">Red = Speeches</text>
        <text x="2100" y="-300" fill="blue" style="font-family:sans-serif;font-size:25px; writing-mode: tb; glyph-orientation-horizontal: 5">Blue = Speakers</text>
    </g>
}
</g>
</svg> ;

$ThisFileContent
(:  :let $filename := "AMW_XQueryTest_REDO.svg"
let $doc-db-uri := xmldb:store("/db/amw6765/", $filename, $ThisFileContent)
return $doc-db-uri :)
(: View this SVG at http://newtfire.org:8338/exist/rest/db/amw6765/AMW_XQueryTest_REDO.svg :)
    
