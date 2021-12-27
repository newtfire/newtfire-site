xquery version "3.1";
declare variable $ThisFileContent := string-join( 
let $grimm := doc('/db/grimm/fairyTales.xml')
let $chapters := $grimm//chapter
let $wordsOfInterest := $chapters//p/*[string-length() > 0] ! lower-case(.) ! normalize-space() => distinct-values()
return $wordsOfInterest, "&#10;") ;
 
let $filename := "grimmWordList.txt"
let $doc-db-uri := xmldb:store("/db/2021-ClassExamples/", $filename, $ThisFileContent, "text/plain")
return $doc-db-uri 
(: View this text file at http://newtfire.org:8338/exist/rest/db/2021-ClassExamples/grimmWordList.txt  :)
