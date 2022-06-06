xquery version "3.1";
declare variable $ThisFileContent:=
<html>
    <head><title>The Blues</title></head>
    <body>
        <h1>Blues</h1>
        <table>
            <tr><th>Title</th><th>Artist</th><th>Lyrics</th><th>String Count</th></tr>
{
    let $blues := collection('/db/blues')
    for $b in $blues
        let $title := $b//metadata/title ! normalize-space()
        let $artist := $b//metadata/artist ! normalize-space()
        let $lyrics := $b//xml/lyrics ! normalize-space()
        let $stringCount := $lyrics ! string-length()
            return
                <tr>
          <td>{$title}</td><td>{$artist}</td><td>{$lyrics}</td><td>{$stringCount}</td>
               
        </tr> 
}
</table>
</body>
</html>;
let $filename := "bluesArtistTable.html"
let $doc-db-uri := xmldb:store("/db/jjg6486", $filename, $ThisFileContent, "html")
return $doc-db-uri  