xquery version "3.1";
declare default element namespace "http://www.tei-c.org/ns/1.0";
(: XQuery Exercise 2 :)

let $plays := collection('/db/apps/shakespeare/data/')//TEI

(: Step One :)
let $speakers := $plays//speaker
let $countS := $speakers => count()
(: return $countS :)
(: There are 31054 speakers:)

let $distSpeakers := $speakers => distinct-values()
(: There are 966 distinct speakers :)

(: Step Two :)
let $countDS := $distSpeakers => count()
(: return $countDS :)

(: Step Three :)
for $p in $plays
   let $countSpk := $p//speaker => distinct-values() => count() (:Gets amount of distinct speakers in each play:)
   let $title := $p//titleStmt/title ! string() (:Gets title name:)
   let $filePath := $p ! base-uri() (:Gets full file address:)
      where $countSpk > 50 (:Filters all plays below 50 distinct speakers:)
   

return concat($filePath, " is ", $title, ": ", $countSpk, " distinct speakers")