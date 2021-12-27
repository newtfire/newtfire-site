xquery version "3.1";
declare variable $collection := collection('/db/disneySongs/');
declare variable $meta := $collection//Q{}metadata;
declare variable $movie := $collection//Q{}movie ! normalize-space() => distinct-values ();
declare variable $spacer := 5;
declare variable $widthspacer := 10;
declare variable $heightspacer := -50;
declare variable $countVA :=
    for $m in $movie
    let $VA := $collection[.//Q{}movie=$m]//Q{}voiceActor ! normalize-space() => distinct-values ()
    return $VA => count();
declare variable $countmovie := $collection//Q{}xml => count();
declare variable $totalSongcount := $collection//Q{}song => count ();
declare variable $maxWidth := $countmovie * $widthspacer;
declare variable $maxHeight := $totalSongcount * $heightspacer;
declare variable $countComp := 
    for $m in $movie
    let $comp := $collection[.//Q{}movie=$m]//Q{}composer ! normalize-space() => distinct-values ()
    return $comp => count();
   
(:  :declare variable $thisFileContent := :)
<svg xmlns="http://www.w3.org/2000/svg" width="{$maxWidth + 500}" height="{$maxHeight + 500}">
<g transform="translate(100, 500)">
<line x1 = "20" y1 = "0" x2="{$maxWidth}" y2="0" stroke="black" stroke-width="2"/>

<line x1 = "20" y1 = "0" x2="20" y2="{$maxHeight}" stroke="black" stroke-width="2"/>
(: axissss :)
{
     for $m at $pos in $movie
    let $song := $collection[.//Q{}movie=$m]//Q{}song => count()
    let $comp := $collection[.//Q{}movie=$m]//Q{}composer ! normalize-space() => distinct-values ()
    let $voiceActor := $collection[.//Q{}movie=$m]//Q{}voiceActor ! normalize-space() => distinct-values ()

    let $barElongate := 10
    let $barSpace := 30

    return 
    <g>
        <line x1="20" y1="{$song}" x2="{$pos * $spacer}" y2="{$song}" stroke="blank" stroke-width="20"/>
    </g>    
    
} 
</g>
</svg>

(:  ;
let $filename := "testmovieData.svg"
let $doc-db-uri := xmldb:store("/db/wdjacca/", $filename, $thisFileContent)
return $doc-db-uri   
(: View this SVG at http://newtfire.org:8338/exist/rest/db/wdjacca/testmovieData.svg  :):)