xquery version "3.1";
declare variable $radio := collection('/db/holmes/radio-scripts/');
declare variable $lns := $radio//ln[.//mention];
declare variable $thisFileContent:=
string-join(
for $l in $lns
let $mentions := $l//mention
for $m in $mentions
let $speaker:= $l[.//mention =$m]/speaker ! normalize-space()
let $ref := $m/@ref ! normalize-space()
return concat ( $speaker, '&#9;', $ref ! normalize-space() ! upper-case(.),'&#9;', $m ! normalize-space() ! upper-case(.),"&#10;"));
let $filename := "mentions_network.tsv"
let $doc-db-uri := xmldb:store("/db/wdjacca/radio_holmes", $filename, $thisFileContent, 'text/plain')
return $doc-db-uri   
(: View this xml at http://newtfire.org:8338/exist/rest/db/disneySongs-queries/listofRef.xml:)



