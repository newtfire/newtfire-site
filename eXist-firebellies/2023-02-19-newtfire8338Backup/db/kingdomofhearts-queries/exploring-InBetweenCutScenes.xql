xquery version "3.1";
let $KingdomHearts := collection('/db/kingdomofhearts')
let $cutscenes := $KingdomHearts//cutscene
for $c at $pos in $cutscenes
let $gameTitle := $c ! base-uri() ! tokenize(., '/')[last()] ! substring-before(., '_script.xml')
let $followingSpeakers := $c/following::speaker[not(ancestor::cutscene)]
where $followingSpeakers/preceding::cutscene[1] = $c and count($followingSpeakers[./preceding::cutscene[1] = $c]) > 1
let $theseFollowing := string-join($followingSpeakers, ', ')
return ($gameTitle || ":afterCut " || $pos || ": " || $theseFollowing  )


