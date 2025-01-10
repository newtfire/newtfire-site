xquery version "3.1";
declare default element namespace "http://www.tei-c.org/ns/1.0";
(:  :collection('/db/apps/shakespeare/data/')/TEI[descendant::sp[speaker="Falstaff"]]//titleStmt/title :)
let $plays := collection('/db/apps/shakespeare/data/')/TEI
let $speakers := $plays//speaker 
let $distinctSpeakers := $speakers => distinct-values()
for $p in $plays
    let $dsp := $p//speaker => distinct-values()
    let $title := $p//titleStmt/title
    let $dspCount := $dsp => count()
    where $dspCount > 50
    order by $dspCount descending
return ($title || " : " || $dspCount)
(: The || is for concatenating the results.  :)
    
    
    


