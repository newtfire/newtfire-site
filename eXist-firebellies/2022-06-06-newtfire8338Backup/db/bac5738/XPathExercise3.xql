xquery version "3.1";
<html>
    <head><title>Years and Cars</title></head>
    <body>
        <h1>Years of When Cars Were Manufactured</h1>


 <table>   
            <tr> 
                <th>Years</th>  
                <th>Cars Manufactured</th>
            </tr>
             
{let $autocoll := collection('/db/auto/')/*
let $built := $autocoll//built
let $year := $built/@when ! string() =>  distinct-values() => sort()
for $y in $year
let $name := $autocoll[.//built/@when= $y]//name/text()
return 
    
    <tr>
        <td>{$y}</td>
            <td><ul> {for $n in $name
                return
                    <li> {$n}</li>
            }
            </ul>  </td>
        </tr>
}
</table>
</body>

</html>
