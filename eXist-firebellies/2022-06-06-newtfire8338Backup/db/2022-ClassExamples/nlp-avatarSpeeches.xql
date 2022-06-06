xquery version "3.1";
(: Pulling texts of speeches from the Avatar collection :)
(:   :declare variable $textFile := :)
(:   :string-join( :)
let $avatarEpisodes := collection('/db/avatar/AvatarScripts')
(: In this version of the network, we start with Source nodes as a sequence of all distinct speakers throughout the series. :)




   
    (: "&#10;"); line separator:)

(:   :let $filename := "avatarSpeeches.txt"
let $doc-db-uri := xmldb:store("/db/2022-ClassExamples", $filename, $textFile, "text/plain")
return $doc-db-uri  :)


