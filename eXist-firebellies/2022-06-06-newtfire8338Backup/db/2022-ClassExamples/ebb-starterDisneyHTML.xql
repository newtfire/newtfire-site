xquery version "3.1";
let $disneySongs := collection('/db/disneySongs/')//xml
let $composers := $disneySongs//composer ! normalize-space() => distinct-values()
for $c in $composers
let $songsByThisComposer := $disneySongs[descendant::author/composer = $c]//metadata/title
return concat($c, ': ', string-join($songsByThisComposer, ', '))

