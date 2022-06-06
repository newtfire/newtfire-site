xquery version "3.1";
declare variable $ThisFileContent :=
<html>
    <head>
        <title>Kingdom Hearts 1.5 Cutscene Locations and Numbers</title></head>
    
<body>
    <h1>Cutscene Locations and Numbers</h1>
    
    <table>
        <tr>
            <th>Game Title</th>
            <th>Location</th>
            <th>Cutscene #'s</th>
        </tr>
{
let $kh1.5 := doc('/db/kingdomofhearts/KH1.5_XQuery_ExampleFile.xml')/*
let $gameTitle := $kh1.5//heading/gameInfo/gameTitle
let $cutscene := $kh1.5//cutscene
let $cutLocs := $cutscene/@location ! string()
let $distinctLocs := $cutLocs => distinct-values() => sort()
for $dl in $distinctLocs
let $dl-cutLocs := $cutscene[@location = $dl]
let $dl-cutNums := $dl-cutLocs/@cutNum ! string()
let $bundled-cutNums := string-join($dl-cutNums, ', ')
return 
    
    <tr>
        <td>{$gameTitle, ':'}</td>
        <td>{$dl}</td>
        <td><!-- {$bundled-carNames} --> 
            <ul>{for $cn in $dl-cutNums
                return
                    <li>{$cn}</li>
            }
            </ul>
        </td>
    </tr>
(:  :return concat($gameTitle, ', ', $dl, ": ", 'Cutscenes ', $bundled-cutNums) :)
}
    </table>
    
</body>

</html>;

let $filename := "kh1.5CutscenesTable.html"
let $doc-db-uri := xmldb:store("/db/ajm7408/FA2021", $filename, $ThisFileContent, "html")
return $doc-db-uri
(: Output at http://newtfire.org:8338/exist/rest/ajm7408/FA2021/kh1.5CutscenesTable.html :)



(:  :for $c in $cutscene
let $type := $c/@type ! data()
let $cutNum := $c/@cutNum ! data()
let $loc := $c/@location ! data()
order by $loc
return concat($gameTitle, ', ', 'Cutscene ', $cutNum, ': ', $type, ', ', $loc) :)