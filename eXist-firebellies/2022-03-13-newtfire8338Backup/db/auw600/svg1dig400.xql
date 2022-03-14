xquery version "3.1";
declare variable $banksyColl := collection('/db/Assignments/banksyForSVG/');
declare variable $timelineSpacer := 100;
declare variable $radiusSpacer := 10;
declare variable $dates := $banksyColl//sourceDesc//date/@when ! string();
declare variable $years := $dates ! tokenize(., '-')[1] ! xs:integer(.);
declare variable $minYear := $years => min();
declare variable $maxYear := $years => max();
declare variable $titles := $banksyColl//bibl/title ! string();
  
 declare variable $ThisFileContent := 
<svg width="2000" height="3000">
   <g transform="translate(30, 30)">
      <line x1="100" y1="0" x2="100" y2="{($maxYear - $minYear) * $timelineSpacer}" stroke="orange" stroke-width="3"/>  
      
{
      for $y in $years 
      let $matchWorks := $banksyColl//sourceDesc/bibl[date/@when ! matches (., $y)]/title
          let $countWorks := $matchWorks => count()
          
          let $workTitles := $banksyColl//sourceDesc/bibl[date/@when ! matches (., $y)]/title ! string() => distinct-values() => sort()
          let $joinTitles := string-join($workTitles, '; ')
      return 
          
  <g class="yeardata">       
  
   <circle cx="100" cy="{($y - $minYear) * $timelineSpacer}" r="{(math:sqrt ($countWorks  * $countWorks div math:pi())) * $radiusSpacer}" fill="pink"/>
          <text x="120" y="{($y - $minYear) * $timelineSpacer}">{$y}</text>
  
   
  </g>
}
      
   </g>
</svg>;

 let $filename := "svgdig400.svg"
let $doc-db-uri := xmldb:store("/db/auw600", $filename, $ThisFileContent)
return $doc-db-uri
(: Output at http://newtfire.org:8338/exist/rest/db/auw600/svgdig400.svg :)     