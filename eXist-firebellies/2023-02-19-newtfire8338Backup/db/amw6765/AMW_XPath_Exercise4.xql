xquery version "3.1";
<html>
    <head><title>Character Names and Their Alternative Names</title></head>
<body>
    <h1>Character Names</h1>
    <table>
        <tr>
            <th>Names</th>
            <th>Alternative Names</th>
        </tr>
{           
let $mayan := collection('/db/mayan/')/*
let $mchar := $mayan//character
for $m in $mchar
let $charName := $m/name ! string()
let $aName := $m/altName ! normalize-space()

let $ := $ => distinct-values()
for $ in $ 
let $ := $[descendant::name/@when = $]//name ! string() ! normalize-space()
return
        <tr>
            <td>{$}</td>
            <td>
                <ul>{for $ in $
                return
                    <li>{$}</li>
                }
                </ul>
            </td>
            
        </tr>
}
    </table>
</body>

</html>
    

