xquery version "3.1";
<svg xmlns="http://www.w3.org/2000/svg" width="4600" height="1000">
<g transform="translate(20, 200)">
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

let $countActions := $actions => count()
let $spacer :=150
return
    <g>
        <rect x="{$pos * $spacer}" y="{0 - $countActions}" rx="10" ry="10" width="{$countActions}" height="{$countActions}" stroke="blue" stroke-width="4" fill="turquoise"/>
  <!--2021-03-24 ebb: I'm adding some orange rounded rectangles for you to play with here. One thing you can do is multiply your y and height values by a factor of 5, 
  and just make all the widths the same: that's more the traditional approach for making a bar graph. Your rounded bars are cool, and I like that effect! 
  Here I just multiplied your heights by 5, but notice that I also subtracted from a baseline of 0, to plot those bars going UP the screen, so y = 0 - $countActions.
  What I will usually do is save a number as a variable, called maybe $heightSpacer := 5 , and adjust that as I look at the output.  All bars then grow DOWN the screen to from the count * 5 down to 0. 
  -->   
     <rect x="{$pos * $spacer + 25}" y="{0 - $countActions * 5}" rx="10" ry="10" width="20" height="{$countActions * 5}" stroke="blue" stroke-width="4" fill="orange"/>
        <rect x="{$pos * $spacer + 50}" y="{0 - $countSpeakers * 5}" rx="10" ry="10" width="20" height="{$countSpeakers * 5}" stroke="blue" stroke-width="4" fill="orange"/>
        
        <text x="{$pos * $spacer}" y="75" stroke="blue" style="writing-mode: tb; glyph-orientation-verticated">{$sectionTitle}</text>
        {$countSpeakers}
        <text x="20" y="-40" letter-spacing="4" font-size="50" stroke="blue">How do gameplay actions (blue) vary in relation to number of distinct characters (turquoise) present in game episodes of Assassin's Creed, Odyssey?</text>
    </g>
}
</g>
</svg>
