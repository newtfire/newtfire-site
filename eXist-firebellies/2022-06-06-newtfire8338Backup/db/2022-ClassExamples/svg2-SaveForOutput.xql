xquery version "3.1";
declare variable $ySpacer := 10;
declare variable $xSpacer := 30;
declare variable $ThisFileContent :=
<svg xmlns="http://www.w3.org/2000/svg" width="1000" height="1000">
<g transform="translate(30, 600)">

{
let $ac := doc('/db/assassinsCreed/assassinscreedodyssey.xml')/Q{}script
let $sections := $ac/*
for $s at $pos in $sections
let $spks := $s//Q{}speaker ! normalize-space() => distinct-values() => count()
let $actions := $s//Q{}action => count()
return 
    (: concat($spks, ": ", $actions ):)
<g>
    <line x1="{$pos * $xSpacer}" x2="{$pos * $xSpacer}" y1="0" y2="-{$actions * $ySpacer}" stroke="red" stroke-width="25"/> <line x1="{$pos * $xSpacer}" x2="{$pos * $xSpacer}" y1="0" y2="-{$spks * $ySpacer}" stroke="#e0e0e0" stroke-width="20"/><text x="{$pos * $xSpacer}" y="-{$spks * $ySpacer}" fill="#2d6d86" font-size="14">{$spks}</text>
    <text x="{$pos * $xSpacer}" y="-{$actions * $ySpacer}" fill="#2d6d86" font-size="14">{$actions}</text>
        
    </g>
   
    
}


<polygon points="290,-440 260,-500 670,-500 640,-440" style="fill:#edbe82;" />
<text x="300" y="-450" fill="#000" font-size="50">Assassins Creed</text>

<polygon points="750,-460 750,-340 890,-340 890,-460" style="fill:#edbe82;" />
<text x="770" y="-430" fill="#000" font-size="30">Legend:</text>
<text x="800" y="-400" fill="#000" font-size="15">= Actions</text>
<polygon points="760,-420 760,-390 795,-390 795,-420" style="fill:red;" />
<text x="800" y="-360" fill="#000" font-size="15">= Speakers</text>
<polygon points="760,-350 760,-380 795,-380 795,-350" style="fill:#e0e0e0;" />

<!--X axis -->
<line x1="5" y1="0" x2="900" y2="0" style="stroke:#6f5739;stroke-width:4" />
<!--Y axis -->
<line x1="7" y1="0" x2="7" y2="-420" style="stroke:#6f5739;stroke-width:4" />
{
for $g in (0 to 20)
return 
   <line stroke="green" stroke-width="1" x1="0" x2="900" y1="-{$g * $ySpacer}" y2="-{$g * $ySpacer}"/>
}
<text x="380" y="40" fill="#626262" font-size="30">Chapters</text>
<text x="-1" y="-50" fill="#626262" font-size="30" transform="rotate(270 -1,-50)">Amount</text>
</g>
</svg>;

$ThisFileContent
(:  :let $filepath := '/db/2022-ClassExamples'
let $filename := "svg2-output.svg"
let $doc-db-uri := xmldb:store($filepath, $filename, $ThisFileContent)
return $doc-db-uri:)    

(: View this SVG at http://exist.newtfire.org/exist/rest/db/2022-ClassExamples/svg2-output.svg :)
