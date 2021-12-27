xquery version "3.1";
declare variable $ThisFileContent:=

string-join(
let $MPC := doc('/db/mqb5995/MPC-arj/mathPractCompStrings.xml')
let $strings := $MPC//string
for $s in $strings
return  
    $s, "&#10;" );
 
let $filename := "mathPractCompSeed.tsv"
let $doc-db-uri := xmldb:store("/db/mqb5995/MPC-arj/", $filename, $ThisFileContent, "text/plain")
return $doc-db-uri 

(:  :View this TSV at http://newtfire.org:8338/exist/rest/db/mqb5995/MPC-arj/mathPractCompSeed.tsv :)
