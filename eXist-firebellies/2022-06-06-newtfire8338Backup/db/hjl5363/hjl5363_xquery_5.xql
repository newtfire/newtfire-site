xquery version "3.1";
let $blues := collection('/db/blues')
return $blues
declare variable $ThisFileContent:=
    <html>
        {
        let $filename := "bluesArtistTable.html"
let $doc-db-uri := xmldb:store("/db/myOutput", $filename, $ThisFileContent, "html")
return $doc-db-uri  
        }
    </html>; 
 eXist-dB
    -->