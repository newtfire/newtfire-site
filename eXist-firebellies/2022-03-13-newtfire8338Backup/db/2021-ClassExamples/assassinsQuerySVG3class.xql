xquery version "3.1";
declare variable $ac := doc('/db/assassinsCreed/assassinscreedodyssey.xml');
declare variable $intro := $ac//Q{}intro;
declare variable $chapNums := $ac//Q{}chapterNum;
declare variable $segments := ($intro, $chapNums);
declare variable $spacer := 65;
declare variable $max-Width := $segments => count() * $spacer + $spacer;
declare variable $ActionCounts := 
    for $s in $segments
    let $actions := $s//Q{}action
    return $actions => count();
declare variable $maxActionCount := $ActionCounts => max();
declare variable $height-spacer := -10;
declare variable $max-Height := $maxActionCount * $height-spacer;        

declare variable $ThisFileContent := 
<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 {$max-Width} 700">
(: Originally we were working with: width="2000" height="500"
 : Look at the SVG viewBox attribute: set this to stretch from 0 0 to a set of max values for X and Y: the larger these are the smaller the plot shrinks.
 : try to start: viewBox="0 0 3000 1500"
 : Try removing the width and height attributes and adding a viewBox instead, scaling the coordinate system. :)
<g transform="translate(25, 500)">
<!--Draw my X and Y axes up here! -->
<line x1 = "0" y1 = "0" x2="{$max-Width}" y2="0" stroke="black"/>
<!--X axis above here -->

<line x1 = "0" y1 = "0" x2="0" y2="{$max-Height}" stroke="black"/>
<!--Y axis above here -->
{
for $s at $pos in $segments
let $actions := $s//Q{}action
let $sectionTitle := 
    if ($s//Q{}chapTitles)
        then $s//Q{}chapTitles/string() ! normalize-space()
    else "intro"
let $speakers := $s//Q{}speaker
let $distSpeakers := $speakers ! normalize-space() => distinct-values()
let $countSpeakers := $distSpeakers => count()

let $countActions := $actions => count()

return 
    <g>
      <circle cx="{$pos * $spacer}" cy="100" r="{$countActions}" stroke="black" stroke-width="2" fill="blue"/>
      <text x="{$pos * $spacer}" y="150" style="writing-mode: tb; glyph-orientation-vertical:0">{$sectionTitle}</text>
      {$countSpeakers}
    </g>    
    
}

</g>
</svg> ;

$ThisFileContent
(:   :let $filename := "acData.svg"
let $doc-db-uri := xmldb:store("/db/2021-ClassExamples/", $filename, $ThisFileContent)
return $doc-db-uri   :)
(: View this SVG at http://newtfire.org:8338/exist/rest/db/2021-ClassExamples/acData.svg  :)