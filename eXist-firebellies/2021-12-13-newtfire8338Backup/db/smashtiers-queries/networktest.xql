xquery version "3.1";

declare variable  $charList := doc('/db/smashtiers/supersmashtierlist.xml');
declare variable $ThisFileContent:=


    for $c in $charList
let $names:= $c//char/@id ! string(@id)
for $n in $names
let $game := $c//char[@id=$n]/game/@n ! data() =>distinct-values()
(:  :let $stringjoin := string-join($game,':'):)
 for $g in $game
 let $gn := 
 if ($g=1)
  then 'Super Smash Bros'
else if ($g=2)
then 'Super Smash Bros Melee'
else if ($g=3)
 then 'Super Smash Bros Brawl'
 else if ($g=4)
 then 'Super Smash Bros Four'
 else 'Super Smash Bros Ultimate'

for $g in $game
 let $tier := $c//char[@id=$n]/game[@n=$g]/@tier ! normalize-space ()
(:  :let $string := string-join($tier,':'):)
  let $distinctTiers := normalize-space($tier) 
  for $dt in $distinctTiers 
  return 
      concat($n , "&#x9;", "character", "&#x9;", $gn , "&#x9;", "tier", "&#x9;", $dt , "&#10;" );
  let $filename := "SuperSmashData2.tsv"
let $doc-db-uri := xmldb:store("/db/smashtiers-queries", $filename, $ThisFileContent, "text/plain")
return $doc-db-uri