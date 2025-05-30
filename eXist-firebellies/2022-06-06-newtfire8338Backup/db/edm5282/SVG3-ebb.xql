xquery version "3.1";
declare variable $ySpacer := 1;
(: ebb: Your y values on the graph were climbing far above the y axis, so really I think you 
 : want this plot to be a 1 to 1 count: no multiplication needed on the y.
 : Down below, your graph could use some labels for the section numbers (below the x axis) and
 : maybe give the exact count above or on each bar? 
 :    :)
declare variable $xSpacer := 50;

<svg width="1300" height="6000">
<g transform="translate(-1350, 150)">
{
let $creed := doc('/db/assassinsCreed/assassinscreedodyssey.xml')/script
let $sections := $creed/*
for $c at $pos in $sections
    let $chapNum := $c//chapterNum ! normalize-space() => distinct-values() => count()
    let $speaker := $c//speaker => count()

return 
    
<g transform="rotate(180, 750 180) scale(-0.8, 0.8)">
    <polygon points="{$pos * $xSpacer - 5}, {$chapNum * $ySpacer} {$pos * $xSpacer - 5 + 12}, {$chapNum * $ySpacer + 8} {$pos * $xSpacer - 5 + 12 + 14}, {$chapNum * $ySpacer + 8} {$pos * $xSpacer - 5 + 14}, {$chapNum * $ySpacer}" fill="rgb(230, 0, 0)" stroke="black"/>
    <polygon points="{$pos * $xSpacer - 5 + 14}, 0 {$pos * $xSpacer - 5 + 14}, {$chapNum * $ySpacer} {$pos * $xSpacer - 5 + 12 + 14}, {$chapNum * $ySpacer + 8} {$pos * $xSpacer - 5 + 12 + 14}, 0" stro="black" fill="rgb(102, 0, 0)"/>
    <polygon points="{18 + $pos * $xSpacer - 5 + 14}, 0 {18 + $pos * $xSpacer - 5 + 14}, {$speaker * $ySpacer} {18 + $pos * $xSpacer - 5 + 12 +14}, {$speaker * $ySpacer + 8} {18 + $pos * $xSpacer - 5 + 12 +14} , 0" stroke="black" fill="rgb(0, 38, 153)"/>
    <rect x="{$pos * $xSpacer - 5}" y="0" width="14" height="{$chapNum * $ySpacer}" fill="rgb(255, 77, 77)" stroke="black"/>
    <rect x="{18 + $pos * $xSpacer - 5}" y="0" width="14" height="{$speaker * $ySpacer}" fill="rgb(0, 102, 255)" stroke="black"/>
    <polygon points="{18 + $pos * $xSpacer - 5}, {$speaker * $ySpacer} {18 + $pos * $xSpacer - 5 + 12}, {$speaker * $ySpacer + 8} {18 + $pos * $xSpacer - 5 + 12 +14}, {$speaker * $ySpacer + 8} {18 + $pos *  $xSpacer - 5 + 14}, {$speaker * $ySpacer}" fill="rgb(0, 82, 204)" stroke="black"/>
    <line x1="10" x2="1510" y1="-20" y2="-20" stroke-width="5" stroke="black"/>
    <line x1="10" x2="10" y1="-22" y2="400" stroke-width="5" stroke="black"/>
    <line x1="{$pos * $xSpacer + 14}" x2="{$pos * $xSpacer + 14}" y1="-28" y2="-12" stroke-width="5" stroke="black"/>
    <text transform="rotate(180) scale(-0.8, 0.8)" font-size="40" x="850" y="80" font-weight="bold">Sections</text>
    <text transform="rotate(180) scale(-0.8, 0.8)" font-size="40" x="-236" y="-300" font-weight="bold">Speakers</text>
    <text transform="rotate(180) scale(-0.8, 0.8)" font-size="40" x="-210" y="-200" font-weight="bold">Actions</text>
    <rect x="-55" y="240" width="20" height="20" fill="rgb(230, 0, 0)" stroke="black" stroke-width="2"/>
    <rect x="-55" y="160" width="20" height="20" fill="rgb(0, 82, 204)" stroke="black" stroke-width="2"/>
    <line x1="0" x2="20" y1="0" y2="0" stroke-width="5" stroke="black"/>
    <line x1="0" x2="20" y1="100" y2="100" stroke-width="5" stroke="black"/>
    <line x1="0" x2="20" y1="200" y2="200" stroke-width="5" stroke="black"/>
    <line x1="0" x2="20" y1="300" y2="300" stroke-width="5" stroke="black"/>
    <line x1="0" x2="20" y1="400" y2="400" stroke-width="5" stroke="black"/>
    <text transform="rotate(180) scale(-0.8, 0.8)" font-size="25" x="-20" y="5" font-weight="bold">0</text>
    <text transform="rotate(180) scale(-0.8, 0.8)" font-size="25" x="-28" y="-116" font-weight="bold">10</text>
    <text transform="rotate(180) scale(-0.8, 0.8)" font-size="25" x="-28" y="-242" font-weight="bold">20</text>
    <text transform="rotate(180) scale(-0.8, 0.8)" font-size="25" x="-28" y="-365" font-weight="bold">30</text>
    <text transform="rotate(180) scale(-0.8, 0.8)" font-size="25" x="-28" y="-490" font-weight="bold">40</text>
</g>
}
</g>
</svg>
