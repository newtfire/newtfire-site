xquery version "3.1";
declare default element namespace "http://www.tei-c.org/ns/1.0";
(: XQuery Exercise 1 :)

let $shakes:= collection('/db/apps/shakespeare/data/')
let $title := $shakes//titleStmt/title ! string()
(: This lists the titles :)

let $speeches := $shakes//sp
let $falstaffs := $speeches[speaker = "Falstaff"]
let $countFals := $falstaffs => count()

(:return $countFals:)
(: This will return the amount of times Falstaff speaks in every play :)

let $falPlays := $shakes//TEI[.//speaker = "Falstaff"] (:This will return the plays that contain Falstaff as a speaker:)
for $f in $falPlays
   let $fTitle := $f//titleStmt/title ! string() (:This returns the titles in a fashion that will work well for the concat function:)
   let $fCount := $f//sp[speaker="Falstaff"] => count() (:This returns the count of Falstaffs in each play:)


return  concat($fTitle, " Falstaff count is: ", $fCount) 