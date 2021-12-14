xquery version "3.1";
declare variable $ThisFileContent :=
string-join(
let $mayan := doc('/db/mayan/sitesIndex.xml')/*
let $godIndex := doc('/db/mayan/PV_characterIndex.xml')
let $mayanSite := $mayan//site
let $gods := $mayanSite//deityName/@godID ! normalize-space() => distinct-values() 
for $g in $gods
let $godID := substring-after($g, "#")
let $godName := $godIndex//id($godID)/name ! string()
let $sites := $mayanSite[.//deityName/@godID ! normalize-space() = $g]
for $s in $sites
let $siteName := $s/name ! string()
let $relics := $s//relic
let $structures := $s//building
let $contexts := ($relics, $structures)
for $c in $contexts
where $c//deityName/@godID ! normalize-space() = $g
let $contextType := $c/@type ! normalize-space()
let $contextName := $c/name ! string()
return 
    concat($godID, "&#x9;",  $godName, "&#x9;", "god", "&#x9;", $siteName, "&#x9;", "site", "&#x9;", $contextType, "&#x9;", $contextName), "&#10;");


let $filename := "network_godRelationships.tsv"
let $doc-db-uri := xmldb:store("/db/mayan-queries/", $filename, $ThisFileContent, "text/plain")
return $doc-db-uri

(:  :View this TSV at http://newtfire.org:8338/exist/rest/db/mayan-queries/network_godRelationships.tsv :)



