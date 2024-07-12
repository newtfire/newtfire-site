xquery version "3.1";
declare variable $siteindex := doc('/db/mayan/sitesIndex.xml/');
declare variable $charindex := doc('/db/mayan/PV_characterIndex.xml');
declare variable $PV := doc('/db/mayan/popolVuh.xml');
declare variable $indexChars := $siteindex//deityName[tokenize(@godID ! string(), "#")[last()] = $charindex//character/@xml:id ! string()]/@godID => distinct-values();
declare variable $PVchars := $PV//character[tokenize(@idref ! string(), "#")[last()] = $charindex//character/@xml:id ! string()]/@idref => distinct-values();
declare variable $PVcharRefCount := $PV//character[tokenize(@idref ! string(), "#")[last()] = $charindex//character/@xml:id ! string()] => count();
declare variable $structures := $siteindex//structures/building[.//deityName] => count();
declare variable $artifacts := $siteindex//artifacts/relic[.//deityName] => count();
declare variable $depictionsTotal := $structures + $artifacts;
declare variable $pi := math:pi();
declare variable $ySpacer := -80;
declare variable $xSpacer := 80;
declare variable $circleSizer := 2;
declare variable $ThisFileContent := 
<svg width="1500" height="1000" viewBox="(0,0, 1200, 700)">
<g transform="translate(100, 550)">
    {for $i at $pos in (0 to $depictionsTotal)
return
    <g>
    <line x1="{$i * $xSpacer}" x2="{$i * $xSpacer}" y1="0" y2="{6 * $ySpacer}" stroke="green" stroke-width="1" stroke-dasharray="5"/>
    <text x="{$i * $xSpacer}" y="{6 * $ySpacer}">{$pos}</text>
    </g>
}
    {for $i at $pos in (0 to $PVcharRefCount)
    return
    <g>    
    <line x1="0" x2="{$PVcharRefCount * $xSpacer}" y1="{$i * $ySpacer}" y2="{$i * $ySpacer}" stroke="green" stroke-width="1" stroke-dasharray="5"/>
    <text x="-40" y="{$i * $ySpacer + 5}">{$i * 100}</text>
   </g>
    }

    {for $i in $indexChars
    let $structureCount := $siteindex//structures[.//deityName[@godID ! string() = $i]] => count()
    let $artifactCount := $siteindex//artifacts[.//deityName[@godID ! string() = $i]] => count()
    let $indexCharCount := $siteindex//deityName[@godID ! string() = $i] => count()
    
    return
    <g>
         {concat($i, ' ', $indexCharCount, ' Structures: ', $structureCount, ' Artifacts:', $artifactCount)}
        </g>
    }
    {$PVchars}
    {for $p in $PVchars
    let $PVcharCount := $PV//character[@idref ! string() = $p] => count()
    let $bk1charCount := $PV//book[1]//character[@idref ! string() = $p] => count()
     let $bk2charCount := $PV//book[2]//character[@idref ! string() = $p] => count()
      let $bk3charCount := $PV//book[3]//character[@idref ! string() = $p] => count()
       let $bk4charCount := $PV//book[4]//character[@idref ! string() = $p] => count()
    return
    <g>
       {concat($p, ' ', $PVcharCount, ' Book 1: ', $bk1charCount, ' Book 2: ', $bk2charCount, ' Book 3: ', $bk3charCount, ' Book 4: ', $bk4charCount)}
    </g>
    }
    </g>
 
</svg>
    ;

$ThisFileContent