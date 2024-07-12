xquery version "3.1";
 
<svg width="100%" height="100%">
<g transform="translate(500,100)">
    {
    let $btrees := doc('/db/btrees/btrees_tree_book.xml')/*
    let $entries := $btrees/entry
    
    for $e at $pos in $entries
    let $cname := $e/cname ! text()
    let $height := $e/height/@avg ! number(.)
    order by $height descending
    return 
        
            <circle r="{$height div 5}" x="0" y="{-$pos * 10}" fill="rgb({$height*0.01}, 149, 237)"/>

       
    }
 </g>
</svg>