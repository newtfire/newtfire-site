xquery version "3.1";
declare variable $collection := collection('/db/disneySongs/');
declare variable $meta := $collection//Q{}metadata;
declare variable $movie := $meta//Q{}movie;
declare variable $spacer := 5;

declare variable $countComp := 
    for $m in $movie
    let $comp := $collection[.//Q{}movie=$m]//Q{}composer ! normalize-space() => distinct-values ()
    return $comp => count();
declare variable $maxcountComp := $countComp => max();
declare variable $height-spacer := -50;
declare variable $max-Height := $maxcountComp * $height-spacer; 
declare variable $countVA :=
    for $m in $movie
    let $VA := $collection[.//Q{}movie=$m]//Q{}voiceActor ! normalize-space() => distinct-values ()
    return $VA => count();
declare variable $songcount := 
    for $m in $movie
    let $songinfo := $collection[.//Q{}movie=$m]//Q{}song ! normalize-space() => distinct-values ()
    return $songinfo => count();
declare variable $totalSongcount := $collection//Q{}song => count ();
declare variable $max-Width := $totalSongcount * $spacer * $spacer;

$countComp
(: (:  :declare variable $thisFileContent := :)
<svg xmlns="http://www.w3.org/2000/svg" width="1000" height="1000">
<g transform="translate(100, 500)">
<line x1 = "20" y1 = "0" x2="{$max-Width}" y2="0" stroke="black" stroke-width="2"/>

<line x1 = "20" y1 = "0" x2="20" y2="{$max-Height}" stroke="black" stroke-width="2"/>
(: axissss :)
{
    for $m at $pos in $movie
    let $comp := $collection[.//Q{}movie=$m]//Q{}composer ! normalize-space() => distinct-values ()
    let $voiceActor := $collection[.//Q{}movie=$m]//Q{}voiceActor ! normalize-space() => distinct-values ()

    let $barElongate := 10
    let $barSpace := 30

    return 
    <g>
        <text x="{$pos * $spacer -8}" y="-{$countComp * $barElongate + 30}" fill="white">{$comp}</text>
        <line x1="{$pos * $spacer}" y1="-{$countComp * $barElongate}" x2="{$pos * $spacer}" y2="0" stroke="blue" stroke-width="30"/>
        <text x="{$pos * $spacer + $barSpace - 8}" y="-{$countVA * $barElongate + 25}" fill="black">{$voiceActor}</text>
        <line x1="{$pos * $spacer + $barSpace}" y1="-{$countVA * $barElongate}" x2="{$pos * $spacer + $barSpace}" y2="0" stroke="pink" stroke-width="30"/>
    </g>    
    
} 
</g>
</svg>:)

(:  ;
let $filename := "testmovieData.svg"
let $doc-db-uri := xmldb:store("/db/wdjacca/", $filename, $thisFileContent)
return $doc-db-uri   
(: View this SVG at http://newtfire.org:8338/exist/rest/db/wdjacca/testmovieData.svg  :):)