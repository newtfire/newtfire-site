xquery version "3.1";
declare variable $dataColl := doc('/db/Assignments/electionData/popElectoralData.xml');
declare variable $elections := $dataColl//election;
declare variable $pi := math:pi();
declare variable $years := $elections/@year ! xs:integer(.);
declare variable $cycles := $elections => count();
declare variable $ySpacer := -100;
declare variable $xSpacer := 100;
declare variable $circleSizer := 2;
declare variable $ThisFileContent :=

<svg width="{$cycles * $xSpacer + 100}" height="700" viewBox="0 0 800 900">
    <g transform="translate(50, {$cycles * $xSpacer + 50})">
    
    { for $i in (0 to 5)
    return 
            <g class="hashElectorals">
            <line x1="0" y1="{$i * $ySpacer}" x2="{$cycles * $xSpacer}" y2="{$i * $ySpacer}" stroke="purple" stroke-width="1" stroke-dasharray="2"/>
            <text x="-30" y="{$i * $ySpacer + 5}" stroke="black">{$i * 100}</text>
            </g>
    }
    
    { for $e at $pos in $elections
    let $year := $e/@year ! string()
    let $repubEV := $e/candidate[@party="Republican"]/@electoral_votes ! xs:integer(.)
    let $repubPB := $e/candidate[@party="Republican"]/@popular_percentage ! xs:decimal(.)
    let $demoEV := $e/candidate[@party="Democrat"]/@electoral_votes ! xs:integer(.)
    let $demoPB := $e/candidate[@party="Democrat"]/@popular_percentage ! xs:decimal(.)
    let $progEV := if ($e/candidate[@party="Progressive"])
                    then $e/candidate[@party="Progressive"]/@electoral_votes ! xs:integer(.)
                    else "0"
    let $progPB := if ($e/candidate[@party="Progressive"])
                    then $e/candidate[@party="Progressive"]/@popular_percentage ! xs:decimal(.)
                    else "0"
    let $socialEV := if ($e/candidate[@party="Socialist"])
                    then $e/candidate[@party="Socialist"]/@electoral_votes ! xs:integer(.)
                    else "0"
    let $socialPB := if ($e/candidate[@party="Socialist"])
                    then $e/candidate[@party="Socialist"]/@popular_percentage ! xs:decimal(.)
                    else "0"
    return
    <g class="cycleData">
    <line x1="{$pos * $xSpacer}" y1="0" x2="{$pos * $xSpacer}" y2="-500" stroke="purple" stroke-width="1" stroke-dasharray="2"/>
    <text x="{$pos * $xSpacer}" y="10" stroke="black">{$year}</text>
    {$progEV}
    
    <circle cx="{$years}" cy="{$repubEV}" r="{(math:sqrt ($repubPB * $repubPB div math:pi())) * $circleSizer}" fill="red" opacity=".25"/>
    <circle cx="{$years}" cy="{$demoEV}" r="{(math:sqrt ($demoPB * $demoPB div math:pi())) * $circleSizer}" fill="blue" opacity=".25"/>
    </g>
    }
    
    </g>
</svg> ;


 let $filename := "BubblePlotSVG.svg"
let $doc-db-uri := xmldb:store("/db/auw600", $filename, $ThisFileContent)
return $doc-db-uri
(: Output at http://newtfire.org:8338/exist/rest/db/auw600/BubblePlotSVG.svg :)   