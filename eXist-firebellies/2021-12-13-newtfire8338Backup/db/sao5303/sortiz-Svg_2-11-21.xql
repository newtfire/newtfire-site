xquery version "3.1";

  declare variable $banksyColl := collection('/db/Assignments/banksyForSVG/');
declare variable $dates := $banksyColl//sourceDesc//date/@when ! string();
declare variable $years := $dates ! tokenize(., '-')[1] ! xs:integer(.);
declare variable $minYear := $years => min();
declare variable $maxYear := $years => max();
declare variable $circleSpacer:= 8;
  declare variable $timelineSpacer := 100;
 
 declare variable $ThisFileContent := 
<svg width="1500" height="2000">
   <g transform="translate(30,30)">
      <line x1="100" y1="0" x2="100" y2="{($maxYear - $minYear) * $timelineSpacer}" stroke="blue" stroke-width="3"/>  
      {
          for $y at $pos in $years
         let $titles :=$banksyColl//sourceDesc/bibl[date/@when ! matches (., $y)]/title ! string()=> distinct-values() => sort()
         let $joinArt := string-join($titles,"---")
        let $works := $banksyColl//sourceDesc/bibl[date/@when ! matches (., $y)]/title 
         let $countWorks:= $works=> count()
         
          return
              
           <g class="yeardata">        
   <circle cx="100" cy="{($y - $minYear) * $timelineSpacer}" r="{math:sqrt($countWorks div math:pi()) *  $circleSpacer +10}" stroke="purple" fill="violet"/>
          
   <rect x="120" y="{($y - $minYear) * $timelineSpacer+10}" width="10" height="10" fill="cyan"/>
   <rect x="140" y="{($y - $minYear) * $timelineSpacer+10}" width="10" height="10" fill="#AED6F1"/>
  
      <text x="120" y="{($y - $minYear) * $timelineSpacer}" stroke="blue">{$y}</text>
      <text x="170" y="{($y - $minYear) * $timelineSpacer}" stroke="blue">{$joinArt}</text>
      (:Im stuck here with the for loops but i tried looking back at prior svg works, so i know to fix the radius of the circles i need to somehow grab the info for the titles and count them up:)
  </g>
}

   </g>
</svg> ;


 $ThisFileContent
 
 (:
 let $filename := "sortiz-svg_ex2_11-05-21.svg"
let $doc-db-uri := xmldb:store("/db/sao5303", $filename, $ThisFileContent)
return $doc-db-uri
 :)