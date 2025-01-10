xquery version "3.1";
(: Simpsons SVG season by season: unfinished. :)
(: start by declaring global variables. These must end with a semicolon ;  :)
declare variable $xSpacer := 50;
declare variable $ySpacer := 50;
declare variable $colors := ("red", "green", "blue", "orange", "yellow", "purple", "aqua");
declare variable $simpsonsAll := collection('/db/simpsons/');
(: In oXygen, change the filepath and use ?select=*.xml at the end to read around your computer system files.:)
declare variable $season_1 := collection('/db/simpsons/Simpsons_S1/');
declare variable $season_10 := collection('/db/simpsons/Simpsons_S10/');
declare variable $season_20 := collection('/db/simpsons/Simpsons_S20/');
declare variable $season_30 := collection('/db/simpsons/Simpsons_S30/');
declare variable $seasonsInOrder := ($season_1, $season_10, $season_20, $season_30);
declare variable $allCatches := $seasonsInOrder//catchphrase => distinct-values();
declare variable $distCatches := $seasonsInOrder//catchphrase ! normalize-space() ! lower-case(.) ! replace(., "'", '') => distinct-values();

<svg width="500" height="2000">
    <g transform="translate(50, 20)">
    <!--Use XML comments down here in the XML plot. In SVG, transform/translate shifts things by X and Y coordinates.
    So this moves the whole plot over by 50 and down by 20 from top left. We're going to start by plotting down the screen.
    We can come back here to work on flipping the plot in a different direction.
    
    Okay, let's take this season by season and plot a comparative count of catchphrases.
    -->
{
for $s at $pos in $seasonsInOrder

return
    
<g class="season" id="s{$pos}">
    {for $d at $pos2 in $distCatches 
    let $countThisCatch := $s//catchphrase[normalize-space() ! lower-case(.) ! replace(., "'", '') = $d] => count()

(: $pos is a number that counts each time the for statement runs. 
 : It should generate numbers 1 through 7 and we can use that for spacing. :)

(: We can start by plotting down the screen from top left. 
 : So we'll move y regularly down the screen using the $pos variable and the $ySpacer.  :)

return 
    <g id="{$d}">
        <line x1 = '{0}' y1 ='{($pos * $ySpacer) + ($pos2 * 10)}'  x2= '{$xSpacer * $countThisCatch}' y2="{($pos * $ySpacer) + ($pos2 * 10)}" stroke='{$colors[position() = $pos2]}' stroke-width='5'/>
    
    </g>
}

</g>
}
</g>
</svg>

