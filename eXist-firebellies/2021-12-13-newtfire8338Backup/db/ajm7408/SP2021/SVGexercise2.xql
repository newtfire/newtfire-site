xquery version "3.1";
declare variable $ThisFileContent :=
<svg xmlns="http://www.w3.org/2000/svg" width="3000" height="1000">
<g transform="translate(25, 200)">
{
let $ac := doc('/db/assassinsCreed/assassinscreedodyssey.xml')
let $intro := $ac//Q{}intro
let $chapNums := $ac//Q{}chapterNum
let $segments := ($intro, $chapNums)
for $s at $pos in $segments
let $actions := $s//Q{}action
let $sectionTitle :=
    if ($s//Q{}chapTitles)
        then $s//Q{}chapTitles/string() !normalize-space()
    else "intro"
    
(:  :let $sectionSpeakers :=
    if ($s//Q{}speaker)
        then $s//Q{}speaker/string() !normalize-space()
    else "intro" :)
let $speakers := $s//Q{}speaker
let $distSpeakers := $speakers ! normalize-space() => distinct-values()
let $countSpeakers := $distSpeakers => count()

let $countActions := $actions => count()
let $spacer := 65
return
    <g>
        <circle cx="{$pos * $spacer}" cy="100" r="{$countActions}" stroke="black" stroke-width="2" fill="teal"/>
        <circle cx="{$pos * $spacer}" cy="100" r="{$countSpeakers}" stroke="black" stroke-width="2" fill="orange"/>
        <text x="{$pos * $spacer}" y="150" style="writing-mode: tb; glyph-orientation-vertical">{$sectionTitle}</text>
        <text x="{$pos * $spacer}" y="30" style="writing-mode: tb; glyph-orientation-vertical">{$countSpeakers}</text>
        {$countSpeakers}
    </g>

}

</g>
</svg> ;

let $filename := "acData.svg"
let $doc-db-uri := xmldb:store("/db/ajm7408/", $filename, $ThisFileContent)
return $doc-db-uri
(: View this SVG at http://newtfire.org:8338/exist/rest/db/ajm7408/acData.svg :)