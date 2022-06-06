xquery version "3.1";
(: ebb: Find out which Star Wars drafts are the longest in character count. :)
(:   :Calculate as percentage. :)
(: Stack the percentages on top of each other in SVG stacked bar. 100% is the max Y :)
declare variable $ySpacer := 3;
<svg width="900" height="500">
 <g transform="translate(50, 400)">
{
let $starWars := collection('/db/starwars/')
(: ebb: Let's Organize the collection in chronological order from earliest to latest draft: :)
let $chronSequence := 
            for $s in $starWars
            let $date := $s//metadata/date ! tokenize(., '[,/]')[last()] ! tokenize(., 19)[last()] ! number()
            (:Help! The team should put the date in an attribute value to make this easier.:)
            order by $date 
            return $s
            
let $totalSceneCount := $starWars//scene => count()
(: The arrow operator sends the sequence of string-lengths to the sum() function. :)
(: Write a for loop to get information to output for each document: :)
let $colorArray := ("purple", "red", "yellow", "blue", "green")

for $s at $pos in $chronSequence
    let $sDraft := $s//metadata/draft ! normalize-space()
    let $sDate := $s//metadata/date ! normalize-space()
    let $sCount := $s//scene => count()
(: To stack each portion on top of the others, we need a way to know how much comes before :)
    let $sPrecedingPortion := 
            let $previous := $chronSequence[position() < $pos]
            (:ebb: $previous goes up to the chronologically sorted sequence of Star Wars drafts, and finds each one with a position less than the current one in our for loop. When $pos = 1, this will turn up a sequence of zero, which is perfect. When $pos = 2, $previous will return the first draft in the collection. When $pos = 3, $previous will return the first two drafts. When $pos = 4, $previous will return the first three drafts, and so on.:) 
           (: $previous makes a subcollection for us so we can access info about what comes earlier. This helps us to tally up the percent of what came before so we can stack our bars. :)
            let $previousScenePercent := $previous//scene => count() div $totalSceneCount * 100
            (:This variable counts all the scenes in all the previous drafts and calculates their percentage of the whole.:)
            return $previousScenePercent 
    let $sPercent := $sCount div $totalSceneCount * 100
    let $sPercentLabel := $sPercent ! format-number(., '#.##')
    (: a special function to output as many decimal places as we want. Converts number to text string. :)
    let $color := $colorArray[position() = $pos]
    (: Loop through our color array and get the color that goes with the current $pos :)
return 
    (: concat($sDraft, ': ', $sPercentLabel, ' preceding portion: ', $sPrecedingPortion) :)
<g class="barPart">
    <line class="barstack" x1="50" y1="-{$sPrecedingPortion * $ySpacer}" x2="50" y2="-{($sPrecedingPortion + $sPercent) * $ySpacer}" stroke-width="100" stroke="{$color}"/>
    <text x="120" y="-{($sPrecedingPortion + $sPercent div 2) * $ySpacer - 5}">{$sPercentLabel}%</text>
 <text x="175" y="-{($sPrecedingPortion + $sPercent div 2) * $ySpacer - 5}">{$sDraft}: {$sDate}</text> 
 
</g>
}
</g>
</svg>
