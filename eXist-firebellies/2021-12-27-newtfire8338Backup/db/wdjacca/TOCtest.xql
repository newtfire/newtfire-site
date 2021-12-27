xquery version "3.1";
declare variable $ThisFileContent :=
<html>
    <head><title>Metadata</title></head>
    <body>
    <h1>MetaData</h1>
    
    <table>
        <tr><th>Movie</th><th><table><tr><th> Song Title </th><th> Composer </th><th> Voice Actor </th><th> Character </th></tr></table></th></tr>
    {
    let $collection := collection('/db/disneySongs/')
    let $movie := $collection//movie ! normalize-space() => distinct-values ()
    for $m in $movie
    let $songTitle := $collection[.//movie=$m]//title/text() 
    let $songcount := $songTitle => count()
    
        return
       <tr>
          <td>{$m}</td>
                <td><table>{
                for $s in $songTitle
                    let $comp := $collection[.//title = $s]//composer ! normalize-space() => distinct-values()
                    let $voice := $collection[.//title = $s]//voiceActor ! normalize-space() => distinct-values()

                    return <tr>
                    <td>{$s}</td><td><ul>{for $c in $comp return <li>{$c}</li>}</ul></td>
                    <td><ul>{for $v in $voice return <li>{$v}</li>}</ul></td>
                    <td><ul>{for $v in $voice
                                let $char := $collection//voiceActor[. ! normalize-space() = $v] /@role ! normalize-space() ! substring-after(.,"#") => distinct-values()
                                        return <li>{$char}</li>}</ul></td>
                    </tr>
                }</table></td>
        </tr>} 
   </table>
</body>
</html>
;let $filename := "TOCTest.html"
let $doc-db-uri := xmldb:store("/db/wdjacca/", $filename, $ThisFileContent)
return $doc-db-uri
(: View this text file at http://newtfire.org:8338/exist/rest/db/wdjacca/TOCTest.html  :)
