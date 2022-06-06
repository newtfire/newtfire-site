xquery version "3.1";
declare variable $banksyColl := collection('/db/Assignments/banksyForSVG/');
declare variable $timelineSpacer := 100;
declare variable $dates := $banksyColl//sourceDesc//date/@when ! string();
declare variable $years := $dates ! tokenize(., '-')[1] ! xs:integer(.);
declare variable $minYear := $years => min();
declare variable $maxYear := $years => max();
  
 declare variable $ThisFileContent := 
<svg width="100%" height="2000">
   <g transform="translate(30, 30)">
  <line x1="250" y1="0" x2="250" y2="{($maxYear - $minYear) * $timelineSpacer}" stroke="purple" stroke-width="3"/>  
      
      {$minYear}

      
   </g>
</svg>;

 $ThisFileContent   

