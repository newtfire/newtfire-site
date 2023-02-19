xquery version "3.1";
declare variable $index := doc('/db/mayan/sitesIndex.xml/');
declare variable $site := $index//site;
declare variable $ThisFileContent :=
<html>
    <head><title>Mayan Gods Referenced in Each Structure</title></head>
 <body> 
     <h1>Mayan Gods Referenced in Each Structure</h1>
     <table>
<tr>
    
    <th>Structure</th> 
    
      <th>Structure Type</th>
      <th>Gods Referenced in Structure</th>
      <th>Structure Description</th>
      
    
</tr>    

{
for $s in $site
let $structure := $s//structures
let $building := $structure/building
for $b in $building
  let $bName := $b/name ! string()
  let $bType := $b/@type ! data()
  let $gods := $b/gods
  let $bDesc := $b/desc/p
 let $god := $gods/deityName
  return
    <tr>
        
        <td><ul><li>{$bName}</li></ul></td> 
        <td></td>
        <td>{$bType}</td>
        <td><ul>{ 
                for $g in $god return
                    
                    <li>{$g/text()}</li>}</ul></td>
        <td>{for $d in $bDesc
            return $d/text()}
        </td>
     </tr>
}


 </table>
</body>
</html> ;


let $filename := "godStructureRefs.html"
let $doc-db-uri := xmldb:store("/db/mayan-queries", $filename, $ThisFileContent, "html")
return $doc-db-uri 
(: Output at http://newtfire.org:8338/exist/rest/db/mayan-queries/godStructureRefs.html :)  


