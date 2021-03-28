xquery version "3.1";
<html>
    <head><title>Composers and Songs</title></head>
    <body>
    <h1>Composers and Songs in the Disney Songs Collection</h1>
    
    <table>
        <tr><th>No.</th><th>Movie</th><th>Composer</th><th>Performers</th><th>List of Songs</th></tr>
    {
    let $collection := collection('/db/disneySongs/')
    let $movie := $collection//movie ! normalize-space() => distinct-values ()
    for $m at $pos in $movie
        let $composer := $collection[.//movie=$m]//composer ! normalize-space() => distinct-values ()
        return
       <tr>
          <td>{$m}</td><td>{$composer}</td>
               
        </tr> 
   }
   </table>
</body>
</html>