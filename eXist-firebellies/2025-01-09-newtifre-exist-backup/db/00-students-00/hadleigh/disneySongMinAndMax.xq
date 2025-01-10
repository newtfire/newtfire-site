xquery version "3.1";
<html>
    <head>
        <title>Min and Max Song Length</title>
            
    </head>
    <body>
    <h1>Min and Max Song Length</h1>
    
    <table>
        <tr>
            <th>Min and Max Song</th>
            <th>Length</th>
                
        </tr>
    {
    let $disneySongs := collection('/db/disneySongs/')/xml
    let $songCount :=
        for $d in $disneySongs
        let $songLength := $d//song/string-length()
        return $songLength
        
    let $maxCount := $songCount => max()
    let $minCount := $songCount => min()
    for $d in $disneySongs
        let $dTitle := $d//metadata/title
        let $dLength := $d//song ! string-length()
        where $dLength = $minCount or $dLength = $maxCount
        return
       <tr>
          <td>{$dTitle ! string()}</td>
          <td>{$dLength}</td>
               
        </tr> 
   }
   </table>
</body>
</html>