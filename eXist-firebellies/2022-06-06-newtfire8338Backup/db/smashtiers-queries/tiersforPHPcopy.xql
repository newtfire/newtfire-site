xquery version "3.1";
<table>
 <tr> 
                <th>Characters</th>  
                <th> | Super Smash Bros Ultimate | </th>
                <th> Super Smash Bros Four | </th>
                <th> Super Smash Bros Brawl | </th>
                <th> Super Smash Bros Melee | </th>
                <th> Super Smash Bros | </th>
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

