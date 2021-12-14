xquery version "3.1";
declare variable $ThisFileContent :=
<html>
    <head> 
        <title> Blues Singers </title>
</head>

<body>
    <table>
        <tr><th>Artist</th><th>Title</th><th>Lyrics</th></tr>
        {
let $blues := collection('/db/blues')
let $count := $blues//metadata ! normalize-space() => distinct-values() => sort()
for $b at $pos in $count
let $bArtists := $blues[.//metadata ! normalize-space() = $b]//artist ! normalize-space() => distinct-values() => sort() => string-join(', ')
let $bTitle := $blues[.//metadata ! normalize-space() = $b]//title ! normalize-space() => distinct-values() => sort() => string-join(', ')
let $bLyrics := $blues[.//metadata ! normalize-space() = $b]//lyrics ! normalize-space() => distinct-values() => sort() => string-join(', ')

return
    <tr>
         <td>{$pos}</td><td>{$bArtists}</td><td>{$bTitle}</td><td>{$bLyrics}</td>
        </tr>
}
</table>
</body>
</html> ;


let $filename := "RachelBlues.html"
let $doc-db-uri := xmldb:store("/db/rgg5144", $filename, $ThisFileContent, "html")
return $doc-db-uri 
(:  :output at :http://newtfire.org:8338/exist/rest/db/rgg5144/RachelBlues.html  :)