xquery version "3.1";
declare variable $ThisFileContent :=
<html>
    <head><title>Blues Length</title></head>
    <body>
    <h1>Blues Length</h1>
    
    <table>
        <tr>
            <th>No.</th>
            <th>Title</th>
            <th>Artist</th>
            <th>Song Length</th>
                
        </tr>
    {
    let $blues := collection('/db/blues')
        for $b at $pos in $blues
        let $songTitle := $b//title
        let $songArtist := $b//artist
        let $songLength := $b//lyrics/string-length()
        return
        <tr>
            <td>{$pos}</td>
            <td>{$songTitle}</td>
            <td>{$songArtist}</td>
            <td>{$songLength}</td> 
               
        </tr> 
    }
    </table>
</body>
</html>;

let $fileName := "bluesArtistTable.html"
let $filePath := "/db/00-students-00/hadleigh/"
let $doc-db-uri := xmldb:store($filePath, $fileName, $ThisFileContent, "html")
return $doc-db-uri  
  (: output at :http://newtfire.org:8338/exist/rest/db/00-students-00/hadleigh/bluesArtistTable.html ) :)  