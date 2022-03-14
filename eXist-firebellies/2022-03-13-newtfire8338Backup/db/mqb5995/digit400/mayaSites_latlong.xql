xquery version "3.1";

let $sites := doc('/db/mayan/sitesIndex.xml')
let $site := $sites//site
for $s in $site
where $s/location/@lat ! data() > 18.3
and $s/location/@long ! data() > -92.3
let $lats := $s/location/@lat ! data()
let $long := $s/location/@long ! data()
let $yucatan := $s/name ! string()
let $yLat := $s/location/@lat ! string()
let $yLong := $s/location/@long ! string()
return concat($yucatan, ' (', $yLat, ', ', $yLong, ') ', 'is an ancient Maya site in the Yucatan Peninsula.')
