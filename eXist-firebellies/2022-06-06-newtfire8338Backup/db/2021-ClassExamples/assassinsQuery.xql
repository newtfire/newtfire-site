xquery version "3.1";
declare variable $assassinsCreed := doc('/db/assassinsCreed/assassinscreedodyssey.xml');
declare variable $ySpacer :=  30;
declare variable $radiusSpacer := .5;
declare variable $intro := $assassinsCreed//intro;
(: the opening portion :)
declare variable $chapterNums := $assassinsCreed//chapterNum;
(: 28 chapters :)
declare variable $allSegments := ($intro, $chapterNums);
(: This allSegments variable makes a sequence of 29 combining the results of the other two variables :)
(: Remember that you need a semicolon to close a global XQuery variable. :)
declare variable $ThisFileContent :=
<svg width="1000" height="1000">
<!--@width and @height attributes on <svg> create a viewport.  -->
<!-- Inside the XML document portions, use XML comments! --> 
<g transform="translate(50, 200)">
{
for $a at $pos in $allSegments
let $speakers := $a//Q{}speaker
let $distSpeakers := $speakers ! normalize-space() => distinct-values()
let $countSpeakers := $distSpeakers => count()
let $chapTitle := $a//Q{}chapTitles/string()
return
 <g id="chap-{$pos}">
       <circle cy="50" cx="{$ySpacer * $pos}" r="{$countSpeakers * $radiusSpacer}" stroke="red" stroke-width="3" fill="orange" />
       
       <line y1="0" x1="{$ySpacer * $pos}" y2="{$countSpeakers * -10}" x2="{$ySpacer * $pos}" stroke="orange" stroke-width="10" />
         
         <text y="100" x="{$ySpacer * $pos + 5}" fill="indigo" style="writing-mode: tb; glyph-orientation-vertical: 0;">{$chapTitle}</text>

    </g> 
    

}
</g>
</svg>;

let $filename := "AssassinsCreedSpeaking.svg"
let $doc-db-uri := xmldb:store("/db/2021-ClassExamples", $filename, $ThisFileContent, "html")
return $doc-db-uri 
(: Output at http://newtfire.org:8338/exist/rest/db/2021_ClassExamples/AssassinsCreedSpeaking.svg :)  


