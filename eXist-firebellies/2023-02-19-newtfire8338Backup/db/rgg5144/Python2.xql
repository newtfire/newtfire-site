xquery version "3.1";
declare variable $ThisFileContent := string-join( 
let $twilight := doc('/db/zelda/twilight_princess.xml')
let $act := $twilight//act
let $stage := $twilight//stage ! normalize-space()
let $choice := $act//choice ! normalize-space()
let $interact := $act//interact ! normalize-space() 
let $sp := $act//sp/text() ! normalize-space() => distinct-values()
let $character := $act//character ! normalize-space()=> distinct-values()
let $combine := ($stage, $interact, $sp)
return $combine, "&#10;") ;


let $filename := "Python2.txt"
let $doc-db-uri := xmldb:store("/db/rgg5144/", $filename, $ThisFileContent, "text/plain")
return $doc-db-uri 
(: View this text file at http://newtfire.org:8338/exist/rest/db/rgg5144/Python2.txt  :)
