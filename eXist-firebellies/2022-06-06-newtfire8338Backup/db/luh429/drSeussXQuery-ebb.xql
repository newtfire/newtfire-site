xquery version "3.1";
declare variable $ySpacer := 10;
declare variable $xSpacer := 30;
declare variable $xLegend := 15;
declare variable $yLegend := 40;

<svg width="1000" height="1000">
<g transform="translate(30, 600)">

{
    let $book := collection('/db/seuss/')
    
    for $g in (0 to 10)
    
    for $b at $pos in $book
            
    let $title := $b//title
            
    let $char := $b//char
    let $charDv := $b//char =>distinct-values()
    let $charCount := $b//char =>count()
    let $charDvCount := $b//char =>distinct-values() =>count()
    
    let $sound := $b//sound
    let $soundDv := $b//sound =>distinct-values()
    let $soundCount := $b//sound =>count()
    let $soundDvCount := $b//sound =>distinct-values() =>count()
    
    let $figOfSp := $b//figOfSp
    let $figOfSpDv := $b//figOfSp =>distinct-values()
    let $figOfSpCount := $b//figOfSp =>count()
    let $figOfSpDvCount := $b//figOfSp =>distinct-values() =>count()
    
    let $rym := $b//rym
    let $rymDv := $b//rym =>distinct-values()
    let $rymCount := $b//rym =>count()
    let $rymDvCount := $b//rym =>distinct-values() =>count()
    
    let $sch := $b//sch
    let $schDv := $b//sch =>distinct-values()
    let $schCount := $b//sch =>count()
    let $schDvCount := $b//sch =>distinct-values() =>count()
    
    let $mUp := $b//mUp
    let $mUpDv := $b//mUp =>distinct-values()
    let $mUpCount := $b//mUp =>count()
    let $mUpDvCount := $b//mUp =>distinct-values() =>count()
    
    return
    (: concat($spks, ": ", $actions ):)
<g>
    (:GRAPH:)
    <line x1="15" y1="-{5 *$g * $ySpacer}" x2="{1000}" y2="-{5 * $g * $ySpacer}" stroke="lightgrey"/>
    
    <line x1="15" x2="15" y1="0" y2="-515" stroke="black"/>
    <line x1="15" x2="{$pos * $xSpacer + 20}" y1="0" y2="0" stroke="black"/>
    
    <line x1="{$pos * $xSpacer}" x2="{$pos * $xSpacer}" y1="0" y2="-{$charCount * $ySpacer}" stroke="green" stroke-width="10"/>
    <line x1="{$pos * $xSpacer + 11}" x2="{$pos * $xSpacer + 11}" y1="0" y2="-{$soundCount * $ySpacer}" stroke="blue" stroke-width="10"/>
    
    <text x="40" y="-550" font-size="25">Character Vs Sound Count</text>
    
    <text x="-5" y="-{5 *$g * $ySpacer}">{$g * 5}</text>
    
    (:LEGEND:)
    <rect x="{$xLegend}" y="{$yLegend}" width="150" height="55" stroke="black" fill="white"/>
    
    <rect x="{$xLegend + 15}" y="{$yLegend + 15}" width="10" height="10" fill="green"/>
    <rect x="{$xLegend + 15}" y="{$yLegend + 30}" width="10" height="10" fill="blue"/>
    
    <text x="{$xLegend + 30}" y="{$yLegend + 25}">character count</text>
    <text x="{$xLegend + 30}" y="{$yLegend + 40}">sound count</text>
    
    <text x="{$xLegend}" y="{$yLegend - 5}">Legend</text>
</g>
}
</g>
</svg>