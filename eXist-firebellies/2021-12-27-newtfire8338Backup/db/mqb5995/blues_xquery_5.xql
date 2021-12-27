xquery version "3.1";
(:  :declare variable $ThisFileContent:=:)

<html>
    <head><title>Blues</title></head>
    <body>
        <h1>Artists, No. of Songs in Collection, and Longest String-Lengths</h1>
<table>
    <tr><th>Artist name</th> <th>No. of Songs</th> <th>Longest Song String Length</th> <th>Longest String Length Song Title</th></tr>

{
let $blues := collection('/db/blues')
let $metadata := $blues//metadata
let $artists := $blues//artist ! normalize-space => distinct-values() => sort()
let $lyrics := $blues//lyrics

for $a in $artists
let $songLength := $blues[.//artist ! normalize-space() = $a]//lyrics => string-length()

return 
   
   <tr>
       <td>{$a}</td>
       <td><ol>{for $s in $songLength
           return
               <li>{$s}</li>}</ol>
       </td>
       <td></td>
       <td></td>
       
     </tr>
}
</table>
</body>
</html>

(:  :let $filename := "bluesArtists.html"
let $doc-db-uri := xmldb:store("/db/mqb5995", $filename, $ThisFileContent, "html")
return $doc-db-uri :)
(:  :  :)
(:concat ($a, ": ", $songs)  :)
