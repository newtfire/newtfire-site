xquery version "3.1";
declare variable $charfile := doc('/db/smashtiers/supersmashtierlist.xml');
declare variable $ThisFileContent:=

string-join(
let $charNodes := $charfile//char
(: There is only one entry per character, so taking distinct values isn't helpful here. There are 83 characters :)

for $c in $charNodes
(: Let's loop over the nodes so it's easy to reach inside them. :)
let $cID := $c/@id ! normalize-space()
let $games := $c/game
(: This gets us all the game info for each character. Again, best that we loop over the XML nodes and don't convert to string values, etc. yet. :)
for $g in $games
(: If we want to, we could build a network based on game connections and shows the game numbers, AND the tiers that connect the characters :)
let $tier := $g/@tier ! normalize-space()
let $gameNum := $g/@n ! normalize-space()
let $gNum := concat("game", $gameNum)
 
return
 concat($cID (:source node:), "&#x9;"(:tab character:), "character", "&#x9;"(:tab character:), $gNum (:edge connector:), "&#x9;"(:tab character:), "tier", "&#x9;"(:tab character:), $tier (:target node:)), "&#10;" );
 

(: That last  "&#10;") is the line feed character being set at the end of each line. We create one string to output into a TSV file. :)
let $filename := "SuperSmashData.tsv"
let $doc-db-uri := xmldb:store("/db/2021-Dig400-Examples", $filename, $ThisFileContent, "text/plain")
return $doc-db-uri
(: output at :http://newtfire.org:8338/exist/rest/db/2021-Dig400-Examples/SuperSmashData.tsv) :)        

