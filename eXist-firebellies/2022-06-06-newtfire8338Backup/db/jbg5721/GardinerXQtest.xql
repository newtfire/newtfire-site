xquery version "3.1";
declare variable $ySpacer := .5;
declare variable $xSpacer := 80;

<svg width="1000" height="1000">
<g transform="translate(30, 600)">
{
let $drafts := collection('/db/starwars/fixed/')
(:
 jbg- Question2- This let function is being defined my multiple statements. The for loop, calls to the defined documents with $drafts and creates a variable $d to be used and repeated. Then a let statement creates a new variable, $date, and calls to the for loop. It grabs only the value in the date attribute from the original documents. The order by statement orders the values numerically. The first return, returns the $date values. Then with returning the $sortOrder you get all the dates from oldest to newest. 
 let $sortOrder := 
    for $d in $drafts
    let $date := $d//date/@date ! data()
    order by $date
    return $date   :)
    
for $s at $pos in $drafts (: Question 3 :)
    let $title := $s//title ! data()
    let $date := $s//date/@date ! data()  (: Question 4 :)
    order by $date
    let $sp := $s//sp => count() (: Question 5 :)
    let $spk := $s//sp/@spk ! normalize-space() => distinct-values() => count() (: Question 6 & 7 :)

(:return concat($pos,", Date Created: ", $date,", Title of Draft: ", $title,", Speech Count: ", $sp,", Distinct Speakers: ", $spk)  Question 8 :)
  return
      <g>
          <line x1="{$pos * $xSpacer + 30}" x2="{$pos * $xSpacer + 30}" y1="0" y2="-{$sp * $ySpacer}" stroke="#aadbf9" stroke-width="25"/>
          <line x1="{$pos * $xSpacer}" x2="{$pos * $xSpacer}" y1="0" y2="-{$spk * $ySpacer}" stroke="green" stroke-width="25"/>
          <text x="{$pos * $xSpacer - 8}" y="-{$spk * $ySpacer +2}" fill="#000" font-size="14">{$spk}</text>
          <text x="{$pos * $xSpacer + 18}" y="-{$sp * $ySpacer +2}" fill="#000" font-size="14">{$sp}</text>
          <text x="{$pos * $xSpacer}" y="20" fill="#626262" font-size="15" transform="rotate(45 {$pos * $xSpacer}, 20)">{$title}</text>
      </g>
  
  
}
<polygon points="550,-460 550,-340 690,-340 690,-460" style="fill:#d0d0d0;" />
<text x="570" y="-430" fill="black" font-size="30">Legend:</text>
<text x="600" y="-400" fill="black" font-size="15">= Speeches</text>
<polygon points="560,-420 560,-390 595,-390 595,-420" style="fill:#aadbf9;" />
<text x="600" y="-360" fill="black" font-size="15">= Speakers</text>
<polygon points="560,-350 560,-380 595,-380 595,-350" style="fill:green;" />


<line x1="50" y1="0" x2="470" y2="0" style="stroke:#000;stroke-width:4" />
<line x1="51" y1="0" x2="51" y2="-530" style="stroke:#000;stroke-width:4" />

<text x="42" y="-50" fill="#626262" font-size="30" transform="rotate(270 42,-50)">Count</text>
</g>
</svg>
