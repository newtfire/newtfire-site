xquery version "3.1";
declare variable $ThisFileContent :=
<html>
    <head>
        <title>Guilty Gear Songs by Length</title>
        </head>
    <body>
        <h1>Guilty Gear Songs by Length (Below 2000)</h1>
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
        let $countData := $count ! data() => distinct-values() => sort()
        where $countData < 2000
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
    
    <table>
        <h1>Guilty Gear Songs by Length (Above 2000)</h1>
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
        let $countData := $count ! data() => distinct-values() => sort()
        where $countData > 2000
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
    
</html>;

let $filename := "Sortiz-Xpath5.html"
let $doc-db-uri := xmldb:store("/db/sao5303", $filename, $ThisFileContent, "html")
return $doc-db-uri 