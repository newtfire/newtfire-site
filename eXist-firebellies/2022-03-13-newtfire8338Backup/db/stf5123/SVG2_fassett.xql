xquery version "3.1";
declare variable $ThisFileContent:=
<svg xlmns="https://www.w3.org/200/svg" width="3000" height="1000">
<g transform="translate(25, 200)">
{
let $ac := doc('/db/assassinsCreed/assassinscreedodyssey.xml')
let $intro := $ac//Q{}intro
let $chapNums := $ac//Q{}chapterNum
let $segments :=($intro, $chapNums)

for $s at $pos in $segments

let $actions := $s//Q{}action
let $sectionTitle :=
    if ($s//Q{}chapTitle) (:ebb: You had a typo here! You were reaching for chapTitles, and the element name is just chapTitle! :)
        then $s//Q{}chaptTitles/string() ! normalize-space()
    else "intro"
    
let $speakers := $s//Q{}speaker
let $distSpeakers := $speakers ! normalize-space() => distinct-values()
let $countSpeakers := $distSpeakers =>count()

let $countActions := $actions => count()
let $spacer :=65
return 

<g>
    <text>Assassins Creed speaker (black) to action (red) ratio</text>
    <circle cx="{$pos * $spacer}" cy="100" r="{$countActions}" stroke="black" stroke-width="2" fill="red" />
    <text x="{$pos * $spacer}" y="200" style="writing-mode: tb; glyph-orientation-vertical:0">{$sectionTitle}</text>
    <circle cx="{$pos * $spacer}" cy="100" r="{$countSpeakers}" fill="black" />
    </g>
}
</g>
    </svg>;
$ThisFileContent

(:  :let $filename := "acData-SVG2.svg"
let $doc-db-uri := xmldb:store("/db/stf5123/"), $ThisFileContent)
return $doc-db-uri
:)
