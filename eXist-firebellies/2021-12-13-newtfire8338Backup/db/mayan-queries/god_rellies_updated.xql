xquery version "3.1";
declare variable $mayan := collection('/db/mayan/')/*;
declare variable $distinctRellyTypes := $mayan//family//*[not(child::*)] ! name() => distinct-values();
declare variable $ThisFileContent :=
<html>
    <head><title>Mayan Gods and Their Relatives</title></head>
 <body> 
     <h1>Mayan Gods and Their Relatives</h1>
     <table>
<tr>
    <th>God</th> 
    {for $d in $distinctRellyTypes
        return
      <th>{$d}</th>
    }
</tr>    

{
let $mchar := $mayan//character
for $m in $mchar
  let $charName := $m/name ! string()
  
  return
    <tr>
        <td>{$charName}</td> 
        
  {
  let $charFamily := $m/family//*
  for $d in $distinctRellyTypes
  
  let $famMatch := $charFamily[name(.) = $d]/text()
 return
  <td><ul>{for $f in $famMatch return
       <li>{$f}</li>
      
  } </ul>
      
  </td>
  }
  
   </tr>

}

 </table>
</body>
</html> ;


let $filename := "godRelationships.html"
let $doc-db-uri := xmldb:store("/db/mayan-queries", $filename, $ThisFileContent, "html")
return $doc-db-uri 
(: Output at http://newtfire.org:8338/exist/rest/db/mayan-queries/godRelationships.html :)  


