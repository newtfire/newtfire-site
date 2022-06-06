xquery version "3.1";
<html>
    <head>
        <title>Table of Years with Cars Manufactured</title>
    </head>
    <body>
        <table>
            (:Wait, how do I make an HTML table? See https://www.w3schools.com/html/html_tables.asp :)
            (: Tables should have a row at the top with special <th>..</th> cells inside for table headings:)
            
            <tr><th>Year</th> <th>Car(s) Manufactured</th></tr>
{
let $autocoll := collection('/db/auto/')/*
let $built := $autocoll//built
let $year := $built/@when ! string() =>  distinct-values() => sort()
for $y in $year
let $names:= $autocoll[.//built/@when= $y]//name/text()
return 
   <tr>
       <td>{$y}</td>
       <td> <!-- ebb: In here, use XML/HTML style comments to comment stuff out
       {string-join($names, ', ')} --> 
       <!--Let's put a bulleted list inside this table cell: -->
          <ul>
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
</html>
