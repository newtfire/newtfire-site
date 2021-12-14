xquery version "3.1";
declare variable $ThisFileContent :=
<svg xmlns="http://www.w3.org/2000/svg" viewBox = "0 0 1000 1000">
<g transform="translate(25, 500)">
{
let $KingdomHearts := collection('/db/kingdomofhearts')
let $xSpacer := 175
let $ySpacer := 175
let $factor := 25
for $k at $pos in $KingdomHearts
let $cutscenes := $k//Q{}cutscene
let $speeches := $k//Q{}sp [not(ancestor::cutscene)]
let $countSpeeches := $speeches => count()
let $countCutscenes := $cutscenes => count()

(:  :return ($countCutscenes || "&#x9;" || $countSpeeches) :)
(:   :<rect x="250" y="100" width="50" height="{$countCutscenes div 200}" transform="scale(1, -1) translate(0, -100)" fill="orange" stroke="black" stroke-width="2"/> :)
return
    <g>
        <rect x="{$pos * $xSpacer}" y="-{$countSpeeches div $factor}" width="{$countCutscenes div $factor}" height="{$countSpeeches div $factor}" fill="teal" stroke="black" stroke-width="2"/>
        <text x="{$pos * $xSpacer - 15}" y="-{$countSpeeches div $factor}" style="writing-mode: tb; glyph-orientation-vertical">{$countSpeeches} Speeches</text>
        <text x="{$pos * $xSpacer}" y="-{$countSpeeches div $factor + 10}">{$countCutscenes} Cutscenes</text>
        <text x="215" y="-110" font-size="larger" fill="white">KH</text>
        <text x="216" y="-85" font-size="larger" fill="white">1.5</text>
        <text x="385" y="-130" font-size="larger" fill="white">KH</text>
        <text x="387" y="-105" font-size="larger" fill="white">2.5</text>
        <text x="535" y="-50" font-size="larger" fill="white">KH</text>
        <text x="543" y="-25" font-size="larger" fill="white">3</text>
    </g>
}

</g>
</svg> ;

let $filename := "Speeches-vs-Cutscenes.svg"
let $doc-db-uri := xmldb:store("/db/kingdomofhearts-queries/", $filename, $ThisFileContent)
return $doc-db-uri
(: View this SVG at http://newtfire.org:8338/exist/rest/db/kingdomofhearts-queries/Speeches-vs-Cutscenes.svg :)