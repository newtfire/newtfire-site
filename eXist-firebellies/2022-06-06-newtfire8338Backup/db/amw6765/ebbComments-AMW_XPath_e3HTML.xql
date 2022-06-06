xquery version "3.1";
<html>
    <head><title>Character Names and Their Alternative Names</title></head>
<body>
    <h1>Character Names</h1>
    <table>
        <tr>
            <th>Names</th>
            <th>Alternative Names</th>
        </tr><!--ebb: You were missing the close tag for this top table row, so that was stopping you from getting output. -->
{           
let $mayan := collection('/db/mayan/')/*
let $char := $mayan//character
for $c in $char
let $charName := $c/name ! string()
let $aName := $c/altName ! normalize-space()
return
        <tr>
            <td>{$charName}</td>
            <!--ebb: You had {$c} here, but it was outputting the whole character node -->
            <td>
                <ul>{for $a in $aName              (: I am lost at this point :)
                (:ebb: I figured from the variables above that you wanted to output the alternative names associated with each character's name. There are often multiple alternate names per main name, so we're just looping over those. Make sense?:)
                return
                    <li>{$a}</li>
                }
                </ul>
            </td>
        </tr>
}
</table>
</body>
</html>
