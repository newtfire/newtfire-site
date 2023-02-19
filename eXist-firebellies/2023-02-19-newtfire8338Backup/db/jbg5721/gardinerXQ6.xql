xquery version "3.1";
declare variable $blues := collection('/db/blues');
<html>
    <head>
        <title>Blues Collection</title>
    </head>
    <body>
    <h1>Blues Song Information</h1>
   <table>
        <tr><th>Artist</th><th>Song Info</th><th></th></tr>
    {
    let $artist := $blues//artist ! normalize-space() => distinct-values() => sort()
        for $c at $pos in $artist
    let $info := $blues[descendant::artist = $c]//songInfo ! normalize-space() => distinct-values() => sort()
        
    return 
       <tr>
          <td></td><td>{$c}</td>
          <td><ol>{for $i in $info
              return
              <li> {$i}</li>
          }
          </ol></td>
               
        </tr> 
   }
   </table>
</body>
    
</html>