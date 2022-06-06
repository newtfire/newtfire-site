xquery version "3.1";
let $mayangodfile := doc('/db/mayan/PV_characterIndex.xml')
let $characters := $mayangodfile//character
for $c in $characters
where count($c//altName) >= 1
let $cname := $c/name ! string()
let $altnames := $c//altName
let $allnames := ($cname, $altnames)
    for $a in $allnames
    let $cname := $characters[.//* = $a]/name ! string()
    for $n in $cname
return concat ($a, ' is another name for ', $n, '.')
