xquery version "3.1";
declare variable $ThisFileContent := string-join(
let $KingdomHearts := collection('/db/kingdomofhearts')
let $speakers := $KingdomHearts//sp//speaker[not(ancestor::cutscene)]
(:   :let $speakerNonPars := $speakers[matches(., "^[^(]+$")]/text()[matches(., "\S+")] ! normalize-space()
let $speakerPars := $speakers[matches(text(), "\s+\(.+?\)")] ! tokenize(., "\s+\(.+?\)")[1] ! normalize-space() 
ebb: I think we can isolate and clean up the speaker names in one step, below: :)
let $allSpeakers := $speakers/text()[matches(., "\S+")] ! tokenize(., "\s+\(.+?\)")[1] ! normalize-space() => distinct-values()
for $a in $allSpeakers
let $precedingCutscene := $speakers[tokenize(., "\s+\(.+?\)")[1] ! normalize-space() = $a]/preceding::cutscene[1]
(:  :let $followingCutscene := $speakers[tokenize(., "\s+\(.+?\)")[1] ! normalize-space() = $a]/following::cutscene :)
for $p at $pos in $precedingCutscene
let $gameTitle := $p ! tokenize(base-uri(), '/')[last()]
(: ebb: get title of the game where this dialogue is happening--pulling it from the file name. :)
let $oSpeakers := $p/following::speaker[not(ancestor::cutscene)]
(: ebb: Make sure these are NOT inside cut scenes :)
for $o in $oSpeakers
let $oRefined := ($o/text() ! tokenize(., "\s+\(.+?\)"))[1] ! normalize-space()
where $oRefined != $a and $o/preceding::cutscene[1] = $p and matches($o/text(), "\S+")
order by $a
return ($a || "&#x9;" || $gameTitle || "&#x9;" || "afterCut-" || $pos ||  "&#x9;" || $oRefined), "&#10;");
(: ebb: Let's try outputting the gameTitle as the edge interaction, but also grab "afterCut-pos" as an interaction attribute in case it's interesting to distinguish these :)

let $filename :="KHXBetweenCutsceneNetwork.tsv"
        let $doc-db-uri := xmldb:store("/db/kingdomofhearts-queries", $filename, $ThisFileContent, "text/plain")
        return $doc-db-uri

