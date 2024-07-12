xquery version "3.1";
declare default element namespace "http://www.tei-c.org/ns/1.0";(: take this out for disney songs :)
(:collection('/db/apps/shakespeare/data/')//teiHeader//titleStmt/normalize-space():)
(:collection('/db/apps/shakespeare/data/')/TEI[.//sp[speaker='Falstaff']]//titleStmt/title:)
(:  :collection('/db/apps/shakespeare/data/')//sp[speaker='Falstaff']=>count():)
let $shakes := collection('/db/apps/shakespeare/data/')
let $fal := $shakes//sp[speaker='Falstaff']
let $falPlays := $shakes[.//sp[speaker='Falstaff']]
for $p in $falPlays
    let $falSp := $p//sp[speaker='Falstaff'] => count()
    where $falSp > 140
    order by $falSp descending
    return $shakes