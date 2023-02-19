xquery version "3.1";
declare variable $ThisFileContent :=
<svg xmlns="http://www.w3.org/2000/svg" width="2500" height="500">
<g transform = "translate(0, 200)">
{
let $ac := doc('/db/assassinsCreed/assassinscreedodyssey.xml')
let $intro := $ac//Q{}intro
let $chapNums := $ac//Q{}chapterNum
let $segments := ($intro, $chapNums)
for $s at $pos in $segments
let $actions := $s//Q{}action
let $sectionTitle := 
    if ($s//Q{}chapTitles)
        then $s//Q{}chapTitles/string() ! normalize-space()
    else "intro"
let $speakers := $s//Q{}speaker
let $distSpeakers := $speakers ! normalize-space() => distinct-values()
let $countSpeakers := $distSpeakers => count()
let $countActions := $actions => count ()
let $spacer := 75

return 
    <g>
        <rect x="{$pos * $spacer}" width="50" height="{$countActions}" stroke="black" stroke-width="2" fill="black"/>
        <text x="{$pos * $spacer + 20}" y="150" style="writing-mode: tb; glyph-orientation-horizontal:0">{$sectionTitle}</text>
        <rect x="{$pos * $spacer}" width="50" height="{$countSpeakers}" stroke="black" stroke-width="2" fill="yellow"/>
    </g>
}
</g>
</svg> ;
$ThisFileContent
