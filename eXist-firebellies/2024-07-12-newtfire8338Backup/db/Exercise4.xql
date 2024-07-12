xquery version "3.1";

<html>
    <head>
        <title>Composers and Songs</title>
    </head>
    <body>
        <h1>Composers and Songs in the Disney Songs Collection</h1>
        
        <table>
            <thead>
                <tr>
                    <th>No.</th>
                    <th>Composer</th>
                    <th>Performer</th>
                    <th>List of Songs</th>
                </tr>
            </thead>
            <tbody>
            {
                let $disneySongs := collection('/db/disneySongs/')
                let $composers := $disneySongs//composer ! normalize-space() => distinct-values() => sort()
                for $c at $pos in $composers
                let $cTitles := $disneySongs[.//composer ! normalize-space() = $c]//title ! normalize-space() => distinct-values() => sort() => string-join(', ')
                return 
                    <tr>
                        <td>{$pos}</td>
                        <td>{$c}</td>
                        <td>{$disneySongs[.//composer[normalize-space() = $c]]//voiceActor[normalize-space() = "#Aladdin" or normalize-space() = "#Belle"]/normalize-space()}</td>
                        <td>{$cTitles}</td>
                    </tr> 
            }
            </tbody>
        </table>
    </body>
</html>