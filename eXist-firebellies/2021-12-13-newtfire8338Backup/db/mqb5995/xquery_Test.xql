xquery version "3.1";
declare variable $assassins := doc('/db/assassinsCreed/assassinscreedodyssey.xml');
declare variable $intro := $assassins//Q{}intro;
declare variable $chapNums := $assassins//Q{}chapterNum;
declare variable $segments := ($intro, $chapNums);
declare variable $spacer := 80;
declare variable $max-Width := $segments => count() * $spacer + $spacer;
declare variable $bluebarElongate := 2;
declare variable $limebarElongate:= 10;
declare variable $barSpace := 30;
declare variable $ThisFileContent :=
<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 3000 1550">
<g transform="translate(100, 1100)">
<text x="-120" y="-1020" style="font-size:4em;font-weight:bold;">Comparison of Speakers per Chapter with Amount of Speaking Parts per Chapter in Assassins Creed</text>
<text x="50" y="-950" style="font-size:2.2em;">Color Key:</text>
        <circle cx="120" cy="-850" r="80" fill="blue"/>
        <text x="60" y="-850" fill="white" style="font-size:2em;">Speeches</text>
        <circle cx="300" cy="-850" r="80" fill="lime"/>
        <text x="240" y="-850" fill="black" style="font-size:2em;">Speakers</text>
        
<line x1 = "0" y1 = "0" x2="2500" y2="0" stroke="black"/>

<line x1 = "0" y1 = "-900" x2="0" y2="0" stroke="black"/>
<text x="25" y="420" style="writing-mode: tb; glyph-orientation-vertical:0; font-size:3.2em;" transform="rotate(180)">Value</text>
{for $s at $pos in $segments
    let $chapTitles := 
    if ($s//Q{}chapTitles)
        then $s//Q{}chapTitles/string() ! normalize-space()
    else "intro"
 let $speeches := $s//Q{}sp
 let $speechCount := $speeches => count()
let $speakers := $s//Q{}speaker ! normalize-space() => distinct-values()
let $distSpks := $speakers ! normalize-space() => distinct-values()
let $spkCount := $distSpks => count()
order by $speechCount descending 
    return 
        <g>
            <line x1="{$pos * $spacer}" y1="-{$speechCount * $bluebarElongate}" x2="{$pos * $spacer}" y2="0" stroke="blue" stroke-width="30"/>
            <text x="{$pos * $spacer + 15}" y="20" style="writing-mode: tb; glyph-orientation-vertical:0; font-size:1.8em;">{$chapTitles}</text>
            
            <line x1="{$pos * $spacer + $barSpace}" y1="-{$spkCount * $limebarElongate}" x2="{$pos * $spacer + $barSpace}" y2="0" stroke="lime" stroke-width="30"/>
        </g>}
    (:return concat ("Chapter ", $pos, " - ", $chapTitles, " | Number of Speeches: ", $speechCount, " | Number of Speakers: ", $spkCount):)
    
</g>
</svg>;

let $filename := "xqueryTestOutput.svg"
let $doc-db-uri := xmldb:store("/db/mqb5995/", $filename, $ThisFileContent)
return $doc-db-uri 
(:View output at: http://newtfire.org:8338/exist/rest/db/mqb5995/xqueryTestOutput.svg:)