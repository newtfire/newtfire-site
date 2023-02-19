xquery version "3.1";
declare variable $radio := collection('/db/holmes/radio-scripts/');
declare variable $lns := $radio//ln[.//mention];

for $l in $lns
let $mentions := $l//mention
for $m in $mentions
let $speaker:= $l[.//mention =$m]/speaker ! normalize-space()
let $ref := $m/@ref ! normalize-space()
return concat ( $speaker, ' refers to ', $ref ! upper-case(.),' as ', $m ! normalize-space() ! upper-case(.))


