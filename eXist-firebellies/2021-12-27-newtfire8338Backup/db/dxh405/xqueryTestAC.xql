xquery version "3.1";
declare variable $ac := doc('/db/assassinsCreed/assassinscreedodyssey.xml');
declare variable $intro := $ac//Q{}intro;
declare variable $chapNums := $ac//Q{}chapterNum;
declare variable $segments := ($intro, $chapNums);
declare variable $spacer := 80;
declare variable $max-Width := $segments => count() * $spacer + $spacer;
declare variable $greyBar := 2;
declare variable $redBar:= 1;
declare variable $barSpacer := 30;
declare variable $ThisFileContent := 
<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 2800 1200">
<g transform = "translate (100, 700)">
<text x="35" y="-525" style="font-size:2em;">Amount of Speaking Parts vs Amount of Speakers per Chapter </text>
<circle cx="80" cy="-425" r="60" fill="grey"/>
<text x="35" y="-425" fill="black" style="font-size:1.5em;">Speeches</text>
<circle cx="210" cy="-425" r="60" fill="red"/>
<text x="170" y="-425" fill="black" style="font-size:1.5em;">Speakers</text>

<line x1="0" y1="0" x2="2500" y2="0" stroke="black"/>
<line x1="0" y1="-600" x2="0" y2="0" stroke="black"/>
{for $s at $pos in $segments
let $chapTitles :=
    if($s//Q{}chapTitles)
        then $s//Q{}chapTitles/string() ! normalize-space()
    else "intro"
let $speeches := $s//Q{}sp
let $speechesCount := $speeches => count()
let $speaker := $s//Q{}speaker ! normalize-space() => distinct-values()
let $distSpeaker := $speaker ! normalize-space() => distinct-values()
let $spkrCount := $distSpeaker => count()
order by $speechesCount descending
    return
        <g>
            <text x="{$pos * $spacer -11}" y="-{$speechesCount * $redBar +15}" fill="black">{$speechesCount}</text> 
            <line x1="{$pos * $spacer}" y1="-{$speechesCount * $redBar}" x2="{$pos * $spacer}" y2="0" stroke="grey" stroke-width="25"/>
            <text x="{$pos * $spacer + 15}" y="20" style="writing-mode: tb; glyph-oriented-vertical:0; font-size:1.5em;">{$chapTitles}</text>
            <text x="{$pos * $spacer + 22}" y="-{$spkrCount * $greyBar +15}" fill="black">{$spkrCount}</text> 
            <line x1="{$pos * $spacer + $barSpacer}" y1="-{$spkrCount * $greyBar}" x2="{$pos * $spacer + $barSpacer}" y2="0" stroke="red" stroke-width="25"/>
        </g>  }  

return concat ("Chapter", $pos, " ", $chapTitles, " - Number of Speeches:", $speechesCount, " - Number of Speakers:", $spkrCount)

</g>
</svg>;

let $filename := "xqueryweb.svg"
let $doc-db-uri := xmldb:store("/db/dxh405/", $filename, $ThisFileContent)
return $doc-db-uri
(: View output at http://newtfire.org:8338/exist/rest/db/dxh405/xqueryTestOP.svg :)