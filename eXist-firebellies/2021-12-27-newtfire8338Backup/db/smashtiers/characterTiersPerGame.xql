xquery version "3.1";
<html> 
    <head><title>Super Smash Characters' Tiers</title></head>
    <body> 
         <h1>Characters' Tiers Based On Game</h1>
<table>
 <tr> 
                <th>Characters</th>  
                <th>Game 1</th>
                <th>Game 2</th>
                <th>Game 3</th>
                <th>Game 4</th>
                <th>Game 5</th>
</tr>
             
{let $smashcoll := doc('/db/smashtiers/supersmashtierlist.xml')/*
let $char := $smashcoll//char
for $c in $char
(: ebb: I'm starting the return way up here because we absolutely want one table row for each character! :)
return 
<tr>
    <td>{$c/text()}</td>
    <!--ebb: NOW we need to loop over those games to get each of the other <td> rows for each game -->
    {let $game := $c//game/@n ! string() => sort()
     for $g in $game
     let $tier := $c//game[@n = $g]/@tier ! string()
      return
      <td>{$tier}</td>
    }
</tr>
    }
</table>
</body>
</html>
