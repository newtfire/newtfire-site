xquery version "3.1";
declare variable $ThisFileContent :=
<html>
    <head><title>Popol Vuh Family Relationships</title></head>
    
<body>   
    <h1>Popol Vuh Family Relationships</h1>
    
    <table>
        <tr>
            <th>PV Character</th> 
            <th>List of Children</th>
            <th>List of Parents</th>
        </tr>
        <hr></hr>
{
let $charIndex := doc('/db/mayan/PV_characterIndex.xml/')/*
let $char := $charIndex//character
for $c in $char
where count($c//family) = 1
let $family := $c//family
let $offspring := $family//children
let $parents := $family//parents
return 
    <tr>
      <td>{$c/name/text()}</td>
      <td><!-- {string-join($name, ', ')} -->
          <ul>{for $o in $offspring
          return 
              <li>{$o/*/text()}</li>
          }
          </ul>
      </td>
      <td>
          <ul>
              {for $p in $parents
              return
                  <li>{$p/*/text()}</li>
              }
            </ul>
        </td>
        
   </tr>
   
}
</table>
</body>

</html>;

let $filename := "PVcharsTable.html"
let $doc-db-uri := xmldb:store("/db/mqb5995", $filename, $ThisFileContent, "html")
return $doc-db-uri 
(: Output at http://newtfire.org:8338/exist/rest/db/mqb5995/PVcharsTable.html :)  
