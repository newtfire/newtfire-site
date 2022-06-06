xquery version "3.1";
declare variable $ThisFileContent :=
<html> 
    <head>
        <title>Table of Years with Cars Manufactured</title>
    </head>
    <body>
       
{
let $autocoll := collection('/db/auto/')/*
let $built := $autocoll//built
let $year := $built/@when ! string() =>  distinct-values() => sort()
for $y in $year
let $names:= $autocoll[.//built/@when= $y]//name
return 
<table id="y{$y}">
    <tr>
      
        <th class="year">Year: {$y}</th>
        <td><table>
               <tr>
                   <th>Car Name</th>
                   <th>Dimensions</th>
                   <th>Engine Info</th>
                   <th>Engine Power</th>
               </tr>
           {
               for $n in $names
               let $carid := $n/base-uri(.) ! tokenize(., '/')[last()] ! substring-before(., '.xml')
               (:ebb: This $carid variable is making a car id out of your filename for this car.:)
               let $dimension-l := $n/following::dimensions/@length ! data()
               let $dimension-w := $n/following::dimensions/@width ! data()
               let $dimension-h := $n/following::dimensions/@height ! data()
               let $dimension-u := $n/following::dimensions/@unit ! string()
               let $engine-quant := $n/following::engine/@quant ! data()
               let $engine-quant-u := $n/following::engine/@unit ! string()
               let $enginePower := $n/following::enginePower/@quant ! data()
               let $enginePower-u := $n/following::enginePower/@unit ! string()

           return
               <tr id="{$carid}">
               <td>{$n}</td>
               <td><ul>
                      <li>Length: {$dimension-l} {$dimension-u}</li>
                      <li>Width: {$dimension-w} {$dimension-u}</li>
                      <li>Height: {$dimension-h} {$dimension-u}</li>
                   </ul>
               </td>
               <td>Engine: {$engine-quant}-{$engine-quant-u}</td>
               <td>Engine Power {$enginePower} {$enginePower-u}</td>
                   
               </tr>
           }
           </table>
           </td>
    </tr>
</table>    
}
 
</body>
</html> ;
$ThisFileContent
(:  :let $filename := "DcarsTablee.html"
let $doc-db-uri := xmldb:store("/db/mxb1244/homework", $filename, $ThisFileContent, "html")
return $doc-db-uri:)

