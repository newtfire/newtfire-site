xquery version "3.1";
let $charindex := doc('/db/mayan/PV_characterIndex.xml')
let $PV := doc('/db/mayan/popolVuh.xml')
let $chars := $PV//character/@idref ! string()
let $distChars := $chars => distinct-values() 
for $d in $distChars 
let $dCount := $PV//descendant::character[@idref ! string() = $d] => count()
let $dParts := $PV//part[descendant::character/@idref = $d]/@n ! data() 
let $stringjoinParts := string-join($dParts, ', ')
return concat($d, " appears ", $dCount, " times in the whole Popol Vuh. ", $d, " appears in these sections: ", $stringjoinParts, '.')


