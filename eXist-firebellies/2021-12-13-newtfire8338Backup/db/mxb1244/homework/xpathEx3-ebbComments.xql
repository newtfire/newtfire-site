xquery version "3.1";
let $autoColl := collection('/db/auto')/*
let $entries := $autoColl//entry
for $e in $entries
(: ebb: McKenna, you don't really need the for loop on line 4. What it's doing is just DOUBLING your output (you should only get 13 results with this, but we're seeing 27 because the SECOND for loop below is running once for each of the entries.)
 : It gets all your results, but over and over again. 
 : So, you could just get the $built values working with the whole sequence of $entries instead of breaking into a loop here. :)
let $built := $e/built/@when ! data()
let $name := $e/name ! normalize-space()
let $distinctBuilt := $built => distinct-values()
for $d in $distinctBuilt
(:  ebb: THIS for loop is essential, however. Good work with constructing the predicate in the line below. :)
let $cName := $autoColl[descendant::built/@when = $d]//name ! string() ! normalize-space()
return concat($d, ': ' , string-join($cName ,  ', '))
