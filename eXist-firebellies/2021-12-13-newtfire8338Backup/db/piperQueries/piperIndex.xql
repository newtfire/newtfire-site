xquery version "3.1";
declare variable $ThisFileContent := 
<html>
    <head>
        <title>Index to Piper Baron’s Poetry Collection</title>
        
    </head>
<body>
    <h1>Index to Piper Baron’s Poetry Collection</h1>
    
    <h2>By Topic</h2>
    <table>
        <tr><th>Topic</th>
        <th>Poem</th>
        </tr>
{
let $poetrycol := collection('/db/piperpoetry/XML')
let $tagpoints := $poetrycol//metaTags/tagPoint/@tag ! normalize-space() => distinct-values() => sort()
for $t in $tagpoints
let $matchPoems := $poetrycol//content[descendant::metaTags/tagPoint/@tag ! normalize-space() = $t]
let $matchTitles := $matchPoems//poemTitle
return
<tr>
    <td>{$t}</td>
    <td><ul>{for $m in $matchTitles
        let $filename := $m ! base-uri() ! tokenize(., '/')[last()] ! substring-before(., '.xml')
        let $mName := $m ! normalize-space()
        return
            
                <li><a href="{$filename}.html">{$mName}</a></li>
          
        
    }</ul></td>

</tr>   

}
</table>

<h2>By Keyword</h2>
<table>
    <tr>
        <th></th>
        <th></th>
    </tr>    
   
   {
let $poetrycol := collection('/db/piperpoetry/XML')
let $keywords := $poetrycol//keyword ! normalize-space() => distinct-values() => sort()
for $k in $keywords 
let $matchPoem := $poetrycol//content[descendant::keyword ! normalize-space() = $k]
let $matchTitle := $matchPoem//poemTitle

return
    
    <tr>
        <td>{$k}</td>
        <td><ul>{for $m in $matchTitle
        let $filename := $m ! base-uri() ! tokenize(., '/')[last()] ! substring-before(., '.xml')
            return
                <li><a href="{$filename}">{$m ! normalize-space()}</a></li>
        }</ul></td>
    </tr>

} 
    
    
</table>
</body>
</html> ;



let $filename := "collectionIndex.html"
let $doc-db-uri := xmldb:store("/db/piperpoetry/", $filename, $ThisFileContent, "html")
return $doc-db-uri   
(: View this text file at http://newtfire.org:8338/exist/rest/db/piperpoetry/collectionIndex.html  :)