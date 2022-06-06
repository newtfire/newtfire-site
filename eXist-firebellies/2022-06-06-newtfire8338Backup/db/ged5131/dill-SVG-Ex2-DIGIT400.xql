xquery version "3.1";
declare variable $banksyColl := collection('/db/Assignments/banksyForSVG/');
declare variable $timelineSpacer := 80;
declare variable $circleSpacer := 8;

declare variable $dates := $banksyColl//sourceDesc//date/@when ! string();
declare variable $years := $dates ! tokenize(., '-')[1] ! xs:integer(.);
declare variable $minYear := $years => min();
declare variable $maxYear := $years => max();
declare variable $ThisFileContent := 
<svg width="2000" height="3000">
   <g transform="translate(30, 30)">
      <line x1="100" y1="0" x2="100" y2="{($maxYear - $minYear) *$timelineSpacer}" stroke="purple" stroke-width="3"/>  
       {
      for $y in $years
      let $matchWorks := $banksyColl//sourceDesc/bibl[date/@when ! matches (., $y)]/title 
      let $titles :=$banksyColl//sourceDesc/bibl[date/@when ! matches (., $y)]/title ! string()=> distinct-values() => sort()
      let $joinTitles := string-join ($titles, "---")
      let $countWorks := $matchWorks => count()
      let $medCanvas := $banksyColl//sourceDesc/bibl[date/@when ! matches (., $y)]/title[following-sibling::medium[@type = "canvas"]] 
      let $medPaint := $banksyColl//sourceDesc/bibl[date/@when ! matches (., $y)]/title[following-sibling::medium[@type = "spray_paint"]] 
      let $countCanvas := $medCanvas => count()
      let $countPaint := $medPaint => count()
      return 
 <g class="yeardata">         
   <circle cx="100" cy="{($y - $minYear) * $timelineSpacer}" r="{math:sqrt($countWorks * $countWorks div math:pi()) * $circleSpacer}" fill="green"/>
  <text x="175" y="{($y - $minYear) * $timelineSpacer}" fill="green">{$y}</text>
  <text x="220" y="{($y - $minYear) * $timelineSpacer}" fill="green">{$joinTitles}</text>
  <rect x="250" y="{($y - $minYear) * $timelineSpacer+ 10}" width="{$countCanvas * $circleSpacer}" height="30" fill="#FF8B3D"/>
  <rect x="{250 + $countCanvas * $circleSpacer}" y="{($y - $minYear) * $timelineSpacer + 10}" width="{$countPaint  * $circleSpacer}" height="30" fill="blue"/>
  </g>
}
      
   </g>
</svg>;
(:  :$ThisFileContent:)
let $filename := "dill-SVG-EX2-timeline.svg"
let $doc-db-uri := xmldb:store("/db/ged5131/", $filename, $ThisFileContent)
return $doc-db-uri 
