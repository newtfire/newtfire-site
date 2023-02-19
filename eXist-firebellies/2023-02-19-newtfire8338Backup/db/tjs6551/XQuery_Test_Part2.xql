xquery version "3.1";
declare variable $ThisFileContent :=
<svg xmlns="http://www.w3.org/2000/svg" width="3500" height="1000">
<g>
{
<g>
<line x1="15" y1="50" x2="15" y2="500" stroke="black" stroke-width="2"/>
<line x1="15" y1="500" x2="3000" y2="500" stroke="black" stroke-width="2"/>
<text x="100" y="575" >BLACK = speeches count</text>
<text x="100" y="600" >YELLOW = distinct speakers count</text>
</g>
}
{
let $ac := doc('/db/assassinsCreed/assassinscreedodyssey.xml')
let $intro := $ac//Q{}intro
let $chapNums := $ac//Q{}chapterNum
let $sections := ($intro, $chapNums)

for $s at $pos in $sections
let $sectionTitle := 
    if ($s//Q{}chapTitles)
        then $s//Q{}chapTitles/string() ! normalize-space()
    else "intro"
let $speeches := $s//Q{}sp => count()
let $speakers := $s//Q{}speaker
let $distSpeakers := $speakers ! normalize-space() => distinct-values()
let $countSpeakers := $distSpeakers => count()
let $spacer := 100
return 
    <g>
        <rect x="{15 + ($pos * $spacer - 50)}" y = "{500 - $speeches}" width="25" height="{$speeches}" stroke="black" stroke-width="2" fill="black"/>
        <rect x="{40 + ($pos * $spacer - 50)}" y = "{500 - $countSpeakers}" width="25" height="{$countSpeakers}" stroke="black" stroke-width="2" fill="yellow"/>
        <text x="{32.5 + ($pos * $spacer - 50)}" y="515" >{$pos}</text>
    </g>
}
</g>
</svg> ;
$ThisFileContent
