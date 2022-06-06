xquery version "3.1";
let $mayangodfile := doc('/db/mayan/PV_characterIndex.xml')
let $characters := $mayangodfile//character
for $c in $characters
where count($c//altName) >= 1
let $cname := $c/name ! string()
let $altnames := $c//altName ! string()
let $allNames := ($cname, $altnames)
let $bloodGods := $allNames[matches(., '[Bb]lood')]
(: ebb: This uses the XPath matches() function which matches on a regular expression. If you want the literal word "Blood" with the capital B, you could just go with contains(). 
 : These functions take two arguments for finding bits of string in your XML, and we think of them as
 : finding needles in haystacks: the first argument is the haystack, indicating what XML node you're looking in. The second describes the string you're trying to find:
 Here the haystack is the self node, or the dot. Look RIGHT HERE in the node we're on (either //name or //altName).
: If it's true that "Blood" or "blood" is in here, return the node. :) 
for $b in $bloodGods
let $xmlids := $characters[.//* ! string() = $b]/@xml:id ! string()
for $x in $xmlids
return concat($b, ' has some relationship to: ', $x)

