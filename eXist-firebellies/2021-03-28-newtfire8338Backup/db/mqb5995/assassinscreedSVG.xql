xquery version "3.1";
declare variable $ThisFileContent :=
<svg xmlns="http://www.w3.org/2000/svg" viewbox="0 0 2000 500">
<g transform = "translate(0, 20)">
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
let $spacer := 70
 

return
    <g>
        <text x="50" y="35" style="font-size:1.5em;">How do gameplay actions (blue) vary in relation to number of distinct characters (white) present in game chapter sections of Assassin's Creed, Odyssey?</text>
        <circle cx="{$pos * $spacer}" cy="100" r="{$countActions}" stroke="black" stroke-width="2" fill="blue"/>
        <text x="{$pos * $spacer}" y="155" style="writing-mode: tb; glyph-orientation-vertical: 0">{$sectionTitle}</text>
        <circle cx="{$pos * $spacer}" cy="100" r="{$countSpeakers}" stroke="black" stroke-width="0" fill="white"/>
    </g>    
}
</g>
</svg> ;
let $filename := "assassinsSVG.svg"
let $doc-db-uri := xmldb:store("/db/mqb5995/", $filename, $ThisFileContent)
return $doc-db-uri  