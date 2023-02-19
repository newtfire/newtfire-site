xquery version "3.1";
<html>
<head><title>Blues Artists with Song Counts</title></head>
<body>
    <h1>Table of Blues Artists with the Counts of their Songs in the Collection</h1>
    
<table> 
    <tr><th>Artist</th><th>Count of Songs</th></tr>
{
let $blues := collection('/db/blues')
let $artists := $blues//metadata/artist ! normalize-space() => distinct-values() => sort()
let $artistsSortedByCount := 
       for $a in $artists
       let $songCount := $blues[.//artist = $a]//metadata/title => count()
       order by $songCount descending 
       return $a
   for $a at $pos in $artistsSortedByCount
   let $aTitles := $blues[descendant::metadata/artist ! normalize-space() = $a]//metadata/title => count()
   return (: concat($a, ': ', $aTitles => count()) :)
   <tr>
        <td>{$pos}</td>
       <td>{$a}</td>
       <td>{$aTitles}</td>
    </tr>   

}
</table>
</body>
</html>