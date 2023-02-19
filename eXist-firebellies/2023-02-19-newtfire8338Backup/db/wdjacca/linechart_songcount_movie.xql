xquery version "3.1";
declare variable $collection := collection('/db/disneySongs/');
declare variable $meta := $collection//Q{}metadata;
declare variable $movie := $collection//Q{}movie ! normalize-space() => distinct-values ();
declare variable $spacer := 200;
declare variable $widthspacer := 10;
declare variable $heightspacer := -21;
declare variable $countmovie := $collection//Q{}xml => count();
declare variable $totalSongcount := $collection//Q{}song => count ();
declare variable $maxWidth := $countmovie * $widthspacer + 100;
declare variable $maxHeight := $totalSongcount * $heightspacer;
declare variable $countComp := 
    for $m in $movie
    let $comp := $collection[.//Q{}movie=$m]//Q{}composer ! normalize-space() => distinct-values ()
    return $comp => count();
   
declare variable $thisFileContent :=
<svg xmlns="http://www.w3.org/2000/svg" width="{$maxWidth+800}" height="{-$maxHeight}">
<g transform="translate(100, 300)">
<line x1 = "100" y1 = "0" x2="{$maxWidth + 550}" y2="0" stroke="black" stroke-width="2"/>
<line x1 = "100" y1 = "0" x2="100" y2="-250" stroke="black" stroke-width="2"/>
<text x="100" y="15" fill="black"> 0 </text>
<text x="-120" y="15" fill="black" transform="rotate(180)" style="writing-mode: tb; glyph-orientation-vertical:0"> Number of Songs </text>
(: axissss :)
{
     for $m at $pos in $movie
        let $song := $collection//Q{}xml[.//Q{}movie=$m]//Q{}song => count()
        let $voiceActor := $collection//Q{}xml[.//Q{}movie=$m]//Q{}voiceActor ! normalize-space() => distinct-values () => count()
        let $nextpos := $pos +1 
        let $nextmovie :=
            for $n at $newpos in $movie
                where $newpos = $nextpos
                return $n
        let $nextsongCount := $collection//Q{}xml[.//Q{}movie=$nextmovie]//Q{}song => count()
        let $output :=
        if ($nextsongCount = 0)
            then <g>
                <text x="{$pos * $spacer}" y="15" fill="black" style="writing-mode: tb; glyph-orientation-vertical:0">{$m}</text>
                <text x="{$pos * $spacer}" y="{-$song*20 -10 }" fill="black">{$song}</text>
                <circle cx="{$pos * $spacer}" cy="{-$song*20}" r="6" fill="#c1e0f7"/>
            </g>
            else 
                <g>
        
                     <line x1="{$pos * $spacer}" y1="{-$song*20}" x2="{($pos +1) * $spacer}" y2="{-$nextsongCount*20}" stroke="#97f9f9" stroke-width="3"/>
                     <circle cx="{$pos * $spacer}" cy="{-$song*20}" r="6" fill="#c1e0f7"/>
                     <text x="{$pos * $spacer}" y="{-$song*20 -10 }" fill="black">{$song}</text>
                     <text x="{$pos * $spacer}" y="15" fill="black" style="writing-mode: tb; glyph-orientation-vertical:0">{$m}</text>
                      
                </g>
                
        return $output
} 
</g>
</svg>
;let $filename := "linechart_songcount_movie.svg"
let $doc-db-uri := xmldb:store("/db/wdjacca/", $filename, $thisFileContent)
return $doc-db-uri   
(: View this SVG at http://newtfire.org:8338/exist/rest/db/wdjacca/testmovieData.svg  :)