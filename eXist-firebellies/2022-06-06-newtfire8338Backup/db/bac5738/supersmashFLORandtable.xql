xquery version "3.1";
<html> 
    <head><title>Super Smash Character's Tier</title></head>
    <body> 
         <h1>Character's Tier Based On Game</h1>
<table>
 <tr> 
                <th>Characters</th>  
                <th>Game 4</th>
            </tr>
             
{let $smashcoll := doc('/db/smashtiers/supersmashtierlist.xml')/*
let $char := $smashcoll//char
for $c in $char
let $game := $c//game
let $tier := $game/@tier ! string()
let $n := $c/text()
where $game/@n = 4
return <tr><td>{$n}</td>
<td>{$tier}</td></tr>} 

</table>
</body>
</html>