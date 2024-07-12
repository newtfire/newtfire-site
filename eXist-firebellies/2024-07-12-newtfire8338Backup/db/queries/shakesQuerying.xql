xquery version "3.1";
declare default element namespace "http://www.tei-c.org/ns/1.0";
let $shakes := collection('/db/apps/shakespeare/data/')//TEI
for $play in $shakes
    let $playTitle := $play//titleStmt/title
    let $speakers := $play//speaker
    let $distinctSpeakers := $speakers => distinct-values()
    let $count := $distinctSpeakers => count()
    where $count gt 58
    order by $count descending
    return concat($playTitle, " has ", $count, " speakers.")