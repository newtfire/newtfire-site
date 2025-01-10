xquery version "3.1";
let $disney := collection('/db/disneySongs/')/*
let $metadata := $disney//metadata
let $voiceActor := $metadata//voiceActor
let $actorFiles := $voiceActor ! base-uri()
let $simpleFileNames := $actorFiles ! tokenize(., '/')[last()]
return $simpleFileNames
