xquery version "3.1";
let $mayan := collection('/db/mayan/')
let $gods := $mayan//character[name] 
(: ebb: I'm just going ahead and adding this predicate [name] to limit your results to only the <character> elements with a <name> inside.
 : That god rid of the extra 470 odd character returns you were getting before. :)
for $g in $gods
let $gname := $g/name
let $godID := $g/@xml:id ! data()
return 

   <li>
        <a href="PHP_responseGodStuff.php?godID={$g/@xml:id ! substring-after(., '#')}">{$g/name ! string() }</a>
    </li> 


