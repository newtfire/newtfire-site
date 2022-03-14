xquery version "3.1";
declare variable $thisFileContent := 
<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 3000 2000">
<!--2021-03-24 ebb: Danny, you were using the width="100%" and height="100%" attributes, which effectively cut off your plot so the text isn't visible.
When the numbers for x and y get into the thousands, we'll typically switch to using the viewBox attribute, which I'm setting in place here.
To save your output to the database, we'll use some variables very similar to what we do with saving output HTML. I'll add them here so you can see them and continue working with them in other contexts. These involve using a global variable with the syntax "declare variable $X := something ;  " to wrap the whole output file, and then a set of variables at the end that write the file to a location you set in the eXist-dB. Note that global variables MUST end with a semicolon (that's how they're different from FLWOR variables.) So $thisFileContent ends at the end of the SVG document we're making.  
-->
<g transform="translate(25,200)">
{
let $ac := doc('/db/assassinsCreed/assassinscreedodyssey.xml')
let $intro := $ac//Q{}intro
let $chapNums := $ac//Q{}chapterNum
let $segments := ($intro, $chapNums)
for $s at $pos in $segments
let $actions := $s//Q{}action
let $sectionTitle :=
    if($s//Q{}chapTitles)
        then $s//Q{}chapTitles/string() ! normalize-space()
    else "intro"
let $speakers := $s//Q{}speaker
let $distSpeakers := $speakers! normalize-space() => distinct-values()
let $countSpeakers := $distSpeakers => count()
let $countActions := $actions => count()
let $spacer :=65
return 
<g>
    <circle cx="{$pos * $spacer}" cy="100" r="{$countActions}" stroke = "black" stroke-width="3" fill="green"/>
    <text x="{$pos * $spacer}" y="150" style="writing-mode: tb; glyph-orientation-vertical:0">{$sectionTitle}</text>
    <circle cx="{$pos * $spacer}" cy="100" r="{$countSpeakers}" stroke = "black" stroke-width="1" fill="blue"/>
    </g>

}
</g>
</svg> ;
(:  :ebb: The semicolon indicates the end of our global variable $thisFileContent. That variable now holds the contents of our file. To return it and preview the file, just type $thisFileContent . You do not use a return statement for a global variable b/c it is not in a FLWOR. :)

let $filename := "dxhSVG2-output.svg"
let $doc-db-uri := xmldb:store("/db/dxh405/", $filename, $thisFileContent)
return $doc-db-uri 
(:  View this SVG at http://newtfire.org:8338/exist/rest/db/dxh405/dxhSVG2-output.svg  :)


 
 

