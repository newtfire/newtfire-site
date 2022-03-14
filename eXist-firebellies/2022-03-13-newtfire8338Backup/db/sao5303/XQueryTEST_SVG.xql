xquery version "3.1";

declare variable $ac := doc('/db/assassinsCreed/assassinscreedodyssey.xml');
declare variable $intro := $ac//Q{}intro;
declare variable $chapters :=$ac//Q{}chapterNum;
declare variable $segments :=($intro, $chapters);
declare variable $spacer := 70;
declare variable $spacerHEIGHT := -10;
declare variable $TotalSpeeches := max( 
    for $s at $pos in $segments 
    let $speeches := $s//Q{}sp   
    return $speeches => count());
declare variable $Max-height:= $TotalSpeeches * $spacerHEIGHT;
declare variable $Max-width :=$segments => count() * $spacer + $spacer;
   
   
   declare variable $ThisFileContent:= 
   <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 {$Max-width} 7000">
<g transform= "translate (25,5000)">
<line x1="0" y1="0" x2="{$Max-width}" y2="0" stroke="black" stroke-width="2"/>
<line x1="0" y1="0" x2="0" y2="{$Max-height}" stroke="black" stroke-width="2"/>
{
for $s at $pos in $segments
let $sectionTitle :=
if ($s//Q{}chapTitles)
then  $s//Q{}chapTitles/string() ! normalize-space()
else "intro"
let $speeches := $s//Q{}sp => count() 
let$speakers := $s//Q{}speaker
let $distSpeakers := $speakers ! normalize-space() => distinct-values() 
let $countSpeakers:= $distSpeakers => count() 

(: sorts the parts in descending order :)
order by $countSpeakers descending

order by $pos descending 

return 


<g>
    (:this is just the header and colored circles to know which bar is which :)
    <text x="600" y="-4500"># of Speeches vs # of Distinct Speakers in Assassin's Creed Odyssey</text>
    <circle cy="-4450" cx="600" r="30" stroke="black" stroke-width="2" fill="green"></circle>
    <circle cy="-4450" cx="830" r="20" stroke="black" stroke-width="2" fill="purple"></circle>
    <text x="660" y="-4450"> # of speeches</text>
    <text x="900" y="-4450"> # of distinct speakers</text>
    
    (:This will be the text to accompany each bar to tell the actual number :)
    <text x="{$pos * $spacer -15}" y="{$speeches * $spacerHEIGHT -10}">{$speeches}</text>
    <text x="{$pos * $spacer+25}" y="{$countSpeakers * $spacerHEIGHT -10}">{$countSpeakers}</text>
    
    
    (:this will be the actual lines of data:)
    <line x1="{$pos * $spacer}" y2="0" y1="{$speeches * $spacerHEIGHT}" x2="{$pos * $spacer}" stroke="green" stroke-width="25"/>
    <line x1="{$pos * $spacer+30}" y2="0" y1="{$countSpeakers * $spacerHEIGHT}" x2="{$pos * $spacer+30}" stroke="purple" stroke-width="25"/>
    <text x="{$pos * $spacer +15}" y="20" style ="writing-mode: tb; glyph-orientation-verical:o">{$sectionTitle}</text>
    return
</g>
}
    
</g>
</svg> 
;

let $filename := "XqueryTest_SVG_Result.svg"
let $doc-db-uri := xmldb:store("/db/sao5303/",$filename, $ThisFileContent)
return $doc-db-uri 
