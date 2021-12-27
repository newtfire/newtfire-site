xquery version "3.1";
declare variable $charfile := doc('/db/smashtiers/supersmashtierlist.xml');
declare variable $ThisFileContent:=
string-join(
let $charNodes := $charfile//char
let $charIDs := $charNodes/@id ! normalize-space() 


for $c in $charNodes
let $cID := $c/@id ! normalize-space()
let $games := $c/game

for $g in $games
let $tier := $g/@tier ! normalize-space()
let $gameNum := $g/@n ! normalize-space()
let $gNum := concat("game", $gameNum)
 
return
 concat($cID (:source node:), "&#x9;"(:tab character:), "character", "&#x9;"(:tab character:), $gNum (:edge connector:), "&#x9;"(:tab character:), "tier", "&#x9;"(:tab character:), $tier (:target node:)),"&#10;");
  
  
  
  
 let $filename := "cytoscape-attempt-2-11-21.tsv"
let $doc-db-uri := xmldb:store("/db/sao5303", $filename, $ThisFileContent, "text/plain")
return $doc-db-uri
(: output at :http://newtfire.org:8338/exist/rest/db/myOutput/MyNetworkData.tsv ) :)  