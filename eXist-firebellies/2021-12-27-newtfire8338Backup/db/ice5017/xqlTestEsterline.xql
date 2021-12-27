xquery version "3.1";
declare variable $ac := doc('/db/assassinsCreed/assassinscreedodyssey.xml');
declare variable $intro := $ac//Q{}intro;
declare variable $chapNums := $ac//Q{}chapterNum;
declare variable $segments := ($intro, $chapNums);
declare variable $spacer := 80;
declare variable $max-Width := $segments => count() * $spacer + $spacer;
declare variable $yellowBar := 1;
declare variable $greenBar:= 2;
declare variable $barSpace := 30;
declare variable $ThisFileContent := 
<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 3000 1500">
<g transform = "translate (100, 1100)">
<text x="100" y="-700" style="font-size:4em;font-weight:bold;font-family: Georgia, serif;">Number of Speakers VS The Amount of Speaker Parts</text>
<circle cx="2230" cy="-700" r="80" fill="#F7AD14"/>
<text x="2160" y="-700" fill="black" style="font-size:2em;">Speeches</text>
<circle cx="2400" cy="-700" r="80" fill="#648A47"/>
<text x="2330" y="-700" fill="black" style="font-size:2em;">Speakers</text>
<line x1="0" y1="0" x2="2500" y2="0" stroke="black"/>
<line x1="0" y1="-900" x2="0" y2="0" stroke="black"/>
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
            <text x="{$pos * $spacer -13}" y="-{$speechesCount * $yellowBar +17}" fill="black">{$speechesCount}</text> 
            <line x1="{$pos * $spacer}" y1="-{$speechesCount * $yellowBar}" x2="{$pos * $spacer}" y2="0" stroke="#F7AD14" stroke-width="25"/>
            <text x="{$pos * $spacer + 17}" y="20" style="writing-mode: tb; glyph-oriented-vertical:0; font-size:2em;">{$chapTitles}</text>
            <text x="{$pos * $spacer + 24}" y="-{$spkrCount * $greenBar +15}" fill="black">{$spkrCount}</text> 
            <line x1="{$pos * $spacer + $barSpace}" y1="-{$spkrCount * $greenBar}" x2="{$pos * $spacer + $barSpace}" y2="0" stroke="#648A47" stroke-width="25"/>
        </g>  }  


</g>
</svg>;

(:  return concat ($s, $pos, $speaker, $distSpeaker):)
 
let $filename := "xqueryTestICE.svg"
let $doc-db-uri := xmldb:store("/db/ice5017/", $filename, $ThisFileContent)
return $doc-db-uri

(:Output found at: http://newtfire.org:8338/exist/rest/db/ice5017/xqueryTestICE.svg:)