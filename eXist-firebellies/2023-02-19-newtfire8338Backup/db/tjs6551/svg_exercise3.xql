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
    
declare variable $ThisFileContent :=
<svg xmlns="http://www.w3.org/2000/svg" width="2500" height="300">
<g>

<line x1="15" y1="50" x2="15" y2="150" stroke="black" stroke-width="2"/>
<line x1="15" y1="150" x2="2300" y2="150" stroke="black" stroke-width="2"/>
<text x="100" y="225" >BLACK = actions count</text>
<text x="100" y="250" >YELLOW = distinct speakers count</text>

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
        <rect x="{15 + ($pos * $spacer - 50)}" y = "{150 - $countActions *2}" width="25" height="{$countActions * 2}" stroke="black" stroke-width="2" fill="black"/>
        <rect x="{40 + ($pos * $spacer - 50)}" y = "{150 - $countSpeakers*2}" width="25" height="{$countSpeakers * 2}" stroke="black" stroke-width="2" fill="yellow"/>
        <text x="{32.5 + ($pos * $spacer - 50)}" y="175" >{$pos}</text>
    </g>
}

</g>
</svg> ;
$ThisFileContent
