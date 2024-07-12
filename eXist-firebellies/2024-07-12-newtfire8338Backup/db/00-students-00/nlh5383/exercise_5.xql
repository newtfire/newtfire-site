xquery version "3.1";
declare variable $ThisFileContent:=
    <html>
        <head>
            <title>
                
            </title>
        </head>
        <body>
        <!--Your HTML file you're constructing here, complete with XQuery inside -->
        {
        
        
        }
        </body>
    </html>;
let $filename := "bluesArtistTable.html"
let $doc-db-uri := xmldb:store("/db/00-students-00/nlh5383/myOutput", $filename, $ThisFileContent, "html")
return $doc-db-uri  
  (: output at :http://newtfire.org:8338/exist/rest/db/myOutput/bluesArtistTable.html ) :)     