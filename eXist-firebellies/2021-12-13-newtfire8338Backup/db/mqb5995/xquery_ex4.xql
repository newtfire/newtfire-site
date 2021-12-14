xquery version "3.1";
<html>
    <head><title>Songs and the Voice Actors and Lyricists that Sang Them</title></head>
    <body>
    <h1>The Characters that Sang in Movies and How Long their Songs Were in the Disney Songs Collection</h1>
    
    <table>
        <tr><th>No.</th><th>Songs</th><th>Voice Actor</th><th>Lyricist</th></tr>
    {
    let $disneySongs := collection('/db/disneySongs/')
    let $songTitle := $disneySongs//title ! normalize-space() => distinct-values() => sort()
     for $s at $pos in $songTitle
       let $sVoice := $disneySongs[.//title ! normalize-space() = $s]//voiceActor ! normalize-space() => distinct-values() => sort() => string-join(', ')
       let $sLyricists := $disneySongs[.//title ! normalize-space() = $s]//lyricist/text() ! normalize-space() => sort() => string-join(', ')
    return 
       <tr>
          <td>{$pos}</td><td>{$s}</td><td>{$sVoice}</td> <td>{$sLyricists}</td>
               
        </tr> 
   }
   </table>
</body>
</html>
