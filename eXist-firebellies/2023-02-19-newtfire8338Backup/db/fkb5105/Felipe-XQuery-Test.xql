xquery version "3.1";
declare variable $ySpacer := .5;
declare variable $xSpacer := 75;

<svg width="1000" height="1000">
<g transform="translate(30, 600)">
{
(:First Part: XQuery :)
(:1st Question:)
let $drafts := collection('/db/starwars/fixed/') 

 (:2nd Question :)
 (: Basically, the overall purpose of this code is to return the drafts dates from oldest to newest. First, the let function is telling us that there are multiple statements defining it. Secondly, with the for loop we are assigning a variable $d to the $drafts (the documents). Then in the third line we are again creating a new variable, $date, that is grabbing the date attribute from the document. The order is simply assigning them numerical values and ordering them. Lastly, like I said at the begging, when you return it you will get the $date values from oldest to newest  :)
 
(:let $sortOrder := 
  for $d in $drafts
  let $date := $d//date/@date ! data()
  order by $date
  return $date :) 
   
(: 3rd Question :)   
for $s at $pos in $drafts
    let $title := $s//title ! data()
(: 4th Question :)
    let $date := $s//date/@date ! data()  
    order by $date
(: 5th Question :)    
    let $sp := $s//sp => count()
(: 6th & 7th Question :)
    let $spk := $s//sp/@spk ! normalize-space() => distinct-values() => count() 

(: 8th Question :)
(:return concat($pos,", Date Created: ", $date,", Title of Draft: ", $title,", Speech Count: ", $sp,", Distinct Speakers: ", $spk):)

(: Second Part: SVG output :)
 return
(: Chart content:)
<g>
<line x1="{$pos * $xSpacer + 5}" x2="{$pos * $xSpacer + 5}" y1="0" y2="-{$sp * $ySpacer}" stroke="#E07D39" stroke-width="35"/>
<line x1="{$pos * $xSpacer + 40}" x2="{$pos * $xSpacer + 40}" y1="0" y2="-{$spk * $ySpacer}" stroke="#8948C1" stroke-width="35"/>
<text x="{$pos * $xSpacer + 32}" y="-{$spk * $ySpacer +4}" fill="#000" font-size="14">{$spk}</text>
<text x="{$pos * $xSpacer - 5}" y="-{$sp * $ySpacer +4}" fill="#000" font-size="14">{$sp}</text>
<text x="{$pos * $xSpacer}" y="20" fill="black" font-size="15" transform="rotate(30 {$pos * $xSpacer}, 20)">{$title}</text>
</g>
}

(: Chart lines :)
<line x1="50" y1="0" x2="470" y2="0" style="stroke:#000;stroke-width:3" />
<line x1="51" y1="0" x2="51" y2="-530" style="stroke:#000;stroke-width:3" />

(: Legend :)

<text x="600" y="-130" fill="black" font-size="15">= Speeches</text>
<polygon points="560,-150 560,-120 595,-120 595,-150" style="fill:#E07D39" />
<text x="600" y="-90" fill="black" font-size="15">= Speakers</text>
<polygon points="560,-80 560,-110 595,-110 595,-80" style="fill:#8948C1;" />

<text x="200" y="35" fill="black" transform="rotate(270)" font-size="30">Total Count</text>
</g>

</svg>

