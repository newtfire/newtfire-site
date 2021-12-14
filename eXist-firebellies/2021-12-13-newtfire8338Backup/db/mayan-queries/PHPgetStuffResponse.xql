xquery version "3.1";
declare variable $godID := request:get-parameter('godID', 'LOX');
declare variable $mayan := collection('/db/mayan/')/*;
declare variable $sites := $mayan//mayanSites/site;
declare variable $siteMatch := $sites[.//deityName/@godID ! substring-after(., '#') = $godID];
declare variable $deityName := $mayan//character[name][@xml:id ! substring-after(., '#') = $godID]/name ! string();
(: Look up the god name in the godography :)
<div> 
    <h2>Stuff which Depicts {$deityName} (if available)</h2>
    <table>
    <tr><th>Site Name</th><th>Relics</th><th>Buildings</th></tr>
{
(: ebb: This needed a tiny correction: You had declare variable $godID := request:get-parameter('godID', '#Hun');
(:  : But the parameter name has to exactly match what you set in the PHP file, and you called it "god" there.  :) :)
(:  :I think you're not using this? declare variable $godName := request:get-parameter('gname', 'Hunahpu');:)


for $s in $siteMatch
let $sName := $s/name ! string()
let $relicMatches := $s//relic[.//deityName/@godID ! substring-after(., '#') = $godID]/name ! string()
let $buildingMatches := $s//building[.//deityName/@godID ! substring-after(., '#') = $godID]/name ! string()  

return


    <tr><td>{$sName}</td>
    <td>
        <ul>{for $r in $relicMatches
        return
            <li>{$r}</li>
        }
        </ul>
    </td>
    <td>
        <ul>{for $b in $buildingMatches
        return
            <li>{$b}</li>
        }
        </ul>
    </td>
        
        
    </tr>


}
</table>
</div>
        
        