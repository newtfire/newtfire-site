xquery version "3.1";
declare variable $ySpacer := 10;
declare variable $xSpacer := 30;
declare variable $xLegend := 20;
declare variable $yLegend := 20;

<svg width="1000" height="1000">
<g transform="translate(30, 600)">

{
let $ac := doc('/db/assassinsCreed/assassinscreedodyssey.xml')/script
let $sections := $ac/*
for $s at $pos in $sections
let $spks := $s//speaker ! normalize-space() => distinct-values() => count()
let $actions := $s//action => count()
return 
    (: concat($spks, ": ", $actions ):)
<g>
    <line x1="{$pos * $xSpacer}" x2="{$pos * $xSpacer}" y1="0" y2="-{$actions * $ySpacer}" stroke="green" stroke-width="10"/>
     <line x1="{$pos * $xSpacer + 12}" x2="{$pos * $xSpacer +12}" y1="0" y2="-{$spks * $ySpacer}" stroke="red" stroke-width="10"/>
     <line x1="10" x2="1000" y1="0" y2="0" stroke="black"></line>
     <line x1="10" x2="10" y1="0" y2="-600" stroke="black"></line>
     <text x="400" y="-550" font-size="35">Assasins Creed</text>
     <text x="-10" y="-{5 *$ySpacer}">5</text>
     <text x="-10" y="-{10 *$ySpacer}">10</text>
     <text x="-10" y="-{15 *$ySpacer}">15</text>
     <text x="-10" y="-{20 *$ySpacer}">20</text>
     <text x="-10" y="-{25 *$ySpacer}">25</text>
     <text x="-10" y="-{30 *$ySpacer}">30</text>
     <text x="-10" y="-{35 *$ySpacer}">35</text>
     <text x="-10" y="-{40 *$ySpacer}">40</text>
     <text x="-25"y="-{35 *$ySpacer}" style="writing-mode: tb; glyph-orientation-vertical: 0;"># OF TIMES</text>
     <rect x="70" y="40" height="100" width="120" fill="white" stroke="Black"></rect>
      <rect x="80" y="100" height="20" width="20" outline="black"/>
     <rect x="80" y="60" height="20" width="20" fill="green"/>
     <rect x="80" y="100" height="20" width="20" fill="red"/>
     <text x="120" y="70" stroke="black">Actions</text>
     <text x="120" y="120" stroke="black">Speakers</text>
    </g>
}
</g>
</svg>