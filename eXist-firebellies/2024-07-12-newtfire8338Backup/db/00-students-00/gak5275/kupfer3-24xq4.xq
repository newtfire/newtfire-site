xquery version "3.1";
let $disneySongs := collection('/db/disneySongs/')
    let $actors := $disneySongs//voiceActor
    let $roles := $disneySongs//@role
    return ($actors || " - " || $roles)