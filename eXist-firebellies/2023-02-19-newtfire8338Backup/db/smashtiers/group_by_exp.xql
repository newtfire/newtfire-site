xquery version "3.1";
declare variable $banksyColl := collection('/db/Assignments/banksyForSVG/');
declare variable $timelineSpacer := 100;
declare variable $dates := $banksyColl//sourceDesc//date/@when ! string();
declare variable $years := $dates ! tokenize(., '-')[1] ! xs:integer(.);
declare variable $minYear := $years => min();
declare variable $maxYear := $years => max();
declare variable $titles := $banksyColl//sourceDesc//title;
declare variable $bibls := $banksyColl//bibl;
 declare variable $ThisFileContent := 
<svg width="1000" height="2000">
   <g transform="translate(30, 30)">
      <line x1="100" y1="0" x2="100" y2="{($maxYear - $minYear) * $timelineSpacer}" stroke="purple" stroke-width="3"/>  
      {
      
     (:  for $i in( 0 to 10)
       let $year := $minYear + $i
       let $name := $titles ! string() :)
       
       for $b in $bibls
       let $btitle := $b/title ! string()
       let $year := $b/date/@when ! tokenize(., '-')[1] ! xs:integer(.)
       group by $year
       (: group by is a fancy feature of XQuery for loops that effectively matches values from the full sequence that we're
    looping over, based on the variable we set here. So for the current year represented in this $b, group by goes back
    to the $bibls sequence and groups other bibl elements based on whether they share that year. This makes matching other entries based on the year a WHOLE LOT EASIER to write. 
       
       :)
      
      return
          
          
       
        
  <g class="yeardata">        
   <circle cx="100" cy="{($year - $minYear) * $timelineSpacer}" r="10" fill="green"/>
   <text x="55" y="{($year - $minYear) * $timelineSpacer + 5}" fill="black">{$year}</text>
      
   <rect x="100" y="{($year - $minYear) * $timelineSpacer}" width="10" height="10" fill="orange" />
   
       <text x="100" y="{($year - $minYear) * $timelineSpacer}" fill="black">{string-join($btitle, ', ')}</text>  
       <!--This text element is letting us string-join the full sequence of titles from the outer sequence thanks to
       XQuery group by . YAY. This $btitle is no longer JUST the $bTitle for just this one turn of the for loop, Instead,
       it represents a mini-sequence of all titles from the group that share the same year.
       Let's add something to make the text size come out smaller (look this up for SVG text element)
       -->
       
   
  </g>
}
   
     
   </g>
</svg>;
$ThisFileContent
 (:let $filename := "Vangeli_11-5_svg2.svg"
let $doc-db-uri := xmldb:store("/db/apv5182", $filename, $ThisFileContent)
return $doc-db-uri, :)