xquery version "3.1";
declare default element namespace "http://www.tei-c.org/ns/1.0";
let $plays := collection('/db/apps/shakespeare/data/')/TEI
for $p in $plays
    let $ptitle := $p//titleStmt/title/text()
    let $pspeakers := $p//speaker => distinct-values() => count()
    where $pspeakers > 50
    let $fileNames := $ptitle ! base-uri() ! tokenize(. , "/")[last()] 
    return ($fileNames || " // " || $ptitle || " // " || $pspeakers)