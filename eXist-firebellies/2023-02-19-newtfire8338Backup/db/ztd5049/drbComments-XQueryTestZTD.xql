xquery version "3.1";
declare variable $xSpacer := 70;

<svg width="1400" height="600">
<!--ebb: Try setting your X and Y axis lines up here, so they don't have to 
repeat inside the for loop over the drafts.

You can also set your hash mark labeling 600 and 60 
on the two side-by-side graphs up here in this portion of the file, so it is
not depending on the for-loop over the drafts. 
-->
<g>
{
let $drafts := collection('/db/starwars/fixed/')

let $sortOrder := 
    for $d at $pos in $drafts
        let $date := $d//date/@date ! data()
        order by $date
        return $d
(: This for loop above will look in the "drafts" variable and creates a variable 
   "date" for each repeat of the for loop. The date variable gathers the dates in 
   the scripts and acknowledges it as a data type. The next line then sorts the 
   the 5 returns by order of date :)
(: ebb: Well explained :)
for $s at $pos in $sortOrder
    let $date := $s//date/@date ! string()
    let $title := $s//title ! normalize-space()
    let $speeches := $s//sp => count()
    let $spk := $s//sp/@spk => distinct-values() => count()


return 
    (:concat($pos, "  |  ", $title, "  |  ", $date, "  |  ", $speeches, "  |  ", $spk):)
    (:ebb: Good work with constructing your variables to retrieve data within the for loop. :)
<g>
    <polygon points="{$pos * $xSpacer + 160}, 200 {$pos * $xSpacer + 160},{$speeches * 0.1} {$pos * $xSpacer + 190},{$speeches * 0.1} {$pos * $xSpacer + 190},{200}" fill="rgb(88, 214, 141)"/>
    <polygon points="{$pos * $xSpacer + 660}, 200 {$pos * $xSpacer + 660},{$spk} {$pos * $xSpacer + 690},{$spk} {$pos * $xSpacer + 690},{200}" fill="rgb(88, 178, 233)"/>
<!--ebb: From this point onward, you are plotting axes and labels for your graph.
The graph turns to look good and clear, but the underlying code is repeating the same elements over and over
for each turn of the for loop, which isn't necessary. To simplify the code, you can remove
this portion: simply block it *before* you begin the XQuery for loop. 
-->
    <line x1="200" x2="590" y1="200" y2="200" stroke-width="5" stroke="black"/>
    <line x1="700" x2="1090" y1="200" y2="200" stroke-width="5" stroke="black"/>
    
    <line x1="203" x2="203" y1="50" y2="200" stroke-width="5" stroke="black"/>
    <line x1="703" x2="703" y1="50" y2="200" stroke-width="5" stroke="black"/>
   
    <text x="344" y="280" font-size="22">Speeches</text>
    <text x="844" y="280" font-size="22">Speakers</text>
    
    <line x1="185" x2="210" y1="100" y2="100" stroke-width="2" stroke="black"/>
    <line x1="685" x2="710" y1="100" y2="100" stroke-width="2" stroke="black"/>
    <text x="150" y="105" font-size="22">600</text>
    <text x="660" y="105" font-size="22">60</text>
    
 <!--ebb: Below this you are plotting labels for each script manually, and that means, in each turn of this for loop, you output all five of the script label
 over and over again, so they come out 25 times, when they only need to be plotted 5 times.
 You were also doing some unnecessarily intricate calculations to affix the labels just as you wanted.
 I admire the effort, but it makes it difficult to read and adapt your code, and it is always more 
 efficient to use your XQuery variables to your advantage. To simplify this, work with the $pos variable to position each label, just as you used it for the polygons.
 Use the $pos label to give you the script number wherever you need it. It'll move from 1 to 5. 
 Finally, use the text-anchor="end" attribute to help you with affixing the x and y position and rotating
 around the end point. Here's my suggestion: just one line of code to handle all the text labels:
 I have commented out your original code so you can see this combination in action: 
 -->   
   <text x="{$pos * $xSpacer + 160}" y="220" transform="rotate(300 {$pos * $xSpacer + 160}, 220)" text-anchor="end" font-size="15">Script {$pos}</text>
   <text x="{$pos * $xSpacer + 660}" y="220" transform="rotate(300 {$pos * $xSpacer + 660}, 220)" text-anchor="end" font-size="15">Script {$pos}</text>
 
 
 <!--   <text x="-80" y="320"  font-size="15">Script 2</text>
    <text x="-73" y="442" transform="rotate(300) translate(40)" font-size="15">Script 3</text>
    <text x="-38" y="502" transform="rotate(300) translate(40)" font-size="15">Script 4</text>
    <text x="-4" y="562" transform="rotate(300) translate(40)" font-size="15">Script 5</text> -->
    
  <!--  <text x="146" y="754" transform="rotate(300)" font-size="15">Script 1</text>
    <text x="141" y="814" transform="rotate(300) translate(40)" font-size="15">Script 2</text>
    <text x="178" y="876" transform="rotate(300) translate(40)" font-size="15">Script 3</text>
    <text x="213" y="936" transform="rotate(300) translate(40)" font-size="15">Script 4</text>
    <text x="247" y="996" transform="rotate(300) translate(40)" font-size="15">Script 5</text> -->
    
</g>
}
</g>
</svg>

