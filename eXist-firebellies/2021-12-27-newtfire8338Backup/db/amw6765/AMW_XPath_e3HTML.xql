xquery version "3.1";
<html>
    <head><title>Years and Cars Manufactured</title></head>
<body>
    <h1>Years When Cars Were Manufactured</h1>
    <table>
        <tr>
            <th>Year</th>
            <th>Cars Manufactured</th>
        </tr>
{
let $auto := collection('/db/auto/')/*
let $cars := $auto//entry
for $c in $cars
let $built := $c/built/@when ! string()
let $make := $c/name ! normalize-space()

let $distBuilt := $built => distinct-values()
for $d in $distBuilt 
let $vName := $auto[descendant::built/@when = $d]//name ! string() ! normalize-space()
return
        <tr>
            <td>{$d}</td>
            <td><!--{string-join($vName, ', ')} -->
                <ul>{for $v in $vName
                return
                    <li>{$v}</li>
                }
                </ul>
            </td>

        </tr>
}
    </table>
</body>

</html>