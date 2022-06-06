xquery version "3.1";
(:  :declare variable $thisFileContent :=:)
<svg xmlns="http://www.w3.org/2000/svg" width="3000" height="1000">
<g transform="translate(25, 200)">
{
let $ac := doc('/db/assassinsCreed/assassinscreedodyssey.xml')
let $intro := $ac//Q{}intro
let $chapNums := $ac//Q{}chapterNum
let $segments := ($intro, $chapNums)
for $s at $pos in $segments
    let $actions := $s//Q{}action
    let $speakers := $s//Q{}speaker
    let $distSpeakers := $speakers ! normalize-space() => distinct-values()
    let $countSpeakers := $distSpeakers => count()
    let $countActions := $actions => count()
    let $spacer := 100
return 
    <g>
      <circle cx="{$pos * $spacer}" cy="160" r="{$countActions}" stroke="black" fill="blue"/>
      <line x1="{$pos * $spacer}" y1="10" x2="{$pos * $spacer}" y2="{$countSpeakers * 5}" stroke="grey" stroke-width="{($countSpeakers div $countActions) * 10}"/>
      <text x="0" y="100" fill="orange">Ratio of speakers to actions = width of line </text>
      <text x="{$pos * $spacer}" y="-200" style="writing-mode: tb; glyph-orientation-vertical:0" fill="grey"> Count of Distinct Speakers: {$countSpeakers}</text>
      <text x="{$pos * $spacer}" y="250" style="writing-mode: tb; glyph-orientation-vertical:0" fill="blue"> Count of Actions: {$countActions}</text>
    </g>    
    
}
</g>
</svg>
(:  ;
let $filename := "chan_SVG2.svg"
let $doc-db-uri := xmldb:store("/db/wdjacca/", $filename, $thisFileContent)
return $doc-db-uri   
(: View this SVG at http://newtfire.org:8338/exist/rest/db/wdjacca/chan_SVG2.svg  :):)