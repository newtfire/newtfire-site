xquery version "3.1";
declare default element namespace "http://www.tei-c.org/ns/1.0";
let $plays := collection('/db/apps/shakespeare/data/')//TEI
let $sp := $plays//speaker
let $spdistval := distinct-values($sp)
let $spcount := count($spdistval)
for $p in $plays
let $title := $p//titleStmt/title/normalize-space()
let $playspeaker := $p//speaker
let $playspeakerdistval := distinct-values($playspeaker)
let $playspeakercount := count($playspeakerdistval)
where $playspeakercount > 50
let $playtext := distinct-values($p//text)
return ($title ||" "||$playspeakercount)