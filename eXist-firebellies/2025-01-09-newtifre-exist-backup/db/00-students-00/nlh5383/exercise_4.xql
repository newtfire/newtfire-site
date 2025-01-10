xquery version "3.1";
<html>
    <head>
        <title>Disney Songs to html and flower</title>
    </head>
    <body>
    <table>
        <tr>
            <th>Song</th><th>Composer</th><th>Length</th>
        </tr>
        {
        let $disneySongs := collection('/db/disneySongs/')/xml
        let $composerNodes := $disneySongs//composer
        let $composers := $disneySongs//composer ! normalize-space() => distinct-values()
        
        for $c in $composers
            let $cTitles := $disneySongs[descendant::composer ! normalize-space() = $c ]//metadata/title ! normalize-space() => distinct-values()
            let $cTitles := $disneySongs[descendant::composer ! normalize-space() = $c ]//metadata/title ! normalize-space() => distinct-values()
            let $bundleTitles := string-join($cTitles, ',')
            for $t in $cTitles
            return
                <tr>
                    <td>{$t}</td>
                    <td>{$c}</td>
                </tr>
        }
    </table>
    </body>
</html>