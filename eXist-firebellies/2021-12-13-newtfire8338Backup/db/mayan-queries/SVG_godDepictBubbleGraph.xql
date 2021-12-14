xquery version "3.1";
declare variable $siteindex := doc('/db/mayan/sitesIndex.xml/');
declare variable $charindex := doc('/db/mayan/PV_characterIndex.xml');
declare variable $site := $siteindex//site;
declare variable $siteCount := $siteindex//site => count();
declare variable $indexChars := $charindex//character;
declare variable $indexCharCount := $charindex//character => count();
declare variable $chars := $siteindex//deityName/@idref ! string(); 
declare variable $distChars := $chars => distinct-values() ;
declare variable $structures := $siteindex//structures/building[.//deityName] => count();
declare variable $artifacts := $siteindex//artifacts/relic[.//deityName] => count();
declare variable $pi := math:pi();
declare variable $ySpacer := -80;
declare variable $xSpacer := 80;
declare variable $circleSizer := 2;
declare variable $ThisFileContent :=
<svg width="{$siteCount * $xSpacer + 200}" height="600" viewBox="(0,0, 1200, 700)"  >
<g transform="translate(100, 550)">
    {for $i in (1 to $structures)
return
    <g>
    <line x1="{$i * $xSpacer}" x2="{$i * $xSpacer}" y1="0" y2="{5 * $ySpacer}" stroke="green" stroke-width="1" stroke-dasharray="5"/>
    <text></text>
    </g>
    }
    
    {for $i in (1 to $artifacts)
return
  <g>    
    <line x1="0" x2="{$artifacts * $xSpacer}" y1="{$i * $ySpacer}" y2="{$i * $ySpacer}" stroke="green" stroke-width="1" stroke-dasharray="5"/>
    <text x="-40" y="{$i * $ySpacer + 5}">{$i}</text>
    {$i}
   </g>
}


</g>
</svg>
(:  :for $s in $site
let $structures := $s//structures
let $building := $structures/building
let $artifacts := $s//artifacts
let $relic := $artifacts/relic
for $b in $building
  let $bName := $b/name ! string()
  let $bType := $b/@type ! data()
  let $gods := $b/gods
 let $god := $gods/deityName
  return
    <tr>
        
        <td><ul><li>{$bName}</li></ul></td> 
        <td>{$bType}</td>
        <td><ul>{ 
                for $g in $god return
                    
                    <li>{$g/text()}</li>}</ul></td>
        <td>{for $d in $bDesc
            return $d/text()}
        </td>
     </tr>
{
for $r in $relic
  let $rName := $r/name ! string()
  let $rType := $r/@type ! data()
  let $gods := $r/gods
  let $rDesc := $r/desc/p
 let $god := $gods/deityName
  return
    <tr>
        
        <td><ul><li>{$rName}</li></ul></td> 
        <td></td>
        <td>{$rType}</td>
        <td><ul>{ 
                for $g in $god return
                    
                    <li>{$g/text()}</li>}</ul></td>
        <td>{for $d in $rDesc
            return $d/text()}
        </td>
     </tr>
}:)
;
$ThisFileContent