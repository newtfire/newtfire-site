xquery version "3.1";
<html>
    <head>
        <title>Super Smash Bros Characters and Tiers</title>
    </head>
    <body>
        <h1>Smash tiers without game</h1>
        <table>
            {
            let $masterlist := collection('/db/smashtiers/')
            (:ebb: I think what you were going for here was really to output all of the tiers first of all, and then find the characters associated with them. You don't really need the game number divisions here at all, do you? The five variables below aren't getting used later. :)
            let $ssb1 := $masterlist//char[game[@n="1"]] ! string(@id)
            let $ssb2 := $masterlist//char[game[@n="2"]] ! string(@id)
            let $ssb3 := $masterlist//char[game[@n="3"]] ! string(@id)
            let $ssb4 := $masterlist//char[game[@n="4"]] ! string(@id)
            let $ssb5 := $masterlist//char[game[@n="5"]] ! string(@id)
(: What I'd recommend here is just output all of the distinct-values of $masterlist//game/@tier ! string()
 : Then loop over those and look up in the $masterlist which character names get associated with them.
 : Writing that code would mean fewer variables here. You'd need to look up something like this: :)
let $tiers := $masterlist//game/@tier ! string() => distinct-values()
for $t in $tiers
let $charNamesPerTier := $masterlist//char[game/@tier ! string() = $t] ! string(@id)
return 
    <tr>
       <td>{$t}</td>
       <td><ul>
          {for $c in $charNamesPerTier 
             return
                <li>{$c}</li>
 }
             </ul>
            </td>
    </tr>
            }

<!-- ebb: This way is what we call the "brute force approach" because you're just cranking out variables that you can be looping over. I'm commenting it out because the loops should get us the same output after all. 
            let $tierS := $masterlist//char[game[@tier="S"]] ! string(@id)
            let $tierA := $masterlist//char[game[@tier="A"]] !string(@id)
            let $tierB := $masterlist//char[game[@tier="B"]] !string(@id)
            let $tierC := $masterlist//char[game[@tier="C"]] !string(@id)
            let $tierD := $masterlist//char[game[@tier="D"]] !string(@id)
            let $tierE := $masterlist//char[game[@tier="E"]] !string(@id)
            let $tierF := $masterlist//char[game[@tier="F"]] !string(@id)
            let $tierG := $masterlist//char[game[@tier="G"]] !string(@id)
            return
                <tr>
                    <td><b>S tier:</b><ul>{for $t in $tierS return <li>{$t}</li>}</ul></td>
                    <td><b>A tier:</b><pre></pre>><ul>{for $a in $tierA return <li>{$a}</li>}</ul></td>
                    <td><b>B tier:</b><pre></pre>{$tierB}</td>
                    <td><b>C tier:</b><pre></pre>{$tierC}</td>
                    <td><b>D tier:</b><pre></pre>{$tierD}</td>
                    <td><b>E tier:</b><pre></pre>{$tierE}</td>
                    <td><b>F tier:</b><pre></pre>{$tierF}</td>
                    <td><b>G tier:</b><pre></pre>{$tierG}</td> 
                </tr>
            } -->
        </table>
    </body>
</html>
