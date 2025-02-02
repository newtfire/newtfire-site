xquery version "3.1";
(: declare variable $ThisFileContent :=  :)
<svg xmlns="http://www.w3.org/2000/svg" width="2000" height="2000">
<g transform= "translate (25,200)">

{
let $ac := doc('/db/assassinsCreed/assassinscreedodyssey.xml')
let $intro := $ac//Q{}intro
let $chapNums :=$ac//Q{}chapterNum
let $segments :=($intro, $chapNums)
for $s at $pos in $segments 
let $actions := $s//Q{}action
let $sectionTitle :=
if ($s//Q{}chapTitles)
then  $s//Q{}chapTitles/string() ! normalize-space()
else "intro"

let$speakers := $s//Q{}speaker
let $distSpeakers := $speakers ! normalize-space() => distinct-values()
let $countSpeakers:= $distSpeakers => count()


let $countActions := $actions =>count()
let $spacer := 70
return 



<g>
    <text x="400" y="000"> Distinct Speakers Count vs Actions Count </text>
    <rect y="100"x="{$pos * $spacer}" height="25" width="{$countActions}"fill="red"></rect>
    <rect y="125" x="{$pos * $spacer}" height="25" width="{$countSpeakers}" fill="purple"></rect>
   <text x="{$pos * $spacer}" y="250" style ="writing-mode: tb; glyph-orientation-verical:o">{$sectionTitle}</text>
   {$countActions}
</g>
}
    
</g>
</svg>  
(:
 ;
let $filename := "SVGex2attempt.svg"
let $doc-db-uri := xmldb:store("/db/sao5303/",$filename, $ThisFileContent)
return $doc-db-uri :)