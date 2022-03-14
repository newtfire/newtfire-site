xquery version "3.1";
declare variable $btrees := collection('/db/dlk5486/')/*;
declare variable $entries := $btrees//Q{}entry[position() < 10];
declare variable $trees := $entries => count();
declare variable $avg:= $entries//height/@avg ! xs:integer(.);
declare variable $cnames := $entries/Q{}cname ! data();
declare variable $barSpacer := 150;
declare variable $nameSpacer := 160;
declare variable $lBase := 20;
declare variable $tBase := 20;
declare variable $xBase := 175;

<svg width="5000" height="500">
<g transform="translate(50, 300)">

<line x1="100" y1 ="0" x2="{$xBase * $trees}" y2 ="0" stroke="black"/> (: X-Axis:)
<line x1="100" y1 ="0" x2="100" y2 ="-{150 * 2}" stroke="black"/> (: Y-Axis:)

    { for $i in (0 to 15)
    return 
    (: for loop for running tallies and bars:)
    
        <g>
           <line x1="96" y1 ="-{$i * $tBase - 5}" x2="106" y2 ="-{$i * $tBase - 5}" stroke="black"/> (:Y tallies:)
           <text x="70" y ="-{$i * $tBase}">{($i * $lBase div 2 + 10)}</text> (:Y labels:)
        </g>
    }
    
    {for $e at $pos in $entries
     let $height := $e/height/@avg ! xs:integer(.)
     let $cname := $e/cname ! string()
     return
      <g class="treebars">  
       <line x1="{$barSpacer * $pos}" y1 ="-{$height *2}" x2="{$barSpacer * $pos}" y2 ="0" stroke="green" stroke-width="30"/> 
       <text x="{$barSpacer * $pos - 12}" y="15" stroke="black">{$height}</text>
       <text x="{10}" y="{$barSpacer * $pos -20}" transform="rotate(-90, 0, 0)">{$cname}</text>
       <line x1="{($barSpacer * $pos) + 75}" y1 ="10" x2="{($barSpacer * $pos) + 75}" y2 ="-10" stroke="black"/> (:Y tallies:)
       
    </g>                                          (: y1 ="{35 + $avg * 2}" > 15 = 150 on the graph :)
    
    }
        <text x="400" y="50">Common Names</text> (: X-Axis Label:)
        <text x="0" y="-150">Height (ft)</text> (: Y-Axis Label:)
        
</g>
    </svg> 
    
    