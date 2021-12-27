xquery version "3.1";
declare variable $ac := doc('/db/assassinsCreed/assassinscreedodyssey.xml');
declare variable $intro := $ac//Q{}intro;
declare variable $chapNums := $ac//Q{}chapterNum;
declare variable $segments :=($intro, $chapNums);
declare variable $actionCounts := 
    for $s in $segments
    let $actions := $s//Q{}action
    let $countActions := $actions => count()
    return $countActions;
declare variable $maxActions := $actionCounts => max();

declare variable $heightSpacer :=10;
declare variable $spacer :=65;
declare variable $ThisFileContent:=
<svg xlmns="https://www.w3.org/200/svg" viewBox="0 0 2000 1000">
<g transform="translate(50, 500)">
<line x1="0" y1="0" x2="{29 * $spacer}" y2="0" stroke="black" sroke-width="2" />
<line x1="0" y1="0" x2="0" y2="-{$heightSpacer * $maxActions}" stroke="black" sroke-width="2" />
{
for $s at $pos in $segments

let $actions := $s//Q{}action
let $sectionTitle :=
    if ($s//Q{}chapTitle)
        then $s//Q{}chaptTitle/string() ! normalize-space()
    else "intro"
    
let $speakers := $s//Q{}speaker
let $distSpeakers := $speakers ! normalize-space() => distinct-values()
let $countSpeakers := $distSpeakers =>count()

let $countActions := $actions => count()

return 

<g>
    <line x1="{$pos * $spacer}" y1="0" x2="{$pos * $spacer}" y2="-{$countActions * $heightSpacer}" stroke ="red" stroke-width="24"/>
    <line x1="{$pos * $spacer + 25}" y1="0" x2="{$pos * $spacer + 25}" y2="-{$countSpeakers * $heightSpacer}" stroke ="black" stroke-width="24"/>
    <circle cx="1800" cy="-400" r="40" stroke="black" stroke-width="2" fill="red" />
    <circle cx="1700" cy="-400" r="40" stroke="black" stroke-width="2" fill="black" />
    <text x="1670" y="-450">Speakers</text>
    <text x="1775" y="-450">Actions</text>
    <text x="{$pos * $spacer}" y="05" style="writing-mode: tb; glyph-orientation-vertical:0">{$sectionTitle}</text>
    <text x="" y="-400" >Count of speakers and actions in Assassins Creed Odyssey</text>
    </g>
}
</g>
    </svg>;
$ThisFileContent
(:  :let $filename := "SVG3_Fassett.svg"
let $doc-db-uri := xmldg:store("/db/stf5123/"), $filename, $ThisFileContent)
return $doc-db-uri:)

