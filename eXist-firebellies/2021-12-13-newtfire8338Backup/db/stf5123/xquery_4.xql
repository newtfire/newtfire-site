xquery version "3.1";
<html>
    <head><title>Song information List</title></head>
    <body>
    <h1>List of song title, performer, and movie it is from. </h1>
    
    <table>
        <tr><th>Song Title</th><th>Performers</th><th>Number of performers</th><th>Movie</th><th>Word Count</th></tr>
{
let $songs := collection('/db/disneySongs/')
    for $d  in $songs
    let $dtitle := $d//title ! string()
    let $dsongString := $d//song ! string-length()
    let $dperformer := $d//perform/voiceActor
    let $perfcount := $d//voiceActor => count() 
    let $dmovie := $d//origin/movie
    order by $dtitle ascending
        return 
    <tr>
        <td>{$dtitle}</td> <td>{$dperformer}</td><td>{$perfcount}</td> <td>{$dmovie}</td> <td>{$dsongString}</td>
        </tr>
}
 </table>
</body>
</html>