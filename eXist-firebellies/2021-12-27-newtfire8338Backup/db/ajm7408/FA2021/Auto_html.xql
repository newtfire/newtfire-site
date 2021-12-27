xquery version "3.1";
declare variable $ThisFileContent :=
<html>
    <head>
        <title>Years and Cars Manufactured</title></head>
    
<body>
    <h1>Years When Cars Were Manufactured</h1>
    
    <table>
        <tr>
            <th>Years</th>
            <th>Cars Manufactured</th>
        </tr>
{
let $autoColl := collection('/db/auto/')/*
let $entries := $autoColl//entry
let $builtYears := $entries/built/@when ! string()
let $distinctYears := $builtYears => distinct-values() => sort()
for $dy in $distinctYears
let $dy-cars := $entries[descendant::built[@when = $dy]]
let $dy-carNames := $dy-cars//name ! string()
let $bundled-carNames := string-join($dy-carNames, ', ')
return 
    
    <tr>
        <td>{$dy}</td>
        <td><!-- {$bundled-carNames} --> 
            <ul>{for $n in $dy-carNames
                return
                    <li>{$n}</li>
            }
            </ul>
        </td>
    </tr>
(:  :return concat($dy, ": ", $bundled-carNames) :)
}
    </table>
    
</body>

</html>;

let $filename := "carsTable.html"
let $doc-db-uri := xmldb:store("/db/ajm7408/FA2021", $filename, $ThisFileContent, "html")
return $doc-db-uri
(: Output at http://newtfire.org:8338/exist/rest/ajm7408/FA2021/carsTable.html :)



(:  :let $autoColl := collection('/db/auto/')/*
let $built := $autoColl//built
let $year := $built/@when ! string() => distinct-values() => sort()
for $y in $year
let $name := $autoColl[.//built/@when = @y]//name/text()
return concat ($y, ':', string-join($name, ', ')) :)