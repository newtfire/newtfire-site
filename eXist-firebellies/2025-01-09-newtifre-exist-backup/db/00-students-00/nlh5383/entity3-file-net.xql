xquery version "3.1";
(: ebb: I think you're right that files on the outside are the best strategy for the nested loops. :)
(: We want to simplify this to return counts of names in each loop.:)
declare variable $ThisFileContent :=
        let $letStringJoin := string-join(
        let $conspiracyList := collection('/db/conspiracy')
            let $names := $conspiracyList//ent/text() => distinct-values()
            (: N :let $file := $c ! base-uri() ! tokenize(. , "/")[last()] ! substring-before(., '.xml') :)
            for $n in $names
                let $entMatches := $conspiracyList//ent[. = $n] 
                let $type := $entMatches[1]/@type ! string()
                let $files := $entMatches/ancestor::xml
                let $fileCount := $files => count()
                for $f in $files
                    let $filename := $f ! base-uri() ! tokenize(. , "/")[last()] ! substring-before(., '.xml')
                    let $count := $f//ent[. = $n] => count()
                    order by $count descending 
                (: ebb: just so we can see the counts more clearly on each file from most to least :)
         return concat($n, "&#x9;", $type, "&#x9;", $filename, "&#x9;", $count),"&#10;"
                )
return $letStringJoin;


let $filename := "ent3-file-net.tsv"
let $doc-db-uri := xmldb:store("/db/00-students-00/nlh5383/", $filename, $ThisFileContent, "text/plain")
return $doc-db-uri
  
         
(: output at http://exist.newtfire.org/exist/rest/db/00-students-00/nlh5383/ent3-file-net.tsv ) :)        
      

