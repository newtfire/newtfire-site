xquery version "3.1";
<html>
    <head><title>Composers and Songs</title></head>
    <body>
    <h1>Composers and Songs in the Disney Songs Collection</h1>
    
    <table>
        <tr><th>Movie</th><th>Song Name</th><th>Composer</th><th>Lyricist</th><th>Performers</th><th>Roles</th></tr>
    {
    let $collection := collection('/db/disneySongs/')
    for $item in $collection
    let $composer := $item//composer ! normalize-space() => distinct-values () => sort()
    for $c  at $pos in $composer
        let $movie := $item//movie
        let $lyrics := $item//lyricist ! normalize-space() => distinct-values () => sort()
        let $voiceActor := $item//voiceActor/text() ! normalize-space()
        let $role := $item//voiceActor/@role ! normalize-space () ! substring-after(.,"#")
        let $title := $item//title
    return
       <tr>
          <td>{$movie}</td><td>{$title}</td><td>{$composer}</td><td>{$lyrics}</td><td>{$voiceActor}</td><td>{$role}</td>
               
        </tr> 
   }
   </table>
</body>
</html>