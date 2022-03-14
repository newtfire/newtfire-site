xquery version "3.1";
declare variable $ThisFileContent :=
<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 2000 1000">
      <!--We will adjust our "viewport" by altering the width and height attribute values roughly to be larger 
      than the largest X and Y on the plot-->
     <g transform= "translate (100, 550)">
         <!--This g can take a transform="translate(x y)" attribute to shift the whole plot over and down as needed-->
         
         {
         
        let $ac := doc('/db/assassinsCreed/assassinscreedodyssey.xml')
        let $intro := $ac//Q{}intro
        let $chapNums := $ac//Q{}chapterNum
        let $segments := ($intro, $chapNums)
        for $s at $pos in $segments
        let $actions := $s//Q{}action
        let $sectionTitle :=
        if ($s//Q{}chapTitles)
        then $s//Q{}chapTitles/string() ! normalize-space()
        else "intro"
        let $speakers := $s//Q{}speaker
        let $distSpeakers := $speakers ! normalize-space() => distinct-values()
        let $countSpeakers := $distSpeakers => count()
        let $heightSpacer := 10
        let $countActions := $actions => count()
        let $spacer := 65
        return
            <g>
                (: Actions Rectangle :)
                <rect x="{$pos * $spacer}" width="25" y="-{$countActions * $heightSpacer}" height="{$countActions * $heightSpacer}" fill="#d997ff" stroke="#d997ff" />
                (: Speakers Rectangle :)
                <rect x="{$pos * $spacer +25}" width="25" y="-{$countSpeakers * $heightSpacer}" height="{$countSpeakers * $heightSpacer}" fill="#4cc0f3" stroke="#4cc0f3" />
                <text x="{$pos * $spacer +25}" y="50" style="writing-mode: tb; glyph-orientation-vertical: 180; font-size: 18;">{$sectionTitle}</text>
                <text x="-20" y="-200" style="writing-mode: tb; glyph-orientation-vertical: 180; font-size: 28; text-anchor: middle;">Action/Speaker Count</text>
                <text x="{$pos * $spacer +12.5}" y="-{$countActions * $heightSpacer +5}" style="font-size: 16; text-anchor: middle;">{$countActions}</text>
                <text x="{$pos * $spacer +37.5}" y="-{$countSpeakers * $heightSpacer +5}" style="font-size: 16; text-anchor: middle;">{$countSpeakers}</text>
                <text x="1000" y="-500" style="text-anchor: middle; font-family: Sans-Serif; font-size: 48;">Assassin's Creed</text>
                 <text x="1000" y="-450" style="text-anchor: middle; font-family: Sans-Serif; font-size: 28;">The Amount of Actions vs. The Amount of Speakers</text>
                <line x1="0" y1="0" x2="1950" y2="0" style="stroke: black;" stroke-width="3"/>
                <line x1="0" y1="0" x2="0" y2="-400" style="stroke: black;" stroke-width="3"/>
                <rect x="1500" width="200" y="-400" height="150" fill="none" stroke="black" />
                <rect x="1530" width="30" y="-370" height="30" fill="#d997ff" />
                <rect x="1530" width="30" y="-300" height="30" fill="#4cc0f3" />
                <text x="1570" y="-346" style="font-size: 24;">Actions</text>
                <text x="1570" y="-276" style="font-size: 24;">Speakers</text>
                {$countSpeakers}
            </g>
   
         
         }

     </g>
 </svg>;

  let $filename := "rachelAC.svg"
let $doc-db-uri := xmldb:store("/db/rgg5144/", $filename, $ThisFileContent)
return $doc-db-uri 
(:  View this SVG at http://newtfire.org:8338/exist/rest/db/rgg5144/rachelAC.svg  :)