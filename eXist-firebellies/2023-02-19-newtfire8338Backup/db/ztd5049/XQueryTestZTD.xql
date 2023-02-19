xquery version "3.1";
declare variable $xSpacer := 70;

<svg width="1400" height="600">
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

for $s at $pos in $sortOrder
    let $date := $s//date/@date ! string()
    let $title := $s//title ! normalize-space()
    let $speeches := $s//sp => count()
    let $spk := $s//sp/@spk => distinct-values() => count()


return 
    (:concat($pos, "  |  ", $title, "  |  ", $date, "  |  ", $speeches, "  |  ", $spk):)
<g>
    <polygon points="{$pos * $xSpacer + 160}, 200 {$pos * $xSpacer + 160},{$speeches * 0.1} {$pos * $xSpacer + 190},{$speeches * 0.1} {$pos * $xSpacer + 190},{200}" fill="rgb(88, 214, 141)"/>
    <polygon points="{$pos * $xSpacer + 660}, 200 {$pos * $xSpacer + 660},{$spk} {$pos * $xSpacer + 690},{$spk} {$pos * $xSpacer + 690},{200}" fill="rgb(88, 178, 233)"/>
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
    
    <text x="-105" y="320" transform="rotate(300)" font-size="15">Script 1</text>
    <text x="-110" y="380" transform="rotate(300) translate(40)" font-size="15">Script 2</text>
    <text x="-73" y="442" transform="rotate(300) translate(40)" font-size="15">Script 3</text>
    <text x="-38" y="502" transform="rotate(300) translate(40)" font-size="15">Script 4</text>
    <text x="-4" y="562" transform="rotate(300) translate(40)" font-size="15">Script 5</text>
    
    <text x="146" y="754" transform="rotate(300)" font-size="15">Script 1</text>
    <text x="141" y="814" transform="rotate(300) translate(40)" font-size="15">Script 2</text>
    <text x="178" y="876" transform="rotate(300) translate(40)" font-size="15">Script 3</text>
    <text x="213" y="936" transform="rotate(300) translate(40)" font-size="15">Script 4</text>
    <text x="247" y="996" transform="rotate(300) translate(40)" font-size="15">Script 5</text>
    
</g>
}
</g>
</svg>