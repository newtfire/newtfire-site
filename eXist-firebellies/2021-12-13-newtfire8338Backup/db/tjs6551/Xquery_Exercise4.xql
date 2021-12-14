xquery version "3.1";
<html>
    <head><title>Titles and Voice Actors</title></head>
    <body>
    <h1>Titles and Voice Actors in the Disney Songs Collection</h1>
    
    <table>
        <tr><th>No.</th><th>Title</th><th>Voice Actors</th></tr>
{
    let $disneySongs:= collection('/db/disneySongs/')
    let $dtitle:= $disneySongs//title ! normalize-space() => distinct-values() => sort()
    let $vActor:= $disneySongs//composer
    for $c at $pos in $dtitle
    return $dtitle
        } <tr>
          <td>{$pos}</td><td>{$c}</td><td>{$dTitles}</td> 
               
        </tr>
            
   </table>
</body>
</html>