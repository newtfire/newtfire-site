xquery version "3.1";
declare variable $ThisFileContent:=
    <html>
        <body>
            <ul>
                {
                
                
                }
            </ul>
        </body>
    </html>;

let $filename := "bluesArtistTable.html"
let $doc-db-uri := xmldb:store("/db/edm5282", $filename, $ThisFileContent, "html")
let $blues := collection('/db/blues')
  (: output at :http://newtfire.org:8338/exist/rest/db/myOutput/bluesArtistTable.html ) :)    
let $blues := collection('/db/blues')
return $blues
  
