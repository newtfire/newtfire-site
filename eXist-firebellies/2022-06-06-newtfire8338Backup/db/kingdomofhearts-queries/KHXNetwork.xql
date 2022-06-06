xquery version "3.1";
(: Idea: Try a simple co-occurrence network that looks to the first or second preceding::speaker and to the first or second following::speaker and output a concatenated line for each connection. For example, which characters turn up the most frequently nearby Sora? :)
declare variable $ThisFileContent:= string-join(
let $KingdomHearts := collection('/db/kingdomofhearts')
let $speakers := $KingdomHearts//speaker
let $speakerNonPars := $speakers[matches(., "^[^(]+$")]/text()[matches(., "\S+")]
let $speakerPars := $speakers[matches(text(), "\s+\(.+?\)")] ! tokenize(., "\s+\(.+?\)")[1] ! normalize-space() 
(: ebb: Some of your speakers have untagged parentheses in them, as in <speaker>Sora (thinking)</speaker>. So this $speakerPars variable collects those and gets just the name before the parentheses. :)
let $allSpeakers := ($speakerPars, $speakerNonPars) => distinct-values()
for $a in $allSpeakers
let $gameTitles := $KingdomHearts[descendant::speaker/text() ! tokenize(., "\s+\(.+?\)")[1] ! normalize-space() = $a]//title
for $g in $gameTitles
(: ebb: Let's see if we can find the first preceding:: and first following:: speaker every time $a turns up in each game. :)
let $aLocated := $KingdomHearts[descendant::title = $g]//speaker[tokenize(text(), "\s+\(.+?\)")[1] ! normalize-space() = $a]
let $aPrecedingOne := $aLocated/preceding::speaker[1]/text()[matches(., "\S+")] ! tokenize(., "\s+\(.+?\)")[1] ! normalize-space() => distinct-values()
let $aFollowingOne := $aLocated/following::speaker[1]/text()[matches(., "\S+")] ! tokenize(., "\s+\(.+?\)")[1] ! normalize-space() => distinct-values()
let $neighborSpeakers := ($aPrecedingOne, $aFollowingOne)
for $n in $neighborSpeakers
where $n != $a
return ($a (: Speaker (source node) :) || "&#x9;"  ||  $g (: game title (interaction) :)  || "&#x9;" ||  $n) , "&#10;");

(:   :$ThisFileContent :)

        let $filename :="KHXNetwork.tsv"
        let $doc-db-uri := xmldb:store("/db/kingdomofhearts-queries", $filename, $ThisFileContent, "text/plain")
        return $doc-db-uri


(: Output at http://newtfire.org:8338/exist/rest/db/kingdomofhearts-queries/KHXNetwork.tsv   :)


