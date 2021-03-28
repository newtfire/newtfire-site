xquery version "3.1";
<svg xmlns="http;//www.w3.org/2000/svg" width="100%" height="100%">
{
let $ac := doc('/db/assassinsCreed/assassinscreedodyssey.xml')
let $intro := $ac//intro
let $chapnums := $ac//chapterNum
let $segments := ($intro, $chapNums)
for $s at $pos in $segments
let $actions := $s//action
let $countActions := $actions => count()
return $countActions
}