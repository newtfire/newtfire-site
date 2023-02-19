xquery version "3.1";
(: ebb: I'm adding the SVG namespace to this to make the output be viewable in the browser as a graphic. So, I'm adding the Q{} for the qualified name to reach into the non-SVG elements in your source. :)
declare variable $index := doc('/db/mayan/sitesIndex.xml');
declare variable $sites := $index//Q{}mayanSites/Q{}site;
declare variable $timelineSpacer := 2;
declare variable $x-spacer := 20;
declare variable $dates := $sites//Q{}dateActive[not(.//@phase)]/@* ! xs:integer(.);

declare variable $minYear := $dates => min();
declare variable $maxYear := $dates => max();

declare variable $year0 := 0;

declare variable $MidPreClasStrt := -1000;
declare variable $MidPreClasEnd := -300;

declare variable $LatePreClasStrt := -300;
declare variable $LatePreClasEnd := 250;

declare variable $classicPeriodStrt := 250;
declare variable $classicPeriodEnd := 900;

declare variable $EarlyClassicStrt := 250;
declare variable $EarlyClassicEnd := 600;

declare variable $LateClassicStrt := 600;
declare variable $LateClassicEnd := 900;

declare variable $PostClassicStrt := 900;
declare variable $PostClassicEnd := 1521;
  
 declare variable $ThisFileContent := 
<svg xmlns="http://www.w3.org/2000/svg" width="2000" height="1000">
   <g transform="translate(30, 100) rotate(270 250 50)">
    <text style="writing-mode: tb;" x="75" y="-35">{tokenize($minYear, '-')} B.C.</text>
        <text style="writing-mode: tb;" x="85" y="{($maxYear - $minYear) - 35}">{$maxYear} A.D.</text>
         <text style="writing-mode: tb;" x="290" y="{($maxYear - $minYear) - 1600}">MaxYear - MinYear = {$maxYear - $minYear}</text>
      <line class="timeline" x1="100" y1="0" x2="100" y2="{($maxYear - $minYear)}" stroke="purple" stroke-width="3"/> 
      <circle class="year0" cx="100" cy="{$minYear + 800}" r="10" fill="gold"/>
      <text style="writing-mode: tb;" class="year0" x="100" y="{$minYear + 796}">0</text>
      
      <line class="timePeriodStart" x1="30" y1="{$MidPreClasStrt + 400}" x2="30" y2="{$MidPreClasEnd + 400}" stroke-width="5" stroke="#008060"/>
      <text style="writing-mode: tb;" x="15" y="{$MidPreClasEnd + $MidPreClasStrt + 1190}">Middle Preclassic</text>
      <text style="writing-mode: tb;" x="20" y="{$MidPreClasStrt + 380}">{tokenize($MidPreClasStrt, '-')} B.C.</text>
      <!--<text style="writing-mode: tb;" x="50" y="{$LatePreClasEnd + 380}">{$LatePreClasEnd}A.D.</text>-->
      <line class="periodEndHash" x1="30"  x2="100" y1="{$MidPreClasEnd + 400}" stroke="#008060" y2="{$MidPreClasEnd + 400}" stroke-width="5"/>
      <line class="periodStartHash" x1="30"  x2="100" y1="{$MidPreClasStrt + 400}" stroke="#008060" y2="{$MidPreClasStrt + 400}" stroke-width="5"/>
      
      <line class="timePeriodStart" x1="60" y1="{$LatePreClasStrt + 400}" x2="60" y2="{$LatePreClasEnd + 400}" stroke-width="5" stroke="#80ffdf"/>
      <text style="writing-mode: tb;" x="45" y="{$LatePreClasEnd + $LatePreClasStrt + 360}">Late Preclassic</text>
      <text style="writing-mode: tb;" x="15" y="{$LatePreClasStrt + 380}">{tokenize($LatePreClasStrt, '-')} B.C.</text>
      <!--<text style="writing-mode: tb;" x="50" y="{$LatePreClasEnd + 380}">{$LatePreClasEnd}A.D.</text>-->
      <line class="periodEndHash" x1="60"  x2="100" y1="{$LatePreClasEnd + 400}" stroke="#80ffdf" y2="{$LatePreClasEnd + 400}" stroke-width="5"/>
      <line class="periodStartHash" x1="60"  x2="100" y1="{$LatePreClasStrt + 400}" stroke="#80ffdf" y2="{$LatePreClasStrt + 400}" stroke-width="5"/>
      
      <line class="timePeriodStart" x1="30" y1="{$EarlyClassicStrt + 400}" x2="30" y2="{$EarlyClassicEnd + 400}" stroke-width="5" stroke="#cc0066"/>
      <text style="writing-mode: tb;" x="15" y="{$EarlyClassicEnd - $EarlyClassicStrt + 420}">Early Classic</text>
      <text style="writing-mode: tb;" x="15" y="{$EarlyClassicStrt + 380}">{$EarlyClassicStrt} A.D.</text>
      <text style="writing-mode: tb;" x="15" y="{$EarlyClassicEnd  + 380}">{$EarlyClassicEnd }A.D.</text>
      <line class="periodEndHash" x1="30"  x2="100" y1="{$EarlyClassicEnd  + 400}" stroke="#cc0066" y2="{$EarlyClassicEnd  + 400}" stroke-width="5"/>
      <line class="periodStartHash" x1="30"  x2="100" y1="{$EarlyClassicStrt + 400}" stroke="#cc0066" y2="{$EarlyClassicStrt + 400}" stroke-width="5"/>
      
      <line class="timePeriodStart" x1="60" y1="{$LateClassicStrt + 400}" x2="60" y2="{$LateClassicEnd + 400}" stroke-width="5" stroke="#ff99cc"/>
      <text style="writing-mode: tb;" x="45" y="{$LateClassicEnd - $LateClassicStrt + 800}">Late Classic</text>
      <line class="periodEndHash" x1="60"  x2="100" y1="{$LateClassicEnd + 400}" stroke="#ff99cc" y2="{$LateClassicEnd + 400}" stroke-width="5"/>
      <line class="periodStartHash" x1="60"  x2="100" y1="{$LateClassicStrt + 400}" stroke="#ff99cc" y2="{$LateClassicStrt + 400}" stroke-width="5"/>
      <text style="writing-mode: tb;" x="15" y="{$LateClassicEnd  + 380}">{$LateClassicEnd }A.D.</text>
      
      <line class="timePeriodStart" x1="30" y1="{$PostClassicStrt + 400}" x2="30" y2="{$PostClassicEnd + 400}" stroke-width="5" stroke="thistle"/>
      <text style="writing-mode: tb;" x="15" y="{$PostClassicEnd - $PostClassicStrt + 820}">Post-Classic</text>
      <line class="periodEndHash" x1="30"  x2="100" y1="{$PostClassicEnd  + 400}" stroke="thistle" y2="{$PostClassicEnd  + 400}" stroke-width="5"/>
      <line class="periodStartHash" x1="30"  x2="100" y1="{$PostClassicStrt + 400}" stroke="thistle" y2="{$PostClassicStrt + 400}" stroke-width="5"/>
      
      {
      for $s at $pos in $sites
      where $s/Q{}dateActive => count() = 1
      (:ebb: I think you were looking for the $pos variable in the XQuery for-loop, which just generates a number for each turn of the loop. :)
      let $yearStartPos := $s/Q{}dateActive[1]/@yearStart ! string() ! xs:integer(.) - $minYear
      let $yearEndPos := $s/Q{}dateActive[1]/@yearEnd ! string() ! xs:integer(.) - $minYear
      let $yearStartPos2 := $s[./Q{}dateActive => count() = 2]/Q{}dateActive[2]/@yearStart ! string() ! xs:integer(.) - $minYear
      let $yearEndPos2 := $s[./Q{}dateActive => count() = 2]/Q{}dateActive[2]/@yearEnd ! string() ! xs:integer(.) - $minYear
      let $siteLineX := 100 + $pos * $x-spacer
      let $color := ("DarkOrange", "Chartreuse", "blue", "teal",  "Turquoise", "MidnightBlue", "MediumSeaGreen", "DarkMagenta", "MediumPurple", "LightSkyBlue")
                    (:"red", "DarkOrange", "DarkMagenta", "Chartreuse", "blue", "teal", "MediumPurple":)
      let $colorCount := count($color)
      
      
      return 
  <g class="yeardata">    
  
   
   <line class="yearStartHash" x1="100"  x2="{$siteLineX}" y1="{$yearStartPos}" stroke="{$color[position() = $pos mod $colorCount + 1]}" stroke-width="2" y2="{$yearStartPos}"/>
   
    <line class="yearEndHash" x1="100"  x2="{$siteLineX}" y1="{$yearEndPos}" stroke="{$color[position() = $pos mod $colorCount + 1]}" y2="{$yearEndPos}" stroke-width="2"/>
    
  <line class="startEndConnector" x1="{$siteLineX}" x2="{$siteLineX}" y1="{$yearStartPos}" y2="{$yearEndPos}" stroke-width="2" stroke="{$color[position() = $pos mod $colorCount + 1]}"/> 
  
   <text class="siteName" style="writing-mode: tb;" fill="black" x="{$siteLineX + 10}" y="{$yearStartPos * 1.25}">{$s[./Q{}dateActive => count() = 1]/Q{}name ! string()}</text>
   <circle class="start" cx="100" cy="{$yearStartPos}" r="8" fill="green"/>
   <circle cx="100" cy="{$yearEndPos}" r="8" fill="blue"/>
   <text class="yearStartDate" x="{$siteLineX * .75}" y="{$yearStartPos}" fill="black">{$s/Q{}dateActive[1]/@yearStart ! data()}</text>
   <text class="yearEndDate" x="{$siteLineX - 25}" y="{$yearEndPos}" fill="black">{$s/Q{}dateActive[1]/@yearEnd ! data()}</text>
  
   </g> }
          <!--<text x="100" y="{($y - $minYear) * $timelineSpacer}">{$y}</text>-->
         
    (: KJ ESPERANZA PHASE LINE :)
    {
        for $s at $pos in $sites
        where $s/Q{}dateActive => count() = 2
        let $yearStartPos := $s/Q{}dateActive[1]/@yearStart ! string() ! xs:integer(.) - $minYear
      let $yearEndPos := $s/Q{}dateActive[1]/@yearEnd ! string() ! xs:integer(.) - $minYear
        let $yearStartPos2 := $s[./Q{}dateActive => count() = 2]/Q{}dateActive[2]/@yearStart ! string() ! xs:integer(.) - $minYear
      let $yearEndPos2 := $s[./Q{}dateActive => count() = 2]/Q{}dateActive[2]/@yearEnd ! string() ! xs:integer(.) - $minYear
      let $siteLineX := 100 + $pos * $x-spacer
      let $color := ("red", "DarkOrange", "HotPink", "Chartreuse", "blue", "teal", "Turquoise")
      let $colorCount := count($color)
    return
        <g>
    
   <line class="yearStartHash" x1="100"  x2="{$siteLineX}" y1="{$yearStartPos2}" stroke="{$color[position() = $pos mod $colorCount + 1]}" stroke-width="2" y2="{$yearStartPos2}"/>
    <line class="yearEndHash" x1="100"  x2="{$siteLineX}" y1="{$yearEndPos2}" stroke="{$color[position() = $pos mod $colorCount + 1]}" y2="{$yearEndPos2}" stroke-width="2"/>
  <line class="startEndConnector" x1="{$siteLineX}" x2="{$siteLineX}" y1="{$yearStartPos2}" y2="{$yearEndPos2}" stroke-width="2" stroke="{$color[position() = $pos mod $colorCount + 1]}"/> -->
  
   <text class="siteName" style="writing-mode: tb;" fill="black" x="{$siteLineX + 10}" y="690">{$s[./Q{}dateActive => count() = 2]/Q{}name ! string()} - Esperanza Phase</text>
   <circle class="start" cx="100" cy="{$yearStartPos2}" r="8" fill="green"/>
   <circle cx="100" cy="{$yearEndPos2}" r="10" fill="blue"/>
   <text fill="black" x="50" y="{$yearStartPos2 + 5}">{$s[./Q{}dateActive => count() = 2]/Q{}dateActive[2]/Q{}dateActive[2]/@yearStart ! string()}</text>
  <text fill="black" x="50" y="{$yearEndPos2 + 5}">{$s[./Q{}dateActive => count() = 2]/Q{}dateActive[2]/Q{}dateActive[2]/@yearEnd ! string()}</text>
   </g>
   
    }
    {
        for $s at $pos in $sites
        where $s/Q{}dateActive => count() = 2
        let $yearStartPos := $s/Q{}dateActive[1]/@yearStart ! string() ! xs:integer(.) - $minYear
      let $yearEndPos := $s/Q{}dateActive[1]/@yearEnd ! string() ! xs:integer(.) - $minYear
        let $yearStartPos2 := $s[./Q{}dateActive => count() = 2]/Q{}dateActive[2]/@yearStart ! string() ! xs:integer(.) - $minYear
      let $yearEndPos2 := $s[./Q{}dateActive => count() = 2]/Q{}dateActive[2]/@yearEnd ! string() ! xs:integer(.) - $minYear
      let $siteLineX := 100 + $pos * $x-spacer
      let $color := ("red", "DarkOrange", "DarkMagenta", "Chartreuse", "blue", "teal", "MediumPurple")
      let $colorCount := count($color)
    return
        <g>
    
   <line class="yearStartHash" x1="100"  x2="{$siteLineX}" y1="{$yearStartPos}" stroke="{$color[position() = $pos mod $colorCount + 1]}" stroke-width="2" y2="{$yearStartPos}"/>
    <line class="yearEndHash" x1="100"  x2="{$siteLineX}" y1="{$yearEndPos}" stroke="{$color[position() = $pos mod $colorCount + 1]}" y2="{$yearEndPos}" stroke-width="2"/>
  <line class="startEndConnector" x1="{$siteLineX}" x2="{$siteLineX}" y1="{$yearStartPos}" y2="{$yearEndPos}" stroke-width="2" stroke="{$color[position() = $pos mod $colorCount + 1]}"/> -->
 <!-- <text fill="black" x="50" y="{$yearStartPos + 5}">{$s[./Q{}dateActive => count() = 2]/Q{}dateActive[1]/@yearStart ! string()}</text>
  <text fill="black" x="50" y="{$yearEndPos + 5}">{$s[./Q{}dateActive => count() = 2]/Q{}dateActive[1]/@yearEnd ! string()}</text> -->
    <text class="siteName" style="writing-mode: tb;" fill="black" x="{$siteLineX + 10}" y="80">{$s[./Q{}dateActive => count() = 2]/Q{}name ! string()} - Miraflores Phase</text>
    <circle class="start" cx="100" cy="{$yearStartPos}" r="8" fill="green"/>
   <circle cx="100" cy="{$yearEndPos2}" r="8" fill="blue"/>
   </g>
   
    }
      
   </g>
</svg>;

let $filename := "SVGmayanSitesActiveTimeline.svg"
let $doc-db-uri := xmldb:store("/db/mayan-queries", $filename, $ThisFileContent)
return $doc-db-uri 
(:  : Output at http://newtfire.org:8338/exist/rest/db/mayan-queries/SVGmayanSitesActiveTimeline.svg :)



