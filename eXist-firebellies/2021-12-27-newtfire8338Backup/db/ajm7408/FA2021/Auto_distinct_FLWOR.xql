xquery version "3.1";
let $autoColl := collection('/db/auto/')/*
let $entries := $autoColl//entry
let $builtYears := $entries/built/@when ! string()
let $distinctYears := $builtYears => distinct-values()
for $dy in $distinctYears
let $dy-cars := $entries[descendant::built[@when = $dy]]
let $dy-carNames := $dy-cars//name ! string()
let $bundled-carNames := string-join($dy-carNames, ', ')
return concat($dy, ": ", $bundled-carNames)