xquery version "3.1";
let $mayangodfile := doc('/db/mayan/PV_characterIndex.xml')
let $characters := $mayangodfile//character
for $c in $characters
where count($c//altName) > 1
let $cname := $c/name ! string()
let $altnames := $c//altName
return concat ($cname, ' otherwise known as ', string-join($c//altName, ' or '))
