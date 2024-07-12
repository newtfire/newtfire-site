xquery version "3.1";
declare variable $btrees := doc('/db/btrees/btrees_tree_book.xml')/*;
declare variable $maxHeight := $btrees//height/@avg => max();
declare variable $minHeight := $btrees//height/@avg => min();
declare variable $xSpace := 10;
declare variable $ySpace := 10;
declare variable $countEntries := $btrees//entry => count();

<svg width="{$xSpace * $maxHeight + 100}" height="{$countEntries * $ySpace + 500}">
<g transform="translate(50, 50)">
{

let $entries := $btrees/entry[child::cname[not(matches(., '\d'))]] 
let $sortedEntries := 
       for $e in $entries
       let $height := $e/height/@avg ! number(.)
       order by $height descending
       return $e
       
(: Let us write a for-loop over the entries :)

for $s at $pos in $sortedEntries
let $cname := $s/cname ! text()
let $height := $s/height/@avg ! number(.)

return
   
    
 <g class="tree" id="position-{$pos}">
      <line id="{$cname}" x1="0" x2="{$height * $xSpace}" y1="{$pos * $ySpace}" y2="{$pos * $ySpace}" stroke-width="{$ySpace}" stroke="blue"/> 
</g>
}
</g>
</svg>  


