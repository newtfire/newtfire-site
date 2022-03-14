xquery version "3.1";
declare variable $ThisFileContent:=
string-join(
let $kh1.5 := doc('/db/kingdomofhearts/FA2021_Scripts/FA2021_Kingdom_hearts_1.5_script.xml')/*
let $cutscene := $kh1.5//cutscene
for $c in $cutscene
let $type := $c/@type ! data()
let $locations := $c/@location ! data()
let $speakers := $c/sp/speaker/text() ! tokenize(., '\s\(')[1] ! normalize-space() => distinct-values()
for $s in $speakers
let $sCount := $c//speaker[. ! tokenize(., '\s\(')[1] ! normalize-space() = $s] => count()
return 
    ($s || "&#x9;" || "speakers" || "&#x9;" || $sCount || "&#x9;" || $type || "&#x9;" || "location" || "&#x9;" || $locations), "&#10;" );
    
let $filename := "FA2021_KH1.5Network.tsv"
let $doc-db-uri := xmldb:store("/db/kingdomofhearts-queries", $filename, $ThisFileContent, "text/plain")
return $doc-db-uri
(: output at :http://newtfire.org:8338/exist/rest/db/kingdomofhearts-queries/FA2021_KH1.5Network.tsv) :)        