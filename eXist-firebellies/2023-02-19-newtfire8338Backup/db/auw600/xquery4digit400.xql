xquery version "3.1";
declare variable $ThisFileContent:=
<html>
<head><title>Title and String Length</title></head>
<body>
    <h1>Title and String Length</h1>
    <table>
    <tr><th>Song Title,</th> <th>Length of Song</th></tr>
{
let $disneySongs := collection('/db/disneySongs/')
for $d in $disneySongs
let $title := $d//title
let $length := $d//song/string-length()
return 
   <tr>
       <th>{$title}</th>
       <th>{$length}</th>
     </tr>
}
</table>
</body>
</html>;

let $filename := "disneySongsTable.html"
let $doc-db-uri := xmldb:store("/db/auw600", $filename, $ThisFileContent, "html")
return $doc-db-uri  
  (: output at :http://newtfire.org:8338/exist/rest/db/auw600/disneySongsTable.html ) :)  

