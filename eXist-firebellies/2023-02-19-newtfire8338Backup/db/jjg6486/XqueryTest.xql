xquery version "3.1";
declare variable $ThisFileContent:=
<html>
    <head>
        <title>StarWars Info</title>
        </head>
    <body>
        <h1>StarWars Draft Info</h1>
        <table>
            <tr><th>Number</th><th>Number of Speeches</th><th>Number of Distinct Speakers</th></tr>
{
let $drafts := collection('/db/starwars/fixed/')
let $sortOrder := 
    for $d in $drafts
        let $date := $d//date/@date ! data()
        order by $date
            return $d
for $s at $pos in $sortOrder
    let $sTitle := $s//xml/metadata/draft ! normalize-space()
    let $sDate := $s//xml/metadata/date/@date ! normalize-space()
    let $sSpeechC := $s//xml//sp => count()
    let $sSpeekerC := $s//xml//sp/@spk ! normalize-space() => distinct-values() =>count()
        (:return concat($pos, ".) ", $sTitle, ", ", $sDate,", ", "Number of Speeches: ", $sSpeechC, ", ", "Number of Distinct Speakers: ", $sSpeekerC):)
        return
            <tr>
                <td>{$pos}</td><td>{$sSpeechC}</td><td>{$sSpeekerC}</td>
                    

</tr>
}
</table>
</body>
</html>;
let $filename := "starWarsTable.html"
let $doc-db-uri := xmldb:store("/db/jjg6486", $filename, $ThisFileContent, "html")
return $doc-db-uri  
