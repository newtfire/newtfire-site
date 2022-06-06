xquery version "3.1";
declare variable $radio := collection('/db/holmes/radio-scripts/');
declare variable $mentions := $radio//mention ! normalize-space() => distinct-values();

for $m in $mentions
let $speakers := $radio//ln[.//mention ! normalize-space()=$m]/speaker ! normalize-space() => distinct-values()
for $s in $speakers
let $refs := $radio//ln[.//mention ! normalize-space()=$m][.//speaker ! normalize-space() = $s]/mention/@ref ! tokenize(.,'#')[last()] ! normalize-space() ! upper-case(.) => distinct-values()
for $r in $refs
(:   : ebb: Not working; don't know why. let $baseFiles := $radio[.//ln/mention/@ref ! tokenize(., '#')[last()] = $r] ! base-uri() 
for $b in $baseFiles  :)

return concat($s, ' refers to ', $r ,' as ', $m ,' from file: ' )

