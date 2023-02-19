xquery version "3.1";
declare variable $ySpacer := 10;
declare variable $xSpacer := 30;
declare variable $ThisFileContent :=
 <svg xmlns="http://www.w3.org/2000/svg" width="1000" height="1000">
<line x1="10" y1="450" x2="500" y2="450" stroke-width="2" stroke="black"/>
<line x1="10" y1="450" x2="10" y2="0" stroke-width="2" stroke="black"/>
         {
         
let $document :=doc('/db/assassinsCreed/assassinscreedodyssey.xml')
let $chapter :=$document//Q{}chapterNum
for $c at $pos in $chapter
let $actionCount := $c//Q{}action => count()
let $distinctspeakers := $c//Q{}speaker/text() => distinct-values() => count()

return 
    <g>
<line x1="{$pos * $xSpacer}" x2="{$pos * $xSpacer}" y1="0" y2="{$actionCount * $ySpacer}" stroke="red" stroke-width="25"/>
<line x1="{$pos * $xSpacer}" x2="{$pos * $xSpacer}" y1="0" y2="{$distinctspeakers * $ySpacer}" stroke="#e0e0e0" stroke-width="20"/>     
</g>
             
         }
 </svg>;
 $ThisFileContent
