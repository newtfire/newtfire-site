xquery version "3.1";
declare variable $ySpacer := 10;
declare variable $xSpacer := 10;

<svg width="630" height="360">
<defs>
    <linearGradient id="grad2" x1="0%" y1="0%" x2="0%" y2="100%">
      <stop offset="0%" style="stop-color:rgb(255,0,0);stop-opacity:1" />
      <stop offset="100%" style="stop-color:rgb(255,255,0);stop-opacity:1" />
    </linearGradient>
  </defs>
<g>
{
 let $avatar := collection('/db/avatar/AvatarScripts')
       let $character := $avatar//speech[matches(.,'[Hh]on[ou]r')]/@speaker ! normalize-space() => distinct-values() => sort() 
       let $charactersSortedByCount := 
            for $c in $character 
            let $honorCount := $avatar//speech[.//matches(.,'[Hh]on[ou]r')][@speaker ! normalize-space()=$c] => count()
            order by $honorCount descending
            return $c
        for $a at $pos in $charactersSortedByCount
        let $honorCount := $avatar//speech[.//matches(.,'[Hh]on[ou]r')][@speaker ! normalize-space()=$a] => count()
        return
        (:return concat($pos,".) ",$a,": ",$honorCount:)

<g transform="translate(30, 336)">
   <polygon transform="scale(-1, 1) translate(-590,-2)" points="{$pos * $xSpacer - 5},0 {$pos * $xSpacer - 5 + 5}, 0 {$pos * $xSpacer - 5 + 5}, -{2 * $honorCount * $ySpacer} {$pos * $xSpacer - 5}, -{2 * $honorCount * $ySpacer + 2}" fill="url(#grad2)" stroke="black"/>
   <line x1="335" x2="690" y1="-2.5" y2="-2.5" stroke-width="5" stroke="black"/>
   <line x1="335" x2="690" y1="-308" y2="-308" stroke-width="5" stroke="black"/>
   <line x1="335" x2="335" y1="0" y2="-305" stroke-width="5" stroke="black"/>
   <line x1="590" x2="590" y1="0" y2="-305" stroke-width="5" stroke="black"/>
   
   
   
   
   
   
   <text x="300" y="-94" font-size="20" font-family="georgia">5</text>
   <text x="300" y="-194" font-size="20" font-family="georgia">10</text>
   <text x="300" y="-294" font-size="20" font-family="georgia">15</text>
   
   <text transform="rotate(90)" font-size="6" font-family="georgia" x="{$pos * $xSpacer}" y="20">{$a}</text>
   
   
   
   
   <text x="300" y="-320" font-size="20" font-family="georgia">Times "Honor" Said by Characters</text>
</g>
}
</g>
</svg>