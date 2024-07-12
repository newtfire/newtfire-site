xquery version "3.1";
declare default element namespace "http://www.tei-c.org/ns/1.0";
(:  :collection('/db/apps/shakespeare/data/')//sp[speaker="Falstaff"] => count() :)
let $plays := collection('/db/apps/shakespeare/data/')/TEI
let $speakers := $plays//speaker
let $distinctSpeakers := $speakers => distinct-values()
for $p in $plays
    let $dsp := $p//speaker => distinct-values()
    let $title := $p//titleStmt/title/text()
    let $dspCount := $dsp => count()
    where $dspCount > 50
return concat($title, " ", $dspCount, " ", base-uri($title))