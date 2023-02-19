xquery version "3.1";

<html>
    <head><title>Years and Cars Manufactured</title></head>
    
<body>
    <h1>Years When Cars Were Manufacured</h1>
    <table>
        <tr>
            <th>Year</th>
            <th>Car Manufactured</th>
            </tr>
{
let $autocoll := collection('/db/auto')/*
let $built := $autocoll//built
let $year := $built/@when ! string() => distinct-values() => sort()
for $y in $year
let $names := $autocoll[.//built/@when= $y]//name/text()
return 
    
    <tr>
        <td>{$y}</td>
        <td><!--{string-join($name,',')}-->
            <ul>
                {for $n in $names
                    return
                        <li>{$n}</li>
                }
            </ul>
        </td>
    </tr>
}

</table>
</body>
</html>