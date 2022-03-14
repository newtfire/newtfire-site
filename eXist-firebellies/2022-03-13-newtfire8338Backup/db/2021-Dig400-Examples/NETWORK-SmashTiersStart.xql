xquery version "3.1";
declare variable $charfile := doc('/db/smashtiers/supersmashtierlist.xml');
(:   :declare variable $ThisFileContent:=
string-join(); :)
let $charNodes := $charfile//char
let $charIDs := $charNodes/@id ! normalize-space() 
(: There is only one entry per character, so taking distinct values isn't helpful here. There are 83 characters :)

for $c in $charNodes
(: Let's loop over the nodes so it's easy to reach inside them. :)
let $cID := $c/@id ! normalize-space()
let $games := $c/game
(: This gets us all the game info for each character. Again, best that we loop over the nodes. :)
for $g in $games
(: I think we don't need this:
 :   :let $otherChars := $charfile//char[descendant::game/@n ! string() = $g][not(. = $c)]/@id ! normalize-space() :)
 
(: If we want to, we could build a network based on game connections and shows the game numbers, AND the tiers that connect the characters :)
let $tier := $g/@tier ! normalize-space()
let $gameNum := $g/@n ! normalize-space()
let $gNum := concat("game", $gameNum)
 
return
 concat($cID (:source node:), "&#x9;"(:tab character:), "character", "&#x9;"(:tab character:), $gNum (:edge connector:), "&#x9;"(:tab character:), "tier", "&#x9;"(:tab character:), $tier (:target node:))   




