xquery version "3.1";

<html>
    <head><title>YGame the Charecters are in</title></head>
    
<body>
    <h1>SmashBro charecters and the games they are in</h1>
    <table>
        <tr>
            <th>Name</th>
            <th>Game</th>
            
            </tr>
{
let $charList := doc('/db/smashtiers/supersmashtierlist.xml')
let $names:= $charList//char ! string(@id)
for $n in $names
(:  :let $game := $charList//char[@id=$n]/game/@n ! data() =>distinct-values()
let $stringjoin := string-join($game,':'):)
let $tier := $charList//char[@id=$n]/games/@tier ! string => distinct-values()
let $string := string-join($tier,':')

return 
    
    <tr>
        <td>{$n}</td>
        <td>
            <ul>{
                for $t in $tier
                let $gn:= 
                if ($t<=1)
                then ($t)
                else ($t)
                return
              <li>  {$gn
            }
          </li>
            }]
            </ul>
        </td>
     
    </tr>
}

</table>
</body>
</html>