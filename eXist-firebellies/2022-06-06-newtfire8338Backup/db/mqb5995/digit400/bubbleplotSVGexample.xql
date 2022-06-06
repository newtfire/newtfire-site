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

<!-- dashed-line hashes for years. We have a total of 4 election cycles in our data, so the for loop $i stands for each whole number between 1 and 4: $i will help us draw lines up the screen at positions 1, 2, 3, 4 multiplied by our $xSpacer variable.  -->
{for $i in (1 to $cycles)
return
    <line x1="{$i * $xSpacer}" x2="{$i * $xSpacer}" y1="0" y2="{5 * $ySpacer}" stroke="green" stroke-width="1" stroke-dasharray="5"/>
    
}

<!-- dashed-line hashes on y for electorals. This one makes a hash line for each whole number: 0, 1, 2, 3, 4, 5. -->
{for $i in (0 to 5)
return
  <g>    
    <line x1="0" x2="{$cycles * $xSpacer}" y1="{$i * $ySpacer}" y2="{$i * $ySpacer}" stroke="green" stroke-width="1" stroke-dasharray="5"/>
    <text x="-40" y="{$i * $ySpacer + 5}">{$i}</text>
   </g>
}
<!-- Now, loop through the election data, and for each election year, loop through the candidates. Plot circles at the appropriate y positions, with circle areas calculated based on percentages of popular votes. -->
{ for $e at $pos in $elections
    let $year := $e/@year ! xs:integer(.)
    let $candidates := $e/candidate
    let $repubEV := $e/candidate[@party = "Republican"]/@electoral_votes ! xs:integer(.)
    let $repubPV := $e/candidate[@party = "Republican"]/@popular_percentage ! xs:decimal(.)
    let $progEV := if( $e/candidate[@party="Progressive"])
        then /$e/candidate[@party="Progressive"]/@electoral_votes ! xs:integer(.)
        else "0"
    let $progPV := $e/candidate[@party = "Progressive"]/@popular_percentage ! xs:decimal(.)
    (: Write more variables to reach into the @electoral_votes and @popular_percentage="51.7" data. NOTE: use xs:decimal(.) for the popular percentage data b/c it's not an integer.You're making circles for each political party's results. Give each party's circle a distinct fill color. You plot the circles' radius using the @popular_percentage data (following the Obdurodon tutorial using the math:sqrt() and math:pi() functions). You plot the position of the circles (between 0 and 500) based on the integer provided in @electoral_votes data.:)
    
    (: One sticky point: For values for the political parties who don't appear regularly in each election (Socialist and Progressive), we'll need an "if else" statement to set 0 when the party isn't represented in an election cycle. If we don't do that, apparently our SVG won't plot b/c it'll come out with a null value instead of 0 when we go to plot the circles. So here's how to write that an if-else condition in XQuery:
            let $variable:=
                     if (XPath condition 1) 
                              then some-value-to-store (either XPath or "text") 
                     else "0"      :)
    
    return 
        
    <g id="year-{$year}">
   
        <text x="{$pos * $xSpacer}" y="20" stroke="black">{$year}</text>
        {$repubEV}
            <!--Plot the circles for the parties!  -->
            

    </g>
}

 </g>
</svg>
;
$ThisFileContent
