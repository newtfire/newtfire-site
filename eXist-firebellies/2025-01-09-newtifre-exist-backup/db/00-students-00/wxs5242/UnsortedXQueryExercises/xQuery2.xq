xquery version "3.1";

let $disneySongs := collection('/db/disneySongs/')




let $songs := $disneySongs//song
let $lyrics :=
    for $l in $songs ! string() ! normalize-space()
        let $line := $disneySongs//ln ! text()
        let $corline := $line ! concat(., '.&#10;')
        return $corline
    
return $lyrics

(: let $disneySongs := collection('/db/disneySongs/')//*
for $d in $disneySongs
    let $title := $d//metadata/title
    let $count := $d//ln => count()
    return $count:)