xquery version "3.1";
declare variable $btrees := collection('/db/btrees')/*;
declare variable $entries := $btrees//entry;
declare variable $trees := $entries => count();
declare variable $avg:= $entries//height/@avg;
declare variable $cnames := $entries/cname ! data();
declare variable $barSpacer := 150;
declare variable $nameSpacer := 160;
declare variable $lBase := 20;
declare variable $tBase := 20;
declare variable $xBase := 175;
<svg width="{80 * $barSpacer}" height="1000">
<g transform="translate(50, 300)">

<line x1="100" y1 ="0" x2="{$xBase * $trees}" y2 ="0" stroke="black"/> 
<line x1="100" y1 ="0" x2="100" y2 ="-{150 * 2}" stroke="black"/> 

    { for $i in (0 to 15)
    return 
    
        <g>
           <line x1="96" y1 ="-{$i * $tBase - 5}" x2="106" y2 ="-{$i * $tBase - 5}" stroke="black"/> 
           <text x="70" y ="-{$i * $tBase}">{($i * $lBase div 2 + 10)}</text> 
        </g>
    }
    h89
    {
     for $e at $pos in $entries
     let $height := $e/height/@avg ! number(.)
     let $cname := $e/cname ! string()
     return
      <g class="treebars">  
       <line x1="{$barSpacer * $pos}" y1 ="-{$height *2}" x2="{$barSpacer * $pos}" y2 ="0" stroke="#46644e" stroke-width="30"/> 
       <text x="{$barSpacer * $pos - 12}" y="15" >{$height} ft.</text>
       <text x="{10}" y="{$barSpacer * $pos -20}" transform="rotate(-90, 0, 0)">{$cname}</text>
       <line x1="{($barSpacer * $pos) + 75}" y1 ="10" x2="{($barSpacer * $pos) + 75}" y2 ="-10" stroke="black"/> 
       
    </g>                                        
    
    }
        <text x="400" y="50">Common Names</text> 
        <text x="0" y="-150">Height (ft)</text> 
        
</g>
    </svg> 

    

    
    