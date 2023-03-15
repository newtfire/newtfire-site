xquery version "3.1";
<html> 
    <head><title>Super Smash Character's Tier</title></head>
    <body> 
         <h1>Character's Tier Based On Game</h1>
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
let $game := $c//game
for $g in $game
let $tier := $g/@n ! string()=> sort()
let $n := $c/text()
return <tr><td>{$n}</td>
<td>{$g}</td><td>{$tier}</td></tr>} 

</table>
</body>
</html>
