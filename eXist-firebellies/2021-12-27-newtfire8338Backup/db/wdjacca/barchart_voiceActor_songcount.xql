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
<svg xmlns="http://www.w3.org/2000/svg" width="{$maxWidth + 800}" height="{-$maxHeight}">
<g transform="translate(100, 250)">
<line x1 = "20" y1 = "0" x2="{$maxWidth + 700}" y2="0" stroke="black" stroke-width="2"/>
<polyline points="33 -200 48 -210 63 -200" stroke="black"
        stroke-linecap="round" fill="none" stroke-linejoin="round"/>
        <text x="-45
        " y="20" fill="black" transform="rotate(180)" style="writing-mode: tb; glyph-orientation-vertical:0;">Number of Voice Actors</text>
        <text x="50" y="18" fill="black">Number of Songs</text>
        <polyline points="180 2 190 15 180 27" stroke="black"
         stroke-linecap="round" fill="none" stroke-linejoin="round"/>
(: axissss :)
{
     for $m at $pos in $movie
        let $song := $collection//Q{}xml[.//Q{}movie=$m]//Q{}song => count()
        let $voiceActor := $collection//Q{}xml[.//Q{}movie=$m]//Q{}voiceActor ! normalize-space() => distinct-values () => count()


    return 
    <g>
        
        <line x1="{$pos * $spacer}" y1="0" x2="{$pos * $spacer}" y2="{-$voiceActor*20}" stroke="#c1e0f7" stroke-width="{$song*20}"/>
        <text x="{$pos * $spacer}" y="30" fill="black" style="writing-mode: tb; glyph-orientation-vertical:0">{$m}</text>
        
    </g>
    
} 
</g>
</svg>

;let $filename := "barchart_voiceActor_songCount.svg"
let $doc-db-uri := xmldb:store("/db/wdjacca/", $filename, $thisFileContent)
return $doc-db-uri   
(: View this SVG at http://newtfire.org:8338/exist/rest/db/wdjacca/testmovieData.svg  :)