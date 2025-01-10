xquery version "3.1";

declare variable $ThisFileContent:= string-join(
let $KingdomHearts := collection('/db/kingdomofhearts')
let $cutscenes := $KingdomHearts//cutscene//sp
let $speakers := $cutscenes//speaker
let $speakerNonPars := $speakers[matches(., "^[^(]+$")]/text()[matches(., "\S+")]
let $speakerPars := $speakers[matches(text(), "\s+\(.+?\)")] ! tokenize(., "\s+\(.+?\)")[1] ! normalize-space()
let $allSpeakers := ($speakerNonPars, $speakerPars) => distinct-values()
for $a in $allSpeakers
let $aCuts := $KingdomHearts//cutscene[descendant::speaker ! tokenize(., "\s+\(.+?\)")[1] ! normalize-space() = $a]
for $c at $pos in $aCuts
let $oSpeakers := $c//speaker/text()[matches(., "\S+")] ! tokenize(., "\s+\(.+?\)") => distinct-values()
for $o in $oSpeakers
where $o != $a and matches($o, "\S+")
return ($a || "&#x9;" || "cut" || $pos || "&#x9;" || $o), "&#10;");
(:  :$ThisFileContent:)

        let $filename :="KHXCutsceneNetwork.tsv"
        let $doc-db-uri := xmldb:store("/db/kingdomofhearts-queries", $filename, $ThisFileContent, "text/plain")
        return $doc-db-uri
        
    (: Output at http://newtfire.org:8338/exist/rest/db/kingdomofhearts-queries/KHXCutsceneNetwork.tsv :)  