xquery version "3.1";
declare variable $banksyColl := collection('/db/Assignments/banksyForSVG/');
declare variable $timelineSpacer := 100;
declare variable $dates := $banksyColl//sourceDesc//date/@when ! string();
declare variable $years := $dates ! tokenize(., '-')[1] ! xs:integer(.);
declare variable $minYear := $years => min();
declare variable $maxYear := $years => max();
  
 declare variable $ThisFileContent := 
<svg width="1000" height="2000">
   <g transform="translate(30, 30)">
      <line x1="100" y1="0" x2="100" y2="{($maxYear - $minYear)* $timelineSpacer}" stroke="purple" stroke-width="3"/>  
      
      {
      for $y in $years
          
        return
          
    <g class="year">
    <circle cx="100" cy="{($y - $minYear)* $timelineSpacer}" r="10" fill="green"/>
      
    <rect x="100" y="{($y - $minYear)* $timelineSpacer}" width="10" height="10" fill="orange"/>
          
    </g> 
    (:ebb: I can see you're now properly outputting a circle and a rectangle for every line. How about adjusting the dimensions of those shapes based on information in the XML collection? The idea here was: make the area of the circle depend on the count() of artwork generated in the current year ($y). And make the width of a rectangle depend on the count that's a particular medium: spray_paint for example.  :)
      }

      
   </g>
</svg>;

 $ThisFileContent 
