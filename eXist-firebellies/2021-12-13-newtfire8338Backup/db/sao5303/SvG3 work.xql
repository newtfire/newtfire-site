xquery version "3.1";
declare variable $ac := doc('/db/assassinsCreed/assassinscreedodyssey.xml');
declare variable $intro := $ac//Q{}intro;
declare variable $chapNums :=$ac//Q{}chapterNum;
declare variable $spacer := 70;
declare variable $segments := ($intro, $chapNums);
declare variable $max-Width := $segments => count() * $spacer + $spacer; 
declare variable $maxActionCount := max(
    for $s at $pos in $segments 
    let $actions := $s//Q{}action   
    return $actions => count()  );
declare variable $height-spacer := -10;
declare variable $max-height := $maxActionCount * $height-spacer;

    
declare variable $ThisFileContent:=
<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 {$max-Width} 700"> (:first value is x, then y, then max x and y:)
(: original width and height=======width="4000" height="500" :)
<g transform= "translate (25,200)">
<line x1="0" y1="0" x2="{$max-Width}" y2="0" stroke="black" stroke-width="2"/>
(: x axis :)
<line x1="0" y1="0" x2="0" y2="{$max-height}" stroke="black" stroke-width="2"/>
(: y axis :)
{
for $s at $pos in $segments 
let $actions := $s//Q{}action
let $sectionTitle :=
    if ($s//Q{}chapTitles)
        then  $s//Q{}chapTitles/string() ! normalize-space()
    else "intro"
let$speakers := $s//Q{}speaker
let $distSpeakers := $speakers ! normalize-space() => distinct-values()
let $countSpeakers:= $distSpeakers => count()
let $countActions := $actions =>count()

return 


<g>
     <line x1="{$pos * $spacer}" y2="0" y1="{$countActions * $height-spacer}" x2="{$pos * $spacer}" stroke="red" stroke-width="25"/>
    <line x1="{$pos * $spacer+30}" y2="0" y1="{$countSpeakers * $height-spacer}" x2="{$pos * $spacer+30}" stroke="purple" stroke-width="25"/>
    
    <circle cy="-{$countSpeakers * $height-spacer +30}" cx="{$pos * $spacer}"r="{$countActions}"stroke="black" stroke-width="2" fill="red"/>
   <circle cy="-{$pos * $height-spacer}" cx="{$pos * $spacer +30}"r="{$countSpeakers}"stroke="black" stroke-width="2" fill="purple"/>
   
   <text x="{$pos * $spacer +15}" y="20" style ="writing-mode: tb; glyph-orientation-verical:o">{$sectionTitle}</text>
   {$countSpeakers}

    
    
    
    
</g>
}
    
</g>
</svg> ;


 
let $filename := "SVG3attempt.svg"
let $doc-db-uri := xmldb:store("/db/sao5303/",$filename, $ThisFileContent)
return $doc-db-uri 

