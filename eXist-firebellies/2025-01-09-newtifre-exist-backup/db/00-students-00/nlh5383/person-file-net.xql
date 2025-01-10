xquery version "3.1";
declare variable $ThisFileContent :=
        let $letStringJoin := string-join(
        let $conspiracyList := collection('/db/conspiracy')
        for $c in $conspiracyList
            let $names := $c//ent[@type='PERSON']/text() => distinct-values()
            let $file := $c ! base-uri() ! tokenize(. , "/")[last()] ! substring-before(., '.xml')
            for $n in $names
                return concat($n, "&#x9;", "person", "&#x9;", $file, "&#x9;", "file"),"&#10;"
                )
return $letStringJoin;

let $filename := "person-file-net.tsv"
let $doc-db-uri := xmldb:store("/db/00-students-00/nlh5383/", $filename, $ThisFileContent, "text/plain")
return $doc-db-uri
(: output at http://exist.newtfire.org/exist/rest/db/myOutput/MyNetworkData.tsv ) :)        
      

