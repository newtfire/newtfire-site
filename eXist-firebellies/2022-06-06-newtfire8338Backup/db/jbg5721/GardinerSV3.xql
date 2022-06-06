xquery version "3.1";
declare variable $ySpacer := 0.5;
declare variable $xSpacer := 80;

<svg width="1000" height="1000">
<g transform="translate(30, 600)">

{
let $ac := collection('/db/starwars/')
let $sections := $ac/*
for $s at $pos in $sections
let $sp := $s//sp ! normalize-space() => distinct-values() => count()
let $actions := $s//scene[@n] => count()
return 
    (: concat($spks, ": ", $actions ):)
<g>
    <line x1="{$pos * $xSpacer + 30}" x2="{$pos * $xSpacer + 30}" y1="0" y2="-{$actions * $ySpacer}" stroke="yellow" stroke-width="25"/> 
    <line x1="{$pos * $xSpacer}" x2="{$pos * $xSpacer}" y1="0" y2="-{$sp * $ySpacer}" stroke="#6f6f6f" stroke-width="25"/>
    <text x="{$pos * $xSpacer - 10}" y="-{$sp * $ySpacer - 20}" fill="#e0e0e0" font-size="14">{$sp}</text>
    <text x="{$pos * $xSpacer + 21}" y="-{$actions * $ySpacer - 20}" fill="#2d6d86" font-size="14">{$actions}</text>
        
    </g>
   
    
}
<polygon points="90,-505 60,-535 90,-565 570,-565 600,-535 570,-505 " style="fill:#202020;" />
<text x="90" y="-520" fill="yellow" font-size="50">Star Wars: A New Hope</text>

<polygon points="550,-460 550,-340 690,-340 690,-460" style="fill:#202020;" />
<text x="570" y="-430" fill="yellow" font-size="30">Legend:</text>
<text x="600" y="-400" fill="yellow" font-size="15">= Speakers</text>
<polygon points="560,-420 560,-390 595,-390 595,-420" style="fill:#6f6f6f;" />
<text x="600" y="-360" fill="yellow" font-size="15">= Scenes</text>
<polygon points="560,-350 560,-380 595,-380 595,-350" style="fill:yellow;" />

<line x1="50" y1="0" x2="500" y2="0" style="stroke:#000;stroke-width:4" />
<line x1="51" y1="0" x2="51" y2="-500" style="stroke:#000;stroke-width:4" />

<text x="200" y="40" fill="#626262" font-size="30">Drafts</text>
<text x="42" y="-50" fill="#626262" font-size="30" transform="rotate(270 42,-50)">Amount</text>
</g>
</svg>
