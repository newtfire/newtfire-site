xquery version "3.1";
<html>
    <head><title>Movies and The List of Songs from Disney</title></head>
    
    <body>
        <h1>Movies and The List of Songs from Disney</h1>
        
        <table>
            
            <tr><th>Movie</th><th>Songs</th></tr>
            {  let $disneySongs := collection('/db/disneySongs/')
               let $movies := $disneySongs//movie => distinct-values()
               (:ebb: I recommend changing the line above to:
               let $movies := $disneySongs//movie ! normalize-space() => distinct-values()
               so it matches the code in your $songTitles variable where you're looking up each movie. 
               :)
               for $m in $movies
               let $songTitles := $disneySongs[.//movie ! normalize-space() = $m]//title ! normalize-space() => distinct-values() => sort() => string-join(', ')
               
               
               
               return
                   
                   <tr><td>{$m}</td><td>{$songTitles}</td></tr>
               
               
              
               
               
            }
            
        </table>
        
        </body>
  </html>