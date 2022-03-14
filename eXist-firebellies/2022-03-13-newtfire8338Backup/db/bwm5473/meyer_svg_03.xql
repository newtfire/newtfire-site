xquery version "3.1";
declare variable $dataColl := doc('/db/Assignments/electionData/popElectoralData.xml');
declare variable $elections := $dataColl//election;
declare variable $pi := math:pi();
declare variable $years := $elections/@year ! xs:integer(.);
declare variable $cycles := $elections => count();
declare variable $candidates := $elections/candidate;
declare variable $ySpacer := -100;
declare variable $xSpacer := 100;
declare variable $circleSizer := 2;
declare variable $ThisFileContent :=
<svg width="{$cycles * $xSpacer + 200}" height="600" viewBox="(0,0, 1200, 700)"  >
<g transform="translate(100, 550)">

{for $i in (1 to $cycles)
return
    <line x1="{$i * $xSpacer}" x2="{$i * $xSpacer}" y1="0" y2="{5 * $ySpacer}" stroke="purple" stroke-width="1" stroke-dasharray="5"/>
    
}

{for $i in (0 to 5)
return
  <g>    
    <line x1="0" x2="{$cycles * $xSpacer}" y1="{$i * $ySpacer}" y2="{$i * $ySpacer}" stroke="purple" stroke-width="1" stroke-dasharray="5"/>
    <text x="-40" y="{$i * $ySpacer + 5}">{$i * 100}</text>
   </g>
}

{ for $e at $pos in $elections
    let $year := $e/@year ! xs:integer(.)
    let $candidates := $e/candidate
    let $repubEV := $candidates[@party="Republican"]/@electoral_votes ! xs:decimal(.)
    let $demEV := $candidates[@party="Democrat"]/@electoral_votes ! xs:decimal(.)
    let $progEV := $candidates[@party="Progressive"]/@electoral_votes ! xs:decimal(.)
    let $socEV := $candidates[@party="Socialist"]/@electoral_votes ! xs:decimal(.)
    let $repubPV := $candidates[@party="Republican"]/@popular_percentage ! xs:decimal(.)
    let $demPV := $candidates[@party="Democrat"]/@popular_percentage ! xs:decimal(.)
    let $progPV := if ($candidates[@party="Progressive"])
                   then $candidates[@party="Progressive"]/@popular_percentage ! xs:decimal(.)
                   else 0
    let $progPVtext := if ($candidates[@party="Progressive"])
                      then $candidates[@party="Progressive"]/@popular_percentage ! xs:decimal(.) || "%"
                      else ""
    let $socPV := if ($candidates[@party="Socialist"])
               then $candidates[@party="Socialist"]/@popular_percentage ! xs:decimal(.)
               else 0
    let $socPVtext := if ($candidates[@party="Socialist"])
                      then $candidates[@party="Socialist"]/@popular_percentage ! xs:decimal(.) || "%"
                      else ""
    
    return 
        
    <g id="year-{$year}">
       <text x="{$pos * $xSpacer}" y="20">{$year}</text>
       <circle class="repub" cx="{$pos * $xSpacer}" cy="{-$repubEV}" r="{math:sqrt(math:pi() * $repubPV * $repubPV) div math:pi()}" fill="red"/>
       <text x="{$pos * $xSpacer + 20}" y="{-$repubEV - 10}">{$repubPV}%</text>
       
       <circle class="dem" cx="{$pos * $xSpacer}" cy="{-$demEV}" r="{math:sqrt(math:pi() * $demPV * $demPV) div math:pi()}" fill="blue"/>
       <text x="{$pos * $xSpacer + 20}" y="{-$demEV - 10}">{$demPV}%</text>
       
        <circle class="prog" cx="{$pos * $xSpacer}" cy="{-$progEV}" r="{math:sqrt(math:pi() * $progPV * $progPV) div math:pi() * $circleSizer}" fill="green"/>
       <text x="{$pos * $xSpacer + 20}" y="{-$progEV }">{$progPVtext}</text>
       <circle class="soc" cx="{$pos * $xSpacer}" cy="{-$socEV}" r="{math:sqrt(math:pi() * $socPV * $socPV) div math:pi() * $circleSizer}" fill="goldenrod"/>
       <text x="{$pos * $xSpacer + 10}" y="{-$socEV}">{$socPVtext}</text>


    </g>
}

 </g>
</svg>
;
$ThisFileContent