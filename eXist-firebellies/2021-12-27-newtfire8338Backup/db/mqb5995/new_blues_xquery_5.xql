xquery version "3.1";
declare variable $ThisFileContent:=

<html>
    <head><title>Blues</title></head>
    <body>
        <h1>Artists, Song Titles, and Song Info Text</h1>
<table>
    <tr><th>Artist name</th><th>Song Titles List</th> <th>Song Info</th></tr>

{
let $blues := collection('/db/blues')
let $metadata := $blues//metadata
let $bessie := $blues//artist[. ! normalize-space() = "Bessie Smith"]
let $artists := $blues//artist ! normalize-space() => distinct-values() => sort()
for $a in $artists
let $songs := $blues[.//artist ! normalize-space() = $a]//title
let $lyricStrings := $blues[.//artist ! normalize-space() = $a]//lyrics
let $songInfo := $blues[.//artist ! normalize-space() = $a]//songInfo
return 
   
   <tr>
       <td>{$a}</td>
       <td><ol>{for $s in $songs 
       return
           <li>{$s/text()}</li>
       }
           </ol>
       </td>
       <td><ul>{for $i in $songInfo
           return
               <li>{$i/text()}</li>
       }
       </ul></td>
     </tr>
}
</table>
</body>
</html> ;

let $filename := "bluesSongInfo.html"
let $doc-db-uri := xmldb:store("/db/mqb5995", $filename, $ThisFileContent, "html")
return $doc-db-uri
