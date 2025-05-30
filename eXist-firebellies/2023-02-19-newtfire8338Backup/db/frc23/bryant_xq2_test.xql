xquery version "3.1";
declare default element namespace "http://www.tei-c.org/ns/1.0";

(: Create pokemon variable :)
let $poke := collection('/db/pokemonMap/pokemon')

(: Step 1: Count Pokemon; returns 151 :)
let $numPoke := $poke => count()

(: Step 2: Get file names; tokenizing; retireving last value doesn't seem to have a big impact on the output? Also, I understand the output with my passing familiarity with Pokemon (nerd-cred demolished) but idk if I like how it's presented very much lol :)
let $specPoke := $poke[base-uri()] ! tokenize(.,'/')[last()]
(:  
for $p in $poke
let $fileName := $p => base-uri() 
let $tokenFileName := $fileName ! tokenize(.,'/')[last()]

:)
(: Step 3: Output XML; Y'all the instructions stumped me for a might. I thought we were supposed to add a second collection() node. My bad lol. :)
let $codePoke := $poke/*
(: b.) - <pokemon> is the root :)
(: c.) - <locations><landmark> @n holds location info. :)
(: d.) - Preceeding axis. Also this made me waste a lot of time trying to write an XPath that would return something because - again - I cannot apparently read.:)
(: e.) - Oh gosh. Some combination of parent, preceeding, and child? Please tell me that's overthinking it lolol. :)

(: Step 4: Plagiarism? No. "Extrapolation of academic resources." :)
let $types := $poke//typing/@type/string()
let $distTypes := $types ! upper-case(.) ! tokenize(., ',')[1] ! normalize-space() ! tokenize (., ' ') => distinct-values()

return $types
