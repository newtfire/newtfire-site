xquery version "3.1";
declare variable $ThisFileContent :=
<html>
    <head>
        <title>Table of Behrend Trees</title>
    </head>
    <body>
        <h1>Master Tree Sheet</h1>
        <table>
            <!--Wait, how do I make an HTML table? See https://www.w3schools.com/html/html_tables.asp :)
            (: Tables should have a row at the top with special <th>..</th> cells inside for table headings:)-->
            
            <tr><th>Common Name</th> <th>Scientific Name</th><th>Description</th></tr>
{
let $btrees := collection('/db/btrees/')/*
let $entries := $btrees//entry
for $e in $entries
let $cname := $e/cname ! data() 
let $sname := $e/sname ! normalize-space()
let $desc := $e/desc ! normalize-space()
return 
   <tr>
       <td>
          {$cname}
        </td>
    <td>
          {$sname}
    </td>
    <td>       
      {$desc}
     </td> 
    </tr>
}
   </table>
</body>
</html>;

let $filename := "btrees-master.html"
let $doc-db-uri := xmldb:store("/db/btrees-queries", $filename, $ThisFileContent, "html")
return $doc-db-uri 
(: Output at http://newtfire.org:8338/exist/rest/db/btrees-queries/btrees-master.html :)  

(:  :let $autoColl := collection('/db/btrees')/*
let $entries := $autoColl//entry
for $e in $entries
let $cname := $e/cname ! data()
let $sname := $e/sname ! normalize-space()
let $desc := $e/desc ! normalize-space()
return concat($cname,', ', $sname, ': ', $desc)

xquery version "3.1";
let $autoColl := collection('/db/auto')/*
let $entries := $autoColl//entry
for $e in $entries
let $built := $e/built/@when ! data()
let $name := $e/name ! normalize-space()
return concat($built, ': ', $name)
:)