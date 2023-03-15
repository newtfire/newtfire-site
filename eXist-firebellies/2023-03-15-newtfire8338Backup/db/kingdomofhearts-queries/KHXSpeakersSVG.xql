xquery version "3.1";

let $KingdomHearts := collection('/db/kingdomofhearts')
let $cutscenes := $KingdomHearts//cutscene//sp
let $speeches := $KingdomHearts//sp [not(ancestor::cutscene)]
let $countSpeeches := $speeches => count()
let $countCutscenes := $cutscenes => count()
return ($countCutscenes || "&#x9;" || $countSpeeches)
