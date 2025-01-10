xquery version "3.1";
(: Simpsons SVG season by season: unfinished. :)
(: start by declaring global variables. These must end with a semicolon ;  :)
declare variable $xSpacer := 50;
declare variable $ySpacer := 50;
declare variable $colors := ("red", "green", "blue", "orange", "yellow", "purple", "aqua");
declare variable $DStext := doc('/db/00-students-00/tza13/docs/dsTestOutput.xml');
(: In oXygen, change the filepath and use ?select=*.xml at the end to read around your computer system files.:)

declare variable $allNames := $DStext//name => count() => distinct-values();
declare variable $types := $DStext//name/@type ! normalize-space() => distinct-values();
(:  :declare variable $distCatches := $seasonsInOrder//catchphrase ! normalize-space() ! lower-case(.) ! replace(., "'", '') => distinct-values();:)

<svg width="500" height="2000">
    <g transform="translate(50, 20)">
    <!--Use XML comments down here in the XML plot. In SVG, transform/translate shifts things by X and Y coordinates.
    So this moves the whole plot over by 50 and down by 20 from top left. We're going to start by plotting down the screen.
    We can come back here to work on flipping the plot in a different direction.
    
    Okay, let's take this season by season and plot a comparative count of catchphrases.
    -->
{
(:  :for $s at $pos in $DStext :)
(: That line above doesn't really do anything because there's only one document $DStext 
 : Looking at the document, I think you mean to be looping through the <desc> elements?
 : That would make more sense to give you something to loop over that contains the typed name elements. 
 : I'm adding that code below:)
 let $descs := $DStext//desc
 for $s at $pos in $descs

return
    
<g class="name" id="hi">
    {(:  :for $d at $pos2 in $allNames :)  
    (: ebb: The line above yields an Incompatible Primitive Types error. What even is that? 
    I am not familiar with this error but I suspect the for-statement doesn't actually nest in a way that works with the outer for statement? Anyway, if you're going to look through each desc element and, say , plot a count of the number of names of each type,
    we can do this differently. If the outer loop goes through each <desc> eleemnt, the inner loop can look at the name elements inside each desc: and that's what we can do next, just modifying your next variable so we can work with all the types:
    :)
    
    for $t at $pos2 in $types
    (:  :let $persType := $s//name[@type ! normalize-space() ! lower-case(.) ! replace(., "'", '') = $d] => count() :)
    let $countType := $s//name[@type ! normalize-space() = $t ] => count()
        
        return 
        

(: $pos is a number that counts each time the for statement runs. 
 : It should generate numbers 1 through 7 and we can use that for spacing. :)

(: We can start by plotting down the screen from top left. 
 : So we'll move y regularly down the screen using the $pos variable and the $ySpacer.  :)

    
    <g id="{$t}">
        <line x1 = '{0}' y1 ='{($pos * $ySpacer) + ($pos2 * 10)}'  x2= '{$xSpacer * $countType}' y2="{($pos * $ySpacer) + ($pos2 * 10)}" stroke='{$colors[position() = $pos2]}' stroke-width='5'/>
    
    </g>
}

</g>
}
</g>
</svg>
