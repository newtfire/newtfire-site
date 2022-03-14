xquery version "3.1";
<html>
    <head>
        <title>Guilty Gear Songs by Length</title>
        </head>
    <body>
        <h1>Guilty Gear Songs by Length</h1>
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
       
        order by $count descending
        return
        
        <tr>
            <td>{$ds}</td> 
            <td>{$ds-title}</td>
            <td>{$count}</td>
                
        </tr>
    }
    
    </table>
    </body>
    
</html>