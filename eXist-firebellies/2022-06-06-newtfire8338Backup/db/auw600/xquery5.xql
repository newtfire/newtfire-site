xquery version "3.1";
declare variable $ThisFileContent:=
<html>
<head><title>Artist, Title, and String Length</title></head>
<body>
    <h1>Artsts, Titles, and String Length</h1>
    <table>
    <tr><th>Artist name</th> <th>Song Title</th> <th>Length of Song</th> </tr>
{
let $blues := collection('/db/blues')
for $b in $blues
let $artist := $b//artist/text()
let $title := $b//title/text()
let $length := $b//lyrics/string-length()(:counting the length of each song:)
let $info := concat("artist = ", $artist,", title = ", $title,", string length = ",$length)
return 
   <tr>
       <td>{$artist}</td>
       <td>{$title}</td>
       <td>{$length}</td>
     </tr>
}
</table>
</body>
</html>;

let $filename := "bluesArtistTable.html"
let $doc-db-uri := xmldb:store("/db/auw600", $filename, $ThisFileContent, "html")
return $doc-db-uri  
  (: output at :http://newtfire.org:8338/exist/rest/db/auw600/bluesArtistTable.html ) :)  
