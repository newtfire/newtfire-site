xquery version "3.1";
declare variable $ac := doc('/db/assassinsCreed/assassinscreedodyssey.xml');
declare variable $intro := $ac//Q{}intro;
declare variable $chapNums := $ac//Q{}chapterNum;
declare variable $segments :=($intro, $chapNums);
declare variable $spCounts := 
    for $s in $segments
    let $sections := $s//Q{}sp
    let $countSections := $sections => count()
    return $countSections;
declare variable $maxsection := $spCounts => max();

declare variable $heightSpacer :=10;
declare variable $spacer :=65;
declare variable $ThisFileContent:=
<svg xlmns="https://www.w3.org/200/svg" viewBox="0 0 2500 5000">
<g transform="translate(90, 4000)">
<line x1="0" y1="0" x2="{29 * $spacer}" y2="0" stroke="black" sroke-width="2" />
<line x1="0" y1="0" x2="0" y2="-{$heightSpacer * $maxsection}" stroke="black" sroke-width="2" />
{
for $s at $pos in $segments

let $sections := $s//Q{}sp
let $sectionTitle := 
    if ($s//Q{}chapTitles)
        then $s//Q{}chapTitles/string() ! normalize-space()
    else "intro"
    
let $speakers := $s//Q{}speaker
let $distSpeakers := $speakers ! normalize-space() => distinct-values()
let $countSpeakers := $distSpeakers =>count()

let $countSections := $sections => count()

return 

  <g>
    <line x1="{$pos * $spacer}" y1="0" x2="{$pos * $spacer}" y2="-{$countSections * $heightSpacer}" stroke ="orange" stroke-width="24"/>
    <line x1="{$pos * $spacer + 25}" y1="0" x2="{$pos * $spacer + 25}" y2="-{$countSpeakers * $heightSpacer}" stroke ="blue" stroke-width="24"/>
    <circle cx="2000" cy="-400" r="70" stroke="black" stroke-width="2" fill="orange" />
    <circle cx="2010" cy="-250" r="70" stroke="black" stroke-width="2" fill="blue" />
    <text x="1978" y="-245" font-size="larger" fill="white">Speakers</text>
    <text x="1938" y="-400" font-size="larger">Amount Spoken</text>
    <text x="{$pos * $spacer}" y="05" style="writing-mode: tb; glyph-orientation-vertical:0">{$sectionTitle}</text>
    
    </g>
}
</g>
    </svg>;
$ThisFileContent

