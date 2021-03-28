xquery version "3.1";

<svg xmlns="http://www.w3.org/2000/svg" width="3000" height="1000">
     <g transform= "translate (25, 200)">
{
let $ac := doc('/db/assassinsCreed/assassinscreedodyssey.xml')
let $intro := $ac//Q{}intro
let $chapNums := $ac//Q{}chapterNum
let $segments := ($intro, $chapNums)
for $s at $pos in $segments
let $actions := $s//Q{}action
let $sectionTitle :=
    if ($s//Q{}chapTitles)
        then $s//Q{}chapTitles/string()! normalize-space()
    else "intro"
let $speakers := $s//Q{}speaker
let $distSpeakers := $s//Q{}speakers ! normalize-space() => distinct-values()
let $countSpeakers := $distSpeakers => count()

let $countActions := $actions => count()
let $spacer := 70
return 
    <g>
        <rect x="{$pos * $spacer}" width="50" y="-{$countActions}" height="{$countActions}" fill="lawngreen" stroke="goldenrod" stroke-width="3" />
        <text x="{$pos * $spacer + 30}" y="10" style="writing-mode: tb; glyph-orientation-vertical:0">{$sectionTitle}</text>
        {$countSpeakers}
    </g>

}
</g>
</svg> 