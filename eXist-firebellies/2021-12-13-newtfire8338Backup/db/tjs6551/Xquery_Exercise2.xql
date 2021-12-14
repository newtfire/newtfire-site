xquery version "3.1";
declare default element namespace "http://www.tei-c.org/ns/1.0";
let $plays:= collection('/db/apps/shakespeare/data/')//TEI
let $speakers:= $plays//speaker
let $distinctspeakers:= $speakers ! normalize-space() => distinct-values()
(: Normalize-space removes more than two spaces 
 : Exclamation point visits each node one at a time
 : means simple map
 : the arrow sends a whole list of text strings to distinct values to remove duplicates  :)
let $count:= $distinctspeakers => count()
let $countall:= $speakers => count()
for $p at $pos in $plays
let $pspeakers:= $p//speaker
let $pcount:= $pspeakers => count()
let $pdspeakers:= $pspeakers ! normalize-space() => distinct-values()
let $cpdspeakers:= $pdspeakers => count()
let $ptitle:= $p//titleStmt/title
let $stringjoin:= string-join($pdspeakers, "#")
where $cpdspeakers > 50
let $filepath:= $p ! base-uri() ! tokenize(.,"/")[last()]
order by $cpdspeakers
return $cpdspeakers
    (:concat($pos, " ",$ptitle, "; ", $cpdspeakers, string-join($pdspeakers, "#"), $filepath):)
(: concat combines two or more strings together. add parenthesis to show seperation 
 : string join takes many things and bundles them together
 : :)
 


