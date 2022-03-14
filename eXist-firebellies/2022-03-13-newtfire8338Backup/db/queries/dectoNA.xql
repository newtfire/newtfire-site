xquery version "3.0";
declare default element namespace "http://www.tei-c.org/ns/1.0"; 
declare variable $ThisFileContent := 

  string-join( 
let $engdecameron := doc('/db/decameron/engDecameronTEI.xml')/*
let $engpeople := $engdecameron//persName
let $engdistinctPs := distinct-values($engpeople)
for $edp in $engdistinctPs
let $peers:= 
    if ($engpeople[. = $edp]/ancestor::floatingText[@type="frame"]) 
        then distinct-values($engpeople[. = $edp]/ancestor::floatingText//persName[not(. = $edp)])
   else if ($engpeople[. = $edp]/ancestor::div[@type="novella"]) 
        then distinct-values($engpeople[. = $edp]/ancestor::div[@type="novella"]//persName[not(. = $edp)])
   else distinct-values($engpeople[. = $edp]/ancestor::div[1]//persName[not(. = $edp)])

let $edgeType:=
    if ($engpeople[. = $edp]/ancestor::floatingText[@type="frame"]) 
        then "floatingFrame"
    else if ($engpeople[. = $edp]/ancestor::div[@type="novella"]) 
        then "novella"
    else "frame"

let $edgeWeight:=
    if ($engpeople[. = $edp]/ancestor::floatingText[@type="frame"]) 
        then count($engpeople[. = $edp]/ancestor::floatingText//persName[not(. = $edp)])
   else if ($engpeople[. = $edp]/ancestor::div[@type="novella"]) 
        then count($engpeople[. = $edp]/ancestor::div[@type="novella"]//persName[not(. = $edp)])
   else count($engpeople[. = $edp]/ancestor::div[1]//persName[not(. = $edp)])

for $peer in $peers
return
   
 concat($edp, "&#x9;", $edgeType, "&#x9;", $edgeWeight, "&#x9;", $peer), " &#10;");
 
 let $filename := "decOutput.tsv"
let $doc-db-uri := xmldb:store("/db/queries/op", $filename, $ThisFileContent, "text/plain")
return $doc-db-uri
(: output at :http://dxcvm05.psc.edu:8080/exist/rest/db/queries/op/decOutput.tsv ) :)
