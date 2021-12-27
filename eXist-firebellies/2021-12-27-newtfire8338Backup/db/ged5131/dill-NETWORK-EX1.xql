xquery version "3.1";
declare variable $treefile := doc('/db/btrees/btrees_tree_book.xml');
declare variable $treeNodes := $treefile//entry;
declare variable $ThisFileContent:=
string-join(

for $t in $treeNodes
let $origins :=$t/origin/continent ! normalize-space()
(: There is only one entry per tree :)
let $cname := $t/cname ! normalize-space()
let $treeType := $t/treeType ! normalize-space()
let $treeID := $t/@xml:id ! normalize-space()
(: ged: I am having trouble printing out my XQuery. I am trying to create a for loop that grabs the cname and match it to the continent it is from and if the treeType shows a Correlation
 with it's origins :)
 
for $o in $origins

return concat($cname (:source node:), "&#x9;"(:tab character:), "tree name", "&#x9;"(:tab character:), $treeType (:edge connector:), "&#x9;"(:tab character:), "origin", "&#x9;"(:tab character:), $o), "&#10;");

(:  :$ThisFileContent:)
let $filename := "originNetwork.tsv"
let $doc-db-uri := xmldb:store("/db/ged5131", $filename, $ThisFileContent, "text/plain")
return $doc-db-uri :)
(: output at :http://newtfire.org:8338/exist/rest/db/ged5131/originNetwork.tsv) :) 