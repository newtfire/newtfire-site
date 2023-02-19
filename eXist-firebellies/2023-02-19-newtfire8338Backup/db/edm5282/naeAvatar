xquery version "3.1";
declare variable $textFile := 
string-join(
let $avatarEpisodes := collection('/db/avatar/TransformedScripts/')
let $speakers := $avatarEpisodes//speech/@speaker ! normalize-space() => distinct-values()
for $s in $speakers
let $sTitles := $avatarEpisodes[.//speech/@speaker ! normalize-space() = $s]//metadata/title ! normalize-space()
for $t in $sTitles
let $aSpeakers := $avatarEpisodes[.//speech/@speaker ! normalize-space() = $s]//speech[not(@speaker ! normalize-space() = $s)]/@speaker ! normalize-space()
for $a in $aSpeakers
return 
    concat("SourceSpeaker", "&#x9;", $s, "episode", "&#x9;", $t, "&#x9;", "otherCharacter", "&#x9;", $a), "&#10;");
$textFile
