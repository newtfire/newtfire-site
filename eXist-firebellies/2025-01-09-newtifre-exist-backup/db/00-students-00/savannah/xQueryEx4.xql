xquery version "3.1";
<html>
    <head><title>Composers and Songs</title></head>
    <body>
    <h1>Composers and Songs in the Disney Songs Collection</h1>
    
    <table>
        <tr><th>No.</th><th>Composers</th><th>Performers</th><th>List of Songs</th></tr>
    {
    let $disneySongs := collection('/db/disneySongs/')
    let $voiceActor := $disneySongs//voiceActor ! normalize-space() => distinct-values() => sort()
     for $c at $pos in $voiceActor
       let $cTitles := $disneySongs[.//voiceActor ! normalize-space() = $c]//title ! normalize-space() => distinct-values() => sort() => string-join(', ')
    return 
       <tr>
          <td>{$pos}</td><td>{$c}</td><td>{$cTitles}</td> 
               
        </tr> 
   }
   </table>
</body>
</html>