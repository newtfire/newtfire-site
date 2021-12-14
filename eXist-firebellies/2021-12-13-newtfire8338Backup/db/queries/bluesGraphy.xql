xquery version "3.1";
declare variable $blues := collection('/db/blues');
declare variable $artists := $blues//artist;
declare variable $distArtists := $artists ! normalize-space() => distinct-values() => sort();
declare variable $countArtists := $distArtists => count();
declare variable $ySpacer := 80;
declare variable $xSpacer := 5;
declare variable $ThisFileContent :=
<svg xmlns="http://www.w3.org/2000/svg" width="1000" height="2000" viewBox="0 0 2000 5000" >
<!--@width and @height attributes on <svg> establish dimensions. ViewBox can compress, expand, cut off.   -->
<!-- Inside the XML document portions, use XML comments! --> 
<g transform="translate(500, 0)">
{
for $d at $pos in $distArtists
let $dSongs := $blues[.//Q{}artist ! normalize-space() = $d]//Q{}title
(: ebb: Because we are inside the SVG namespace now, we have to indicate that we're working OUTSIDE of that to reach outside SVG and into our non-namespaced source XML nodes. We're denoting their "fully qualified name" which includes the null namespace and the element name. :)
let $countSongs := $dSongs => count()
return
    <g id="{$d}">
    <text x="-400" y="{$ySpacer * $pos + 5}" stroke="indigo" font-size="30">{$d ! tokenize(., "\(")[1]}</text>
    <line x1 = "0" y1="{$ySpacer * $pos}" x2="{$countSongs * $xSpacer}" y2="{$ySpacer * $pos}" stroke="blue" stroke-width="10"/>
    <circle cx="{$countSongs * $xSpacer}" cy="{$ySpacer * $pos}" r="30" stroke="indigo" stroke-width="3" fill="papayawhip" />
    <text x="{$countSongs * $xSpacer}" y="{$ySpacer * $pos + 7}" stroke="indigo" font-size="30" text-anchor="middle">{$countSongs}</text>
    </g>
}
</g>
</svg>;


let $filename := "bluesArtistGraph.svg"
let $doc-db-uri := xmldb:store("/db/2021-ClassExamples", $filename, $ThisFileContent)
return $doc-db-uri 
(: output at :http://newtfire.org:8338/exist/rest/db/2021-ClassExamples/bluesArtistGraph.svg ) :)        


