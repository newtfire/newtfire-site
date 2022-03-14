xquery version "3.1";
(: ebb: I removed the extra stuff at the top of your file so we could see how it outputs. And it is outputting: :)
    declare variable $ac := doc('/db/assassinsCreed/assassinscreedodyssey.xml');
    declare variable $intro := $ac//Q{}intro;
    declare variable $chapNums := $ac//Q{}chapterNum;
    declare variable $segments := ($intro, $chapNums);
    declare variable $spacer := 35;
    declare variable $max-Width := $segments => count() * $spacer + $spacer * 2;
    declare variable $ActionCounts := 
    for $s in $segments
    let $actions := $s//Q{}action
    return $actions => count();
    declare variable $maxActionCount := $ActionCounts => max();
    declare variable $height-spacer := -10;
    declare variable $max-Height := $maxActionCount * $height-spacer;
    declare variable $ThisFileContent := 
    <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 {$max-Width} 700">
        
        <g transform="translate(25, 500)">
            <line x1 = "0" y1 = "0" x2="{$max-Width}" y2="0" stroke="black"/>
            
            <line x1 = "0" y1 = "0" x2="0" y2="{$max-Height}" stroke="black"/>
            {
            for $s at $pos in $segments
            let $actions := $s//Q{}action
            let $sectionTitle := 
            if ($s//Q{}chapTitles)
            then $s//Q{}chapTitles/string() ! normalize-space()
            else "intro"
            let $speakers := $s//Q{}speaker
            let $distSpeakers := $speakers ! normalize-space() => distinct-values()
            let $countSpeakers := $distSpeakers => count()
            
            let $countActions := $actions => count()
            
            let $scaledcount := $countActions
            
            return 
            <g class = 'bars'>
                <rect fill='#3d5599' width='25' height='{$scaledcount}' y='{-$scaledcount}' x='{$pos * $spacer - 15}'></rect>;
                <text x="{$pos * $spacer}" y="10" style="writing-mode: tb; glyph-orientation-vertical:0">{$sectionTitle}</text>
                {$countSpeakers}
            </g>    
            
            }
            
        </g>
    </svg> ;
    $ThisFileContent

