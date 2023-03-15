xquery version "3.1";
(: This is a special example to show how to loop through a set of files :)
 (: and output a text file to save for each file in a collection:)
let $starWarsColl := collection('/db/starwars/fixed')
(: how about one text file for each script? :)
for $s in $starWarsColl
let $filename := $s/base-uri() ! tokenize(., '/')[last()] ! substring-before(., '.xml') ! concat(., '-stagedirs.txt')
let $thisFileContent := 
        let $stages := $s//sd ! normalize-space()
        return string-join($stages, "&#10;")
         (: We're using our newline character here to put a hard return between each stage direction's text :)
        
let $doc-db-uri := xmldb:store("/db/starwars-queries/textBlobs", $filename, $thisFileContent, "text/plain")
return $doc-db-uri 
  

        




