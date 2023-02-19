xquery version "3.1";
declare variable $ThisFileContent :=
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
let $autocoll := collection('/db/auto/')/*
let $built := $autocoll//built
let $year := $built/@when ! string() =>  distinct-values() => sort()
for $y in $year
let $names := $autocoll[.//built/@when= $y]//name/text()
return 
    <tr>
      <td>{$y}</td>
      <td><!-- {string-join($name, ', ')} -->
          <ul>{for $n in $names
          return 
              <li>{$n}</li>
          }
          </ul>
      </td>
   </tr>
}
</table>
</body>

</html>;

let $filename := "carsTable.html"
let $doc-db-uri := xmldb:store("/db/2021-Dig400-Examples", $filename, $ThisFileContent, "html")
return $doc-db-uri 
(: Output at http://newtfire.org:8338/exist/rest/db/2021-Dig400-Examples/carsTable.html :)  
