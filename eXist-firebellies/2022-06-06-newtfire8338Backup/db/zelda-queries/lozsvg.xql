xquery version "3.1";
        declare variable $loz := collection('/db/zelda');
        declare variable $oot := doc('/db/zelda/ocarina-of-time.xml');
        declare variable $tp := doc('/db/zelda/twilight_princess.xml');
        declare variable $fsa := doc('/db/zelda/four_swords_adventure.xml');
        declare variable $ySpacer := 10;
        
      
      declare variable $ThisFileContent :=
      <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 2000 1000 " style="background-color: white">
      <g transform="translate(100, 750)">
      {
 for $o at $pos in $oot
 let $oAct := $oot//Q{}act ! normalize-space() => distinct-values()
 let $oActCount := $oAct => count()
 let $oStage := $oot//Q{}stage ! normalize-space() => distinct-values()
 let $oStageCount := $oStage => count()
 let $oCharacter := $oot//Q{}character ! normalize-space() => distinct-values()
 let $oCharacterCount := $oCharacter => count()
 let $oChapter := $oot//Q{}chapter ! normalize-space() => distinct-values()
 let $oChapterCount := $oChapter => count()
 let $oTerm := $oot//Q{}term ! normalize-space() => distinct-values() => sort() 
 let $otCount := $oTerm => count()
 
 for $t at $pos in $tp
 let $tpAct := $tp//Q{}act ! normalize-space() => distinct-values()
 let $tpActCount := $tpAct => count()
 let $tStage := $tp//Q{}stage ! normalize-space() => distinct-values()
 let $tStageCount := $tStage => count()
 let $tCharacter := $tp//Q{}character ! normalize-space() => distinct-values()
 let $tCharacterCount := $tCharacter => count()
 let $tChapter := $tp//Q{}chapter ! normalize-space() => distinct-values()
 let $tChapterCount := $tChapter => count()
 let $tpTerm := $tp//Q{}term ! normalize-space() => distinct-values() => sort() 
 let $tpTermCount := $tpTerm => count()
 
 for $f at $pos in $fsa
 let $fAct := $fsa//Q{}act ! normalize-space() => distinct-values()
 let $fActCount := $fAct => count()
 let $fStage := $fsa//Q{}stage ! normalize-space() => distinct-values()
 let $fStageCount := $fStage => count()
 let $fCharacter := $fsa//Q{}character ! normalize-space() => distinct-values()
 let $fCharacterCount := $fCharacter => count()
 let $fChapter := $fsa//Q{}chapter ! normalize-space() => distinct-values()
 let $fChapterCount := $fChapter => count()
 let $fTerm := $fsa//Q{}term ! normalize-space() => distinct-values() => sort() 
 let $ftCount := $fTerm => count()
 return
     <g>
  
  <rect x="50" width="50" y="-{$tpActCount}" height="{$tpActCount}" fill="blue" stroke="blue"/>
  <rect x="100" width="50" y="-{$oActCount}" height="{$oActCount}" fill="red" stroke="red"/>
  <rect x="150" width="50" y="-{$fActCount}" height="{$fActCount}" fill="green" stroke="green"/>
  <rect x="250" width="50" y="-{$tStageCount}" height="{$tStageCount}" fill="blue" stroke="blue"/>
  <rect x="300" width="50" y="-{$oStageCount}" height="{$oStageCount}" fill="red" stroke="red"/>
  <rect x="350" width="50" y="-{$fStageCount}" height="{$fStageCount}" fill="green" stroke="green"/>
  <rect x="450" width="50" y="-{$tCharacterCount}" height="{$tCharacterCount}" fill="blue" stroke="blue"/>
  <rect x="500" width="50" y="-{$oCharacterCount}" height="{$oCharacterCount}" fill="red" stroke="red"/>
  <rect x="550" width="50" y="-{$fCharacterCount}" height="{$fCharacterCount}" fill="green" stroke="green"/>
  <rect x="650" width="50" y="-{$tChapterCount}" height="{$tChapterCount}" fill="blue" stroke="blue"/>
  <rect x="700" width="50" y="-{$oChapterCount}" height="{$oChapterCount}" fill="red" stroke="red"/>
  <rect x="750" width="50" y="-{$fChapterCount}" height="{$fChapterCount}" fill="green" stroke="green"/>
  <rect x="850" width="50" y="-{$tpTermCount}" height="{$tpTermCount}" fill="blue" stroke="blue"/>
  <rect x="900" width="50" y="-{$otCount}" height="{$otCount}" fill="red" stroke="red"/>
  <rect x="950" width="50" y="-{$ftCount}" height="{$ftCount}" fill="green" stroke="green"/>
  <line x1="0" y1="0" x2="0" y2="-600" style="stroke: black;" stroke-width="3"/>
  <line x1="0" y1="0" x2="1050" y2="0" style="stroke: black;" stroke-width="3"/>
 <text x="125" y="30" style="writing-mode: tb; glyph-orientation-vertical: 180; font-size: 24;">Acts</text>
 <text x="75" y="-{$tpActCount + $ySpacer}" style="text-anchor: middle; font-size: 24;">{$tpActCount}</text>
 <text x="125" y="-{$oActCount + $ySpacer}" style="text-anchor: middle; font-size: 24;">{$oActCount}</text>
 <text x="175" y="-{$fActCount + $ySpacer}" style="text-anchor: middle; font-size: 24;">{$fActCount}</text>
 <text x="325" y="30" style="writing-mode: tb; glyph-orientation-vertical: 180; font-size: 24;">Stage Directions</text>
 <text x="325" y="-{$oStageCount + $ySpacer}" style="text-anchor: middle; font-size: 24;">{$oStageCount}</text>
 <text x="275" y="-{$tStageCount + $ySpacer}" style="text-anchor: middle; font-size: 24;">{$tStageCount}</text>
 <text x="375" y="-{$fStageCount + $ySpacer}" style="text-anchor: middle; font-size: 24;">{$fStageCount}</text>
 
 
 <text x="475" y="-{$tCharacterCount + $ySpacer}" style="text-anchor: middle; font-size: 24;">{$tCharacterCount}</text>
 <text x="525" y="-{$oCharacterCount + $ySpacer}" style="text-anchor: middle; font-size: 24;">{$oCharacterCount}</text>
 <text x="575" y="-{$fCharacterCount + $ySpacer}" style="text-anchor: middle; font-size: 24;">{$fCharacterCount}</text>
 
  <text x="675" y="-{$tChapterCount + $ySpacer}" style="text-anchor: middle; font-size: 24;">{$tChapterCount}</text>
 <text x="725" y="-{$oChapterCount + $ySpacer}" style="text-anchor: middle; font-size: 24;">{$oChapterCount}</text>
 <text x="775" y="-{$fChapterCount + $ySpacer}" style="text-anchor: middle; font-size: 24;">{$fChapterCount}</text>
 
   <text x="925" y="-{$otCount + $ySpacer}" style="text-anchor: middle; font-size: 24;">{$otCount}</text>
 <text x="875" y="-{$tpTermCount + $ySpacer}" style="text-anchor: middle; font-size: 24;">{$tpTermCount}</text>
 <text x="975" y="-{$ftCount + $ySpacer}" style="text-anchor: middle; font-size: 24;">{$ftCount}</text>
 
 <text x="525" y="30" style="writing-mode: tb; glyph-orientation-vertical: 180; font-size: 24;">Characters</text>
<text x="725" y="30" style="writing-mode: tb; glyph-orientation-vertical: 180; font-size: 24;">Chapters</text>
<text x="925" y="30" style="writing-mode: tb; glyph-orientation-vertical: 180; font-size: 24;">Items</text>
<text x="525" y="-650" style="text-anchor: middle; font-size: 48;">Legend of Zelda: Gameplay Statistics</text>
<text x="-30" y="-400" style="writing-mode: tb; glyph-orientation-vertical: 180; font-size: 36;">Event Count</text>
<rect x="1100" width="50" y="-600" height="50" fill="blue" stroke="blue"/>
<rect x="1100" width="50" y="-525" height="50" fill="red" stroke="red"/>
<rect x="1100" width="50" y="-450" height="50" fill="green" stroke="green"/>
<text x="1175" y="-570" style=" font-size: 24;">Twilight Princess</text>
<text x="1175" y="-495" style=" font-size: 24;">Ocarina of Time</text>
<text x="1175" y="-425" style=" font-size: 24;">Four Swords Adventures</text>

     </g>     
 }
</g>
</svg>;

let $filename := "loz.svg"
let $doc-db-uri := xmldb:store("/db/zelda-queries/", $filename, $ThisFileContent)
return $doc-db-uri 
(:  View this SVG at http://newtfire.org:8338/exist/rest/db/zelda-queries/loz.svg  :)