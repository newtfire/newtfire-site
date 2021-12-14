xquery version "3.1";
declare variable $ThisFileContent :=
<html>
    <head><title>List of Mayan Sites and Their Temples</title></head>
    
<body>   
    <h1>List of Mayan Sites and Their Temples</h1>
    
    <table>
        <tr>
            <th>Mayan Site</th> 
            <th>Date Active</th>
            <th>Temples</th>
            <th>Description</th>
        </tr>
        <hr></hr>
{
let $siteIndex := doc('/db/mayan/sitesIndex.xml/')/*
let $site := $siteIndex//site
for $s in $site
(:  :where $s [.//structures]:)
let $siteName := $s/name
let $dateActive := $s/dateActive
let $temple := $s//structures/building
return 
    <tr>
      <td>{$siteName}</td>
      <td><!-- {string-join($name, ', ')} -->
          <ul>
              <li>{$s/dateActive/@yearStart ! data()}</li>
              <li>{$s/dateActive/@yearEnd ! data()}</li>
          </ul>
      </td>
      <td>
          <ul>
              {for $t in $temple
              return
                  <li>{$t/name/text()}</li>
              }
            </ul>
        </td>
        <td>
            <p>{for $t in $temple
            return $t/desc/text()
            }
                
            </p>
        </td>
        
   </tr>
   
}
</table>
</body>

</html>;

let $filename := "sitesTemplesTable.html"
let $doc-db-uri := xmldb:store("/db/mayan-queries/", $filename, $ThisFileContent, "html")
return $doc-db-uri 
(: Output at http://newtfire.org:8338/exist/rest/db/bwm5473/sitesTemplesTable.html :)
