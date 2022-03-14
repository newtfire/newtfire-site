xquery version "3.1";
declare default element namespace "http://www.tei-c.org/ns/1.0";
(:  :doc('/db/apps/shakespeare/data/ham.xml')//l/@xml:id => string-join(', ') :)
(: Today we are working more intensively with XPath predicate and we are introducing some XPath functions over a sequence of results. Here are our challenges from the assignment: :)
(:  Where are the main titles of the plays? Find and return them. :)
(: Find the four plays with the speaker Falstaff. Use the TEI root element :)
(: Explore working with text(), string(), and data() :)
(: How often does Falstaff speak? Can we count the number of times? :)
(: Finally, let's write this with an XQuery FLWOR statement. :)

let $shakes:= collection('/db/apps/shakespeare/data/')
(: //TEI//sp[speaker="Falstaff"] => count() :)
let $speeches := $shakes//sp
let $falstaffs := $speeches[speaker = "Falstaff"]
let $countFals := $falstaffs => count()
let $falPlays := $shakes//TEI[descendant::sp[speaker="Falstaff"]]
for $f in $falPlays
let $fTitle := $f//titleStmt/title
let $fCount := $f//sp[speaker="Falstaff"] => count()
return concat("In this play, ", $fTitle, " the count of Falstaffs is: ", $fCount)


