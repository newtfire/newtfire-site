xquery version "3.1"; 
declare variable $ThisFileContent :=
<html>
    <head>
        <title>Disney Songs to HTML from FLWOR Starter</title>
    </head>
<body>
    <h1>Messing with Disney Songs Composers and Titles</h1>

<table>
    <tr>
        <th>Composer</th><th>Songs</th>
    </tr>
{
    let $disneySongs := collection('/db/disneySongs/')/xml
let $composerNodes := $disneySongs//composer
let $composers := $disneySongs//composer ! normalize-space() => distinct-values()

for $c in $composers
(: When you start a for loop, USE YOUR INDEX VARIABLE IN SOME WAY FROM NOW ON! :)
    let $cTitles := $disneySongs[descendant::composer ! normalize-space() = $c ]//metadata/title ! normalize-space() => distinct-values() 
    (: this should be the titles for the current composer in the for statement :)
    let $bundleTitles := string-join($cTitles, ', ')
   return
   <tr>
       <td>{$c}</td>
       <td><ul>
          {for $t in $cTitles
           return 
           
           <li>{$t}</li>
           }
           </ul>
           </td>
       
   </tr>
    
}
</table>
</body>
   
</html>;
let $filename := "disneyComposers.html"
let $doc-db-uri := xmldb:store("/db/00-students-00/sampleStudent/", $filename, $ThisFileContent, "html")
return $doc-db-uri  
  (: output at :http://newtfire.org:8338/exist/rest/db/00-students-00/sampleStudent/disneyComposers.html ) :)     



