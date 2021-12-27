xquery version "3.1";
declare variable $ThisFileContent :=
string-join(
let $blues := collection('/db/blues')
let $performers := $blues//artist ! normalize-space() => distinct-values() => sort()

let $KebMo := $blues[.//artist ! normalize-space() => distinct-values() = "Keb' Mo'"]//l/text()

let $StevieRV := $blues[.//artist ! normalize-space() => distinct-values() = "Stevie Ray Vaughan"]//l/text()

let $ZZTop := $blues[.//artist ! normalize-space() => distinct-values() = "ZZ Top"]//l/text()

let $JanisJop := $blues[.//artist ! normalize-space() => distinct-values() = "Janis Joplin"]//l/text()

let $AlCollins := $blues[.//artist ! normalize-space() => distinct-values() = "Albert Collins"]//l/text()

let $HowlinWolf := $blues[.//artist ! normalize-space() => distinct-values() = "Howlin' Wolf"]//l/text()

let $MudWaters := $blues[.//artist ! normalize-space() => distinct-values() = "Muddy Waters"]//l/text()

let $traditionalPerform := $blues[.//songwriter/name ! normalize-space() => distinct-values() = "traditional"]//artist

let $BlindLemon := $blues[.//artist ! normalize-space() => distinct-values() = "Blind Lemon Jefferson"]//l/text()

return $BlindLemon) ;


let $filename := "BlindLemonLyr.txt"
let $doc-db-uri := xmldb:store("/db/mqb5995", $filename, $ThisFileContent, "text/plain")
return $doc-db-uri
(: KEB MO output: http://newtfire.org:8338/exist/rest/db/mqb5995/KebMoLyr.txt 
 : STEVIE RAY VAUGHAN output: http://newtfire.org:8338/exist/rest/db/mqb5995/StevieRVLyr.txt
 : ZZ TOP output: http://newtfire.org:8338/exist/rest/db/mqb5995/ZZTop.txt
 : JANIS JOPLIN output: http://newtfire.org:8338/exist/rest/db/mqb5995/JanisJoplinLyr.txt
 : HOWLIN WOLF output: http://newtfire.org:8338/exist/rest/db/mqb5995/HowlinWolfPERFORMlyr.txt
 : MUDDY WATERS output: http://newtfire.org:8338/exist/rest/db/mqb5995/MudWatersPERFORMlyr.txt
 : BLIND LEMON JEFFERSON output: http://newtfire.org:8338/exist/rest/db/mqb5995/BlindLemonLyr.txt
 : :)



(:  :for $p in $performers
    let $songs := $blues[.//artist ! normalize-space() => distinct-values() = $p]//lyrics/l
    let $titles := $songs//title
    let $lyrics := $songs//lyrics/l
    let $countPerformerSongs := $blues[.//artist ! normalize-space() => distinct-values() = $p] => count()
    
    

return concat ($p, " performed ", $countPerformerSongs):)