xquery version "3.1";
<html>
    <head><title>Names, Artists, and Lyrics of Songs</title></head>
    <body>
    <h1>Names, Artists, and Lyrics of Songs in the Disney Songs Collection</h1>
    
    <table>
        <tr><th>Name</th><th>Artists</th><th>Lyrics</th></tr>
    {
    let $disneySongs := collection('/db/disneySongs/')
    
    (: NAME :)
    let $name := $disneySongs//metadata/title
    
    (: LYRICS :)
    let $songs := $disneySongs//song
    let $lyrics :=
        for $l in $songs ! string() ! normalize-space()
            let $line := $disneySongs//ln ! text()
            let $corline := $line ! concat(., '.&#10;')
            return $corline
    
        
    let $perform := $disneySongs//perform ! string() ! normalize-space()
    
(:      for $c at $pos in $composers
       let $cTitles := $disneySongs[.//composer ! normalize-space() = $c]//title ! normalize-space() => distinct-values() => sort() => string-join(', '):)
    return 
       <tr>
          <td>{$name}</td><td>{$perform}</td><td>{$lyrics}</td> 
               
        </tr> 
   }
   </table>
</body>
</html>