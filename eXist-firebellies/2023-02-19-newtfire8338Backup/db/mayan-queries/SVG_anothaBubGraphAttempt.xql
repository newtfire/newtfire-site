xquery version "3.1";
declare variable $dataColl := doc('/db/Assignments/electionData/popElectoralData.xml');
declare variable $siteindex := doc('/db/mayan/sitesIndex.xml/');
declare variable $charindex := doc('/db/mayan/PV_characterIndex.xml');
declare variable $PV := doc('/db/mayan/popolVuh.xml');
declare variable $indexChars := (:  ebb: This does not work b/c it will always return true as long as some subset appears in both. You need to filter these values one by one with a for loop. :$siteindex//deityName[tokenize(./@godID ! string(), "#") = $charindex//character/@xml:id ! string()]/@godID ! substring-after(., '#') => distinct-values() => sort() => reverse() :)
                                for $i in $siteindex//Q{}deityName
                                 where $i[@godID ! normalize-space() = $PV//Q{}character/@idref ! normalize-space()]
                                 return $i;
declare variable $sortedIndexChars := $indexChars/@godID ! substring-after(., '#') => distinct-values() => sort() => reverse();
declare variable $countIndexChars := $sortedIndexChars => count();
declare variable $PVchars := (:ebb: This doesn't work for same reason as above. but I think we want to use the index chars variable :)$PV//Q{}character[tokenize(./@idref ! string(), "#") = $charindex//Q{}character/@xml:id ! string()]/@idref ! substring-after(., '#') => distinct-values() => sort() => reverse(); (:ebb: Sorting and then reversing so these come out in alphabetical order from top to bottom:)
declare variable $PVcharRefCount := $PVchars => count(); (:ebb: Don't use this. :)
declare variable $structures := $siteindex//Q{}structures/Q{}building[.//Q{}deityName] => count();
declare variable $artifacts := $siteindex//Q{}artifacts/Q{}relic[.//Q{}deityName] => count();
declare variable $depictionsTotal := $structures + $artifacts;
declare variable $siteCountsPVChars := for $i in $sortedIndexChars 
                                       let $siteCount:= $siteindex//Q{}deityName[@godID ! substring-after(., '#') = $i] => count()
                                       return $siteCount;
declare variable $maxSiteCount := $siteCountsPVChars => max();
declare variable $pi := math:pi();
declare variable $ySpacer := -100;
declare variable $xSpacer := 100;
declare variable $circleSizer := 2;
declare variable $ThisFileContent :=
<svg width="{$maxSiteCount * $xSpacer + 200}" height="{($countIndexChars * -$ySpacer) + 200}" viewBox="(0,0, 24000, 18000)"  >
<g transform="translate(100, {($countIndexChars * -$ySpacer) + 100} )">

<!-- ebb: From GitHub:the number of times each god is depicted in site structures (x axis) (ebb: I think this must be depictionsTotal) and relics (y axis)  (ebb: I think this must be gods plotted up and down the y axis) Presumably $PVChars shown as a circle plotted for each character, whose length in radius is calculated by the number of times (frequency) that specific god is referenced in the Popol Vuh. - But I'm having a tricky time trying to figure out how to execute it through XQuery-->
<!-- vertical grid lines: run from left to right to the total count of depictions (22), as high as the $PVcharRefCount (16) -->

{for $i in (0 to $maxSiteCount)
return
    <g class="gridmarks">
    <line x1="{$i * $xSpacer}" x2="{$i * $xSpacer}" y1="0" y2="{$countIndexChars * $ySpacer}" stroke="green" stroke-width="1" stroke-dasharray="5"/>
    <text x="{$i * $xSpacer}" y="30" stroke="black">{$i}</text>
    </g>
}

<!-- horizontal grid lines: run across the screen from y=0 up to total $PVcharRefCount (16) * ySpacer. -->
{for $i in (0 to $countIndexChars)
return
  <g class="gridmarks">    
    <line x1="0" x2="{$maxSiteCount * $xSpacer}" y1="{$i * $ySpacer}" y2="{$i * $ySpacer}" stroke="green" stroke-width="1" stroke-dasharray="5"/>
   </g>
}

{for $c at $pos in $sortedIndexChars 
let $PVcount := $PV//Q{}character/@idref[substring-after(., '#') = $c] => count()
let $siteCount := $siteindex//Q{}deityName[substring-after(@godID, '#') = $c] => count()
let $radius := math:sqrt($PVcount * 20 div math:pi()) 
return 
    <g class="characterPlot">
    <text x="-30" y="{$pos * $ySpacer + 5}" text-anchor="end" stroke="black">{$c}: {$PVcount}, {$siteCount}</text>
     <circle cx="{$siteCount * $xSpacer}" cy="{$pos * $ySpacer}" r="{$radius}" fill="salmon"/>
    </g>
}

 </g>
</svg>;
let $filename := "mayanBubble.svg"
let $doc-db-uri := xmldb:store("/db/mayan-queries", $filename, $ThisFileContent, "xml")
return $doc-db-uri 
(: Output at http://newtfire.org:8338/exist/rest/db/mayan-queries/mayanBubble.svg :)  