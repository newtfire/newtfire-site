xquery version "3.1";
declare variable $dataColl := doc('/db/Assignments/electionData/popElectoralData.xml');
declare variable $elections := $dataColl//election;
declare variable $pi := math:pi();
declare variable $years := $elections/@year ! xs:integer(.);
declare variable $cycles := $elections => count();
(: I don't want to plot data for every year. I just want one plot per 4-year election cycle. :)
declare variable $ySpacer := -100;
declare variable $xSpacer := 100;
declare variable $circleSizer := 2;
declare variable $ThisFileContent := 
<svg width="{$cycles * $xSpacer + 100}" height="700" viewBox="0 0 800 900">
    <g transform="translate(50, {$cycles * $xSpacer + 50})">
    
    { for $i in (0 to 5)
    return 
       <g class="hashElectorals"> 
        <line x1="0" y1="{$i * $ySpacer}" x2="{$cycles * $xSpacer}" y2="{$i * $ySpacer}" stroke="purple" stroke-width="1" 
        stroke-dasharray="2"/>
        <text x="-15" y="{$i * $ySpacer + 5}" stroke="black">{$i * 100}</text>
       </g> 
    }
    
    
    
    
    </g>
</svg> ;

$ThisFileContent