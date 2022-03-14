xquery version "3.1";
let $charindex := doc('/db/mayan/PV_characterIndex.xml')
let $PV := doc('/db/mayan/popolVuh.xml')
let $indexChars := $charindex//character
let $chars := $PV//character/@idref ! string() 
let $distChars := $chars => distinct-values() 
for $d in $distChars 
let $dCount := $PV//descendant::character[@idref ! string() = $d] => count()
let $dParts := $PV//part[descendant::character/@idref = $d]/@n ! data()
let $dBooks := $PV//book[descendant::character/@idref = $d]/@n ! data()
let $stringjoinParts := string-join($dParts, ', ')
let $stringjoinBooks := string-join($dBooks, ', ')
let $idNameMatch := $indexChars[concat("#", ./@xml:id ! string()) = $d]/name => distinct-values()
return concat($idNameMatch, " (", $d, ") ", " appears ", $dCount, " times in the whole Popol Vuh. ", $idNameMatch, " appears in these books: ", $stringjoinBooks, '. ')

(: let $charindex := doc('/db/mayan/PV_characterIndex.xml')
let $PV := doc('/db/mayan/popolVuh.xml')
let $indexChars := $charindex//character
let $chars := $PV//character/@idref ! string() 

let $book := $PV//book/@n ! string()
let $parts := $PV//part/@n ! string()
let $refCount := $PV//descendant::character[@idref ! string() => distinct-values()] => count()
let $distChars := $chars => distinct-values()
for $d in $distChars 
let $dCount := $PV//descendant::character[@idref ! string() = $d] => count()
let $dParts := $PV//part[descendant::character/@idref = $d]/@n ! data() 
let $stringjoinParts := string-join($dParts, ', ')
return $book :)


