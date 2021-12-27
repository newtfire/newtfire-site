xquery version "3.1";
declare variable $ThisFileContent :=
<html> 
    <head>
        <title>Table of Years with Cars Manufactured</title>
    </head>
    <body>
        <table>
           <tr><th>Year</th>Datsun<th>Car(s) Manufactured</th></tr>
{
let $autocoll := collection('/db/auto/')/*
let $built := $autocoll//built
let $year := $built/@when ! string() =>  distinct-values() => sort()
let $tread := $tread/@type/@quant/@unit ! string() =>  distinct-values() => sort() :)
let $dimensions := $dimensions/@length/@width/@unit ! string() =>  distinct-values() => sort()
let $wheelbase := $wheelbase/@quant/@unit ! string() =>  distinct-values() => sort()
let $enginePower := $enginepower/@quant/@unit ! string() =>  distinct-values() => sort()
let $engine := $engine/@quant/@unit ! string() =>  distinct-values() => sort()
for $y in $year
let $names:= $autocoll[.//built/@when= $y]//name/text()
return 
   <tr>
       <td>{$y}</td>
       <td>
          <ul style="list-style-type:disc;">
           {
               for $n in $names
           return
               <li>{$n}</li>
           }
           </ul>
       </td>
    </tr>
}
   </table>
</body>
</html> ;
let $filename := "DcarsTablee.html"
let $doc-db-uri := xmldb:store("/db/mxb1244/homework", $filename, $ThisFileContent, "html")
return $doc-db-uri

