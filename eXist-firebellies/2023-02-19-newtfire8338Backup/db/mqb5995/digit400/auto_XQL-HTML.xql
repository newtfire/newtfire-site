xquery version "3.1";
declare variable $ThisFileContent :=
<html>
    <head> <title>Car Models by Year</title> </head>
    <body>
        <h1>Car Models by Year</h1>
        <table>
            <tr>
                <th>Year</th>
                <th>Car Model</th>
                </tr>
                
{
let $auto := collection('/db/auto')/*
let $entries := $auto//entry
for $e in $entries
let $built := $e/built/@when ! string() => sort()
let $name := $e/name ! normalize-space()
 
let $distBuilt := $built => distinct-values()
for $d in $distBuilt
let $carName := $auto[descendant::built/@when = $d]//name ! string() ! normalize-space()
return 
    <tr>
        <td>{$d}</td>
        <td><!--{string-join($carName, ', ')}-->
            <ul>
                {for $c in $carName
                return 
                    <li>{$c}</li>
                }
            </ul>
        </td>
    </tr>    
}
</table>
</body>
</html>;
let $filename := "carYearsTable.html"
let $doc-db-uri := xmldb:store('/db/mqb5995/digit400', $filename, $ThisFileContent, 'html')
return $doc-db-uri
(: View this TSV (text/plain) file at http://newtfire.org:8338/exist/rest/db/mqb5995/digit400/carYearsTable.html  :)