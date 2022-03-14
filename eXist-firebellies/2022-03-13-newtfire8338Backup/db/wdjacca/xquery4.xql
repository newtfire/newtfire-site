xquery version "3.1";
<html>
    <head><title>Composers and Songs</title></head>
    <body>
    <h1>Composers and Songs in the Disney Songs Collection</h1>
    
    <table>
        <tr><th>No.</th><th>Movie</th><th>Voice Actors</th><th>Role</th></tr>
    {
    let $collection := collection('/db/disneySongs/')
    for $c at $pos in $collection
    let $movie := $c//title
    let $voiceActor := $c//voiceActor/text() ! normalize-space()
    let $role := $c//voiceActor/@role ! normalize-space () ! substring-after(.,"#")
    return
       <tr>
          <td>{$pos}</td><td><ul>{
              for $v in $voiceActor
                return <li>{$v}</li>
          }</ul></td><td>{$movie}</td><td><ul>{
              for $r in $role
                return <li>{$r}</li>
          }</ul></td>
               
        </tr> 
   }
   </table>
</body>
</html>
