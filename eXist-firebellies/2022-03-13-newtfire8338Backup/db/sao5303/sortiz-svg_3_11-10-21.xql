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
    <line x1="{$i * $xSpacer}" x2="{$i * $xSpacer}" y1="0" y2="{5 * $ySpacer}" stroke="green" stroke-width="1" stroke-dasharray="5"/>
}

{for $i in (0 to 5)
return
  <g>    
    <line x1="0" x2="{$cycles * $xSpacer}" y1="{$i * $ySpacer}" y2="{$i * $ySpacer}" stroke="green" stroke-width="1" stroke-dasharray="5"/>
    <text x="-40" y="{$i * $ySpacer + 5}">{$i * 100}</text>
   </g>
}

{for $e at $pos in $elections
    let $year := $e/@year ! xs:integer(.)
    let $candidates := $e/candidate 
    
    
    let $repub:= $e/@Republican ! string()
    let $demo:= $e/@Democratic ! string()
    let $soci:= $e/@Socialist ! string()
    let $progres:= $e/@Progressive ! string()
    
    return 
        
    <g id="year-{$year}">
        <text x="{$pos * $xSpacer}" y="20" stroke="black">{$year}</text>
        
        <circle x="{$pos * $xSpacer}" y="20" r="10" stroke="black" fill="red"></circle>
        <circle x="{$pos * $xSpacer}" y="10" r="10" stroke="black" fill="blue"></circle>
        
        <text x="{$pos * $xSpacer}" y="10" stroke="black">{$soci}</text>

    </g>
}

 </g>
</svg>
;
$ThisFileContent
