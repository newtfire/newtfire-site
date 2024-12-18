xquery version "3.1";
declare variable $banksyColl := collection('/db/Assignments/banksyForSVG/');
declare variable $sourceDesc := $banksyColl//sourceDesc;
declare variable $titles := $sourceDesc//title;
declare variable $medium := $sourceDesc//medium/@type/string();
declare variable $date := $sourceDesc//date/@when/string();
declare variable $minDate := $date => min();
(: minDate is 1999 :)
declare variable $maxDate := $date => max();
(: maxDate is 2018-12-19 :)
declare variable $years := $date ! tokenize(., '-')[1];
declare variable $minYear := $years ! number() => min();
declare variable $maxYear := $years ! number() => max();
declare variable $difference := xs:integer($maxYear) - xs:integer($minYear);
declare variable $timelineSpacer := 100;
declare variable $ThisFileContent := 
<svg width="2000" height="3000">
   <g transform="translate(30, 30)">
          <line x1="0" y1="0" x2="0" y2="{($maxYear - $minYear) * $timelineSpacer}" style="stroke:blue;stroke-width:2;"/>  
        {
         for $i in (0 to $difference)
         let $year := $minYear + $i
         return
          <g>     
            <circle cx="0" cy="{$i * $timelineSpacer}" r="{$countYearTitles * 2}" stroke="purple" stroke-width="3" fill="violet" />
          
       </g>

            }
         </g>
         }       

   </g> 
</svg>;

let $filename := "banksyTimeline.svg"
let $doc-db-uri := xmldb:store("/db/2019_ClassExamples", $filename, $ThisFileContent)
return $doc-db-uri 
(: Output at http://newtfire.org:8338/exist/rest/db/2019_ClassExamples/banksyTimeline.svg :)    
