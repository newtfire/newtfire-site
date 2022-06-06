xquery version "3.1";
declare variable $ac := doc('/db/assassinsCreed/assassinscreedodyssey.xml');
declare variable $intro := $ac//Q{}intro;
declare variable $chapNums := $ac//Q{}chapterNum;
declare variable $segments := ($intro, $chapNums);
declare variable $actionCounts := 
    for $s in $segments
    let $actions := $s//Q{}action
    let $countActions := $actions => count()
    return $countActions;
declare variable $maxActions := $actionCounts => max();

declare variable $heightSpacer := 10;
declare variable $spacer := 65;
declare variable $ThisFileContent := 
<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 3000 1000">
<g transform="translate(100, 500)">
<line x1="0" y1="0" x2="{29 * $spacer}" y2="0" stroke="black" stroke-width="2"/>
<line x1="0" y1="0" x2="0" y2="-{$heightSpacer * $maxActions}" stroke="black" stroke-width="2"/>
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

let $countActions := $actions => count()
let $spacer := 65
return 
    <g>
        <text x="460" y="-450" fill="black" style="font-size:50px;font-weight:bold;">Number of Speakers and Actions in Each Chapter</text>
        
        <line x1="{$pos * $spacer}" y1="0" x2="{$pos * $spacer}" y2="-{$countActions * $heightSpacer}" stroke="teal" stroke-width="25"/>
        <line x1="{$pos * $spacer + 25}" y1="0" x2="{$pos * $spacer + 25}" y2="-{$countSpeakers * $heightSpacer}" stroke="orange" stroke-width="25"/>
        <text x="-20" y="0" fill="dark-gray" style="font-family:sans-serif;font-size:25px; writing-mode: tb; glyph-orientation-horizontal: 5">0</text>
        <text x="-20" y="-200" fill="dark-gray" style="font-family:sans-serif;font-size:25px; writing-mode: tb; glyph-orientation-horizontal: 5">20</text>
        <text x="-20" y="-400" fill="dark-gray" style="font-family:sans-serif;font-size:25px; writing-mode: tb; glyph-orientation-horizontal: 5">40</text>
        <text x="2000" y="-300" fill="teal" style="font-family:sans-serif;font-size:25px; writing-mode: tb; glyph-orientation-horizontal: 5">Teal = Actions</text>
        <text x="2100" y="-300" fill="orange" style="font-family:sans-serif;font-size:25px; writing-mode: tb; glyph-orientation-horizontal: 5">Orange = Speakers</text>
        
      <text x="{$pos * $spacer}" y="45" style="writing-mode: tb; glyph-orientation-horizontal:0">{$sectionTitle}</text>

      
    </g>    
    
}
</g>
</svg> ;
$ThisFileContent
(:  :let $filename := "ac_SVG3.svg"
let $doc-db-uri := xmldb:store("/db/amw6765/", $filename, $ThisFileContent)
return $doc-db-uri :)
(: View this SVG at http://newtfire.org:8338/exist/rest/db/amw6765/ac_SVG3.svg  :)