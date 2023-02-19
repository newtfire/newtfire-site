xquery version "3.1";
declare variable $banksyColl := collection('/db/Assignments/banksyForSVG/');
declare variable $timelineSpacer := 10;
declare variable $dates := $banksyColl//sourceDesc//date/@when ! string();
declare variable $years := $dates ! tokenize(., '-')[1] ! xs:integer(.);
declare variable $minYear := $years => min();
declare variable $maxYear := $years => max();

  
 declare variable $ThisFileContent := 
<svg width="500" height="3000">
   <g transform="translate(30, 30)">
      <line x1="100" y1="0" x2="100" y2="{($maxYear - $minYear) * $timelineSpacer}" stroke="purple" stroke-width="3"/>  
      
      {
          for $y in $years
          return
              
    <circle cx="100" cy="{($y - $minYear) * $timelineSpacer}" r="10" fill="green" stroke=""/>

}

      
   </g>
</svg>;

 $ThisFileContent   

