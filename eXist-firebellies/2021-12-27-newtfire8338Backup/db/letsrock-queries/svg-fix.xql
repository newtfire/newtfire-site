xquery version "3.1";

declare variable $rock := collection('/db/letsrock/')/*;
declare variable $stories := $rock//i/@story ! string();
declare variable $Dstories: = $stories => distinct-values();
declare variable $songNum := $rock//sname => distinct-values () => count();
declare variable $spacer := 80;
declare variable $colors := ("peru", "red", "blue", "orange", "crimson", "cyan", "grey", "navy", "gold", "black", "lime", "saddlebrown", "green", "teal", "firebrick", "goldenrod", "gainsboro");


 declare variable $ThisFileContent := 
<svg  width="2000" height="3000">
    <g transform="translate(30, 1000)">
   <line x1="0" y1 ="0" x2="0" y2="-3300" stroke="blue" stroke-width="3"></line>
 
    {
    for $ds at $pos in $Dstories
    
    let $songs := $rock//song
       let $DSongs: = $songs[descendant::i[@story= $ds]]
       let $count := $DSongs ! string-length() 
       let $istories := $DSongs//i[@story=$ds]
       let $stringLengths :=  for $is in $istories
                               let $sl := $is ! string-length()
                               return $sl
        let $sumSL := sum($stringLengths)
       let $DTitle := $DSongs//sname ! string()
    return
        
        <g class="characters">
        
        <text x="{$spacer * $pos}" y="-{$count div 10 + 20}">{$count}</text> (:This rectangle refers to the data reffering to how many lines of xml are in the chart:)
        
        
        <rect x="{$spacer * $pos}" y="-{$count div 5}" width="40" height="{$count div 5}" fill="{$colors[position() = $pos]}"/> (:This rectangle refers to the exide reffering to the amount of story lines:)
        <g class="istorymeasure">
        
       <rect x="{$spacer * $pos}" y="0" width="40" height="{$sumSL}" fill="{$colors[position() = $pos]}" />
        <rect x="{$spacer * $pos}" y="0" width="40" height="{$sumSL}" fill="black" fill-opacity=".50"/>
        </g>
        
        
        (:this text adds xml character count:)
         <text x="{$spacer * $pos +5}" y="-{$count div 5 + 20}">{$count}</text>
        
        
        
        
        <text x="{$spacer * $pos + 40}" y="{-($count div 10 )}" >{$ds}</text> 
       
        </g>
    }
 
  <line x1="0" y1 ="0" x2="{count($Dstories) * $spacer + 50}" y2="0" stroke="red" stroke-width="3"></line>
   
    </g>
</svg>;

(: 
 $ThisFileContent
:)

 let $filename := "LetsRock2FIX.svg"
let $doc-db-uri := xmldb:store("/db/letsrock-queries", $filename, $ThisFileContent)
return $doc-db-uri
