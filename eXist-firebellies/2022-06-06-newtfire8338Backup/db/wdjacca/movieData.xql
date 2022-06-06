xquery version "3.1";
(:  :declare variable $thisFileContent := :)
<svg xmlns="http://www.w3.org/2000/svg" width="3000" height="1000">
<g transform="translate(25, 200)">
    {
    let $collection := collection('/db/disneySongs/')
    let $movie := $collection//Q{}movie ! normalize-space() => distinct-values ()
    for $m at $pos in $movie
        let $song := $collection[.//Q{}movie=$m]//Q{}song => count()
        let $composer := $collection[.//Q{}movie=$m]//Q{}composer ! normalize-space() => distinct-values ()
        let $countComp := $composer => count()
        let $spacer := 150
        let $voiceActor := $collection[.//Q{}movie=$m]//Q{}voiceActor ! normalize-space() => distinct-values ()
        let $countVA := $voiceActor => count()
        
    return
    <g>
      <circle cx="{$pos * $spacer}" cy="150" r="{$song*5}" stroke="black" fill="#cfbae1"/>
      <text x="{($pos * $spacer)-2}" y="155" fill="black">No. of Songs{$song}</text>
      <text x="{$pos * $spacer}" y="250" style="writing-mode: tb; glyph-orientation-vertical:0" fill="blue">{$m}</text>
      <line x1="{$pos * $spacer}" y1="0" x2="{$pos * $spacer}" y2="{$countComp*10}" stroke="grey" stroke-width="{$countVA}"/>
      <line x1 ="5" y1="0" x2="400" y2="0" stroke="black"/>
      <line x1 ="5" y1="-200" x2="5" y2="0" stroke="black"/>
    </g>    
    }
</g>
</svg>
(: ;
let $filename := "movieData.svg"
let $doc-db-uri := xmldb:store("/db/wdjacca/", $filename, $thisFileContent)
return $doc-db-uri   
(: View this SVG at http://newtfire.org:8338/exist/rest/db/wdjacca/movieData.svg  :):)