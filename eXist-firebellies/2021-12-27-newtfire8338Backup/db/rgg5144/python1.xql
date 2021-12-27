xquery version "3.1";
declare variable $ThisFileContent := string-join( 
let $twilight := doc('/db/zelda/twilight_princess.xml')
let $act := $twilight//act[5]
let $chapter := $act//chapter[1]/*[string-length() > 0] ! lower-case(.) ! normalize-space() => distinct-values()
return $chapter ! string(), "&#10;") ;


let $filename := "Python1.txt"
let $doc-db-uri := xmldb:store("/db/rgg5144/", $filename, $ThisFileContent, "text/plain")
return $doc-db-uri 
(: View this text file at http://newtfire.org:8338/exist/rest/db/rgg5144/Python1.txt  :)
