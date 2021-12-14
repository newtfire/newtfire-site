xquery version "3.1";
declare variable $index := doc('/db/mayan/sitesIndex.xml/');
declare variable $site := $index//site;
declare variable $ThisFileContent :=
<html>
    <head><title>Mayan Gods Referenced in Each Relic</title></head>
 <body> 
     <h1>Mayan Gods Referenced in Each Relic</h1>
     <table>
<tr>
    
    <th>Relic</th> 
    
      <th>Relic Type</th>
      <th>Gods Referenced in Relic</th>
      <th>Relic Description</th>
      
    
</tr>    

{
for $s in $site
let $artifacts := $s//artifacts
let $relic := $artifacts/relic
for $r in $relic
  let $rName := $r/name ! string()
  let $rType := $r/@type ! data()
  let $gods := $r/gods
  let $rDesc := $r/desc/p
 let $god := $gods/deityName
  return
    <tr>
        
        <td><ul><li>{$rName}</li></ul></td> 
        <td></td>
        <td>{$rType}</td>
        <td><ul>{ 
                for $g in $god return
                    
                    <li>{$g/text()}</li>}</ul></td>
        <td>{for $d in $rDesc
            return $d/text()}
        </td>
     </tr>
}


 </table>
</body>
</html> ;


let $filename := "godRelicRefs.html"
let $doc-db-uri := xmldb:store("/db/mayan-queries", $filename, $ThisFileContent, "html")
return $doc-db-uri 
(: Output at http://newtfire.org:8338/exist/rest/db/mayan-queries/godRelicRefs.html :)  
