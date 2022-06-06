xquery version "3.1";
declare variable $ySpacer := 10;
declare variable $xSpacer := 30;

<svg width="1000" height="1000">
<g transform="translate(30, 600)">

{
let $ac := doc('/db/assassinsCreed/assassinscreedodyssey.xml')/script
let $sections := $ac/*
for $s at $pos in $sections
let $spkCount := $s//speaker ! normalize-space() => distinct-values() => count()
let $actions := $s//action => count()
return 
    (: concat($spks, ": ", $actions ):)
<g>
    <line x1="{$pos * $xSpacer}" x2="{$pos * $xSpacer}" y1="0" y2="-{$actions * $ySpacer}" stroke="purple" stroke-width="20"/>
    <line x1="{$pos * $xSpacer}" x2="{$pos * $xSpacer}" y1="0" y2="-{$spkCount * $ySpacer}" sroke="orange" stroke-width="20"/>
    <line x1="0" x2="0" y1="5" y2="-410" color="black" stroke="black" stroke-width="3"/>
    <line x1="0" x2="1000" y1="5" y2="5" color="black" stroke="black" stroke-width="3"/>
    <text x="-30" y="-425" font-size="20">Actions</text>
    <text x="400" y="30" font-size="20">Chapters</text>
    <text font-size="20" x="-30" y="5" font-weight="bold">0</text>
    <text font-size="20" x="-30" y="-100" font-weight="bold">10</text>
    <text font-size="20" x="-30" y="-200" font-weight="bold">20</text>
    <text font-size="20" x="-30" y="-300" font-weight="bold">30</text>
    <text font-size="20" x="-30" y="-400" font-weight="bold">40</text>
    <text font-size="20" x="25" y="30" font-weight="bold">1</text>
    <text font-size="20" x="860" y="30" font-weight="bold">29</text>
</g>
}
</g>
</svg>