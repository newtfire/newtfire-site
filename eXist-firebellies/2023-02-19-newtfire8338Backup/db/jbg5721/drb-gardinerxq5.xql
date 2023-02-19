xquery version "3.1";
<html>
    <head>
        <title>Blues Songs</title>
    </head>
<body>
    <h1></h1>
   <table>
        <tr><th>Artist</th><th>Song Info</th><th></th></tr>
    {
    let $blues := collection('/db/blues')
    let $artist := $blues//artist ! normalize-space() => distinct-values() => sort()
        for $c at $pos in $artist
    (:ebb: The syntax "for $var1 at $var2 in $var3" always ONLY means this:
    take the sequence of $var and break it into $var1 pieces. "at $var2" just counts them one at time: it's just a counter, nothing more. But try repositioning your $pos variable and checking its output in each of your for loops. 
    :)
    let $info := $blues[.//artist ! normalize-space() = $c]//songInfo ! normalize-space() => distinct-values() => sort()
    
    (:ebb: In your original code, you did not have a predicate to make sure the artist matches the current one in the outer for-loop. When I add that predicate, the results change: they're definitely *only* the ones for each artist. A.C. Reed has only three entries in my table. Compare the results with your original XQuery to see the difference. :)
        for $i in $info
    return 
       <tr>
          <td>{$pos}</td><td>{$c}</td><td>{$i}</td>
               
        </tr> 
   }
   </table>
</body>
</html>
