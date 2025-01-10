declare namespace tei="http://www.tei-c.org/ns/1.0";
declare variable $Chas as document-node() := doc('/db/mitford/literary/Charles1.xml');
declare variable $ChasPlay as element() := $Chas/*;
declare variable $si as document-node() := doc('https://digitalmitford.org/si.xml');
let $Chasplaces := $Chas//tei:placeName
let $ChasPlaceRefs := $Chasplaces/@ref
let $distChPRs := sort(distinct-values($ChasPlaceRefs))
for $i at $pos in $distChPRs
let $siCPrs := $si//tei:place[@xml:id = substring-after($i, '#')]
let $name := $siCPrs/tei:placeName[1]
where $siCPrs[contains(., 'France')]
order by $siCPrs/@xml:id
return concat($pos, '. ', $name, ': ', $siCPrs//tei:note)





