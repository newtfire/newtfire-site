xquery version "3.1";
declare variable $banksyColl := collection('/db/Assignments/banksyForSVG/');
    declare variable $timelineSpacer := 150;
    declare variable $radiusSpacer := 10;
    declare variable $dates := $banksyColl//sourceDesc//date//@when ! string();
    declare variable $years := $dates ! tokenize(., '-')[1] ! xs:integer(.);
    declare variable $minYear := $years => min();
    declare variable $maxYear := $years => max();
    declare variable $titles := $banksyColl//bibl/title ! string();

declare variable $ThisFileContent := 
<svg width="2000" height="3000">
   <g transform="translate(30, 30)">
      <line x1="50" y1="0" x2="50" y2="{($maxYear - $minYear) * $timelineSpacer}" stroke="purple" stroke-width="3"/>  
      
      {
          for $y in $years
          
          let $matchWorks := $banksyColl//sourceDesc/bibl[date/@when ! matches (., $y)]/title
          let $countWorks := $matchWorks => count()
          
          let $workTitles := $banksyColl//sourceDesc/bibl[date/@when ! matches (., $y)]/title ! string() => distinct-values() => sort()
          let $joinTitles := string-join($workTitles, '; ')
          
          let $medCanvas := $banksyColl//sourceDesc/bibl[date/@when ! matches (., $y)]/title[following-sibling::medium[@type = "canvas"]] 
          let $medPaint := $banksyColl//sourceDesc/bibl[date/@when ! matches (., $y)]/title[following-sibling::medium[@type = "spray_paint"]] 
          let $countCanvas := $medCanvas => count()
          let $countPaint := $medPaint => count()
          return 
              
          <g class="year">    
              <circle cx="50" cy="{($y - $minYear) * $timelineSpacer}" r="{(math:sqrt ($countWorks  * $countWorks div math:pi())) * $radiusSpacer}" fill="chartreuse"/>
              <text x="130" y="{($y - $minYear + .05) * $timelineSpacer}" fill="black">{$y}</text>
              <text x="210" y="{($y - $minYear + .05) * $timelineSpacer}" fill="black">{$joinTitles}</text>
              
              <rect x="250" y="{($y - $minYear) * $timelineSpacer+ 50}" width="{$countCanvas * $radiusSpacer}" height="30" fill="#FF8B3D"/>
              <rect x="{250 + $countCanvas * $radiusSpacer}" y="{($y - $minYear) * $timelineSpacer + 50}" width="{$countPaint  * $radiusSpacer}" height="30" fill="teal"/>
            </g>
      }
      
   </g>
</svg>;

let $filename := "Murry-SVG-Ex2-Timeline.svg"
let $doc-db-uri := xmldb:store("/db/ajm7408/FA2021", $filename, $ThisFileContent)
return $doc-db-uri
(: View this SVG at http://newtfire.org:8338/exist/rest/db/ajm7408/FA2021/Murry-SVG-Ex2-Timeline.svg :)
