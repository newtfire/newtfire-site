xquery version "3.1";
declare variable $ThisFileContent :=
string-join(
let $disneySongs := collection('/db/disneySongs')
(: See XQuery Ex 3 for a quick representation of the Disney Songs XML code. 
 : For this example, let's try a network of voiceActors and composers based on the movies they appear in, pulled from the XML files. This will be a network of string values drawn via distinct-values.:)
let $voiceActors := $disneySongs//voiceActor ! normalize-space() => distinct-values()
for $v in $voiceActors
   let $vMovies := $disneySongs[.//voiceActor ! normalize-space() = $v]//movie ! normalize-space() => distinct-values()
   for $m in $vMovies
      let $composers := $disneySongs[.//movie ! normalize-space() = $m]//composer ! normalize-space() => distinct-values()
       for $c in $composers
return 
    concat($v, "&#x9;", "voiceActor", "&#x9;", $m, "&#x9;", $c, "&#x9;", "composer"), "&#10;") ;
(: I am adding text strings to help associate classifying info to my source and target nodes. 
 : I can use these as "attribute" labels in Cytoscape to help differentiate their styling on my network visualization. :)

let $filename := "disneyVA-Comp-network.tsv"
let $doc-db-uri := xmldb:store("/db/2021-ClassExamples/", $filename, $ThisFileContent, "text/plain")
return $doc-db-uri
(: View this TSV (text/plain) file at http://newtfire.org:8338/exist/rest/db/2021-ClassExamples/disneyVA-Comp-network.tsv  :)

   


