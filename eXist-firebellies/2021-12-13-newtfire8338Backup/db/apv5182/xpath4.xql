xquery version "3.1";

<html>
    <head><title>YGame the Charecters are in</title></head>
    
<body>
    <h1>SmashBro charecters and the games they are in</h1>
    <h2>1=Smash Bros,2=Smash Bros Melee,3=Smash Bros Brawl,4=Super Smash Bros, 5=Sumber Smash Bros Ultimate</h2>
    <table>
        <tr>
            <th>Name</th>
            <th>Game</th>
            </tr>
{
let $charList := doc('/db/smashtiers/supersmashtierlist.xml')
let $names:= $charList//char ! string(@id)
for $n in $names
let $game := $charList//char[@id=$n]/game/@n ! string()
let $stringjoin := string-join($game,':')
return
    
    <tr>
        <td>{$n}</td>
        <td>
            <ul>
                {
               for $g in $game
                return
                  <li>{$g}</li>
            }
            </ul>
        </td>
    </tr>
}

</table>
</body>
</html>