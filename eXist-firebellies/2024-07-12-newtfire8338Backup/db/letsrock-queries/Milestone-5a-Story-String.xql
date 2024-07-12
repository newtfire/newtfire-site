xquery version "3.1";
declare variable $ThisFileContent :=
<html>
    <head>
        <title>Guilty Gear Songs by Length (story)</title>
        </head>
    <body>
        <h1>Plot Relevant Lines by Length</h1>
    <table>
    <tr>
    <th>Character</th> 
            <th>Title</th>
            <th>Length</th>
</tr> 
    {
        let $rock := collection('/db/letsrock/')/*
        let $songs := $rock//song
        let $stories := $rock//i/@story ! string()
       let $dstories: = $stories => distinct-values()
      for $ds in $dstories
       let $ds-songs: = $songs[descendant::i[@story= $ds]]
       let $count := $ds-songs ! string-length() => distinct-values() (:so far only recordws string length of actual character title UPDATE:seems i have fixed it :)
       let $ds-title := $ds-songs//sname ! string()
       let $count-story := $ds-songs//i 
       for $co in $count-story
       let $story := $co/@story ! string()
       let $co-string := $co ! string-length()
        order by $co-string descending
        return  
        
        
            <tr>
            <td>{$ds}</td> 
            <td>{$ds-title}</td>
            <td>{$co-string}</td>
            <td class="{$story}">{$co ! string()}</td>
                
        </tr>
    }
    
    </table>
    </body>
    
</html>;

let $filename := "Story-length.html"
let $doc-db-uri := xmldb:store("/db/letsrock-queries", $filename, $ThisFileContent, "html")
return $doc-db-uri 