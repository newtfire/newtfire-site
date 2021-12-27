xquery version "3.1";
declare variable $ThisFileContent :=
<svg xmlns="http://www.w3.org/2000/svg" width="5000" height="1000">
<g transform="translate(25, 200)">
{ 
let $xqueryTest := doc('/db/assassinsCreed/assassinscreedodyssey.xml')
let $intro := $xqueryTest//Q{}intro
let $chapNums := $xqueryTest//Q{}chapterNum
let $segments := ($intro, $chapNums)
for $a at $pos in $segments
let $speeches := $a//Q{}sp
let $sectionTitle :=
    if ($a//Q{}chapTitles)
        then $a//Q{}chapTitles/string() !normalize-space()
    else "intro"
    
let $speakers := $a//Q{}speaker
let $distSpeakers := $speakers ! normalize-space() => distinct-values()
let $countSpeakers := $distSpeakers => count()

let $countSpeeches := $speeches => count()
(:  return concat($pos, "&#x9;", $sectionTitle, "&#x9;", $countSpeeches, "&#x9;", $countSpeakers) :)
let $spacer := 140
return 
    <g>
        <rect x="{$pos * $spacer}" y="100" width="50" height="{$countSpeeches div 3}" transform="scale(1, -1) translate(0, -100)" fill="teal" stroke="black" stroke-width="2"/>
        <text x="{$pos * $spacer + 50}" y="75" style="writing-mode: tb; glyph-orientation-vertical">{$sectionTitle}</text>
        <text x="{$pos * $spacer + 25}" y="25" style="writing-mode: tb; glyph-orientation-vertical">{$countSpeeches}</text>
        <rect x="{$pos * $spacer + 50}" y="100" width="50" height="{$countSpeakers}" transform="scale(1, -1) translate(0, -100)" fill="orange" stroke="black" stroke-width="2"/>
        <text x="{$pos * $spacer + 75}" y="25" style="writing-mode: tb; glyph-orientation-vertical">{$countSpeakers}</text>
    </g>
}

</g>
</svg> ;

let $filename := "xqueryTest.svg"
let $doc-db-uri := xmldb:store("/db/ajm7408/", $filename, $ThisFileContent)
return $doc-db-uri
(: View this SVG at http://newtfire.org:8338/exist/rest/db/ajm7408/xqueryTest.svg :)