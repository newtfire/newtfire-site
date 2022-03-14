xquery version "3.1";

let $auto := collection('/db/auto/')
for $a in $auto
let $name := $a//name
let $builtYr := $a//built/@when ! string() => distinct-values()
let $info := concat("year= ",$builtYr,", name= ",$name)
order by $builtYr ascending
return $info