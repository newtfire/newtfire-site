xquery version "3.1";
let $disney := collection('/db/disneySongs/')/xml
let $metadata := $disney//metadata
let $voiceActor := $metadata//voiceActor
let $collectionCount := $voiceActor => count()
(:   :for $d in $disney
    let $dVA := $d//metadata//voiceActor
    let $dTitle := $d//metadata/title
    let $dVAcount := $dVA => count()
    order by $dVAcount descending
    return ($dTitle || " : " || $dVAcount) :)

let $vaCounts := 
    for $d in $disney
        let $dVA := $d//metadata//voiceActor
        let $dVAcount := $dVA => count()
        order by $dVAcount descending
        return $dVAcount

let $maxCount := $vaCounts => max()
let $minCount := $vaCounts => min()
return $minCount



