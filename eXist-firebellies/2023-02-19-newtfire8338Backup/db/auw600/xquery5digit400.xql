xquery version "3.1";
declare variable $ThisFileContent :=
<html>
    <head><title>Disney Song Information</title></head>
    
<body>   
    <h1>Song titles, lines, and length</h1>
    
    <table>
        <tr>
            <th>Title</th> 
            <th>Line Count</th>
            <th>String Length</th></tr>
{
let $disneySongs := collection('/db/disneySongs/')
for $d in $disneySongs
let $title:=$d//title
let $lines := $d //ln => count()
let $stlgth := $d//song/string-length()
let $shortest := min($stlgth)
let $longest := max($stlgth)
let $info := concat($title,", line count = ", $lines,",string length = ",$stlgth)
where $stlgth eq $longest
order by $stlgth descending

return 
    <tr>
      <td>{$title}</td>
      <td>{$lines}</td>
      <td>{$stlgth}</td>
   </tr>
}
</table>
</body>
</html>;

let $filename := "DisneySongInfo.html"
let $doc-db-uri := xmldb:store("/db/auw600", $filename, $ThisFileContent, "html")
return $doc-db-uri 
(: Output at http://newtfire.org:8338/exist/rest/db/auw600/DisneySongInfo.html :)  