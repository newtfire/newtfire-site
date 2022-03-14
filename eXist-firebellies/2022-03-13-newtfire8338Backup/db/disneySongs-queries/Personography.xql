xquery version "3.1";
 declare variable $collection := collection('/db/disneySongs/');
declare variable $thisFileContent :=
<xml>
    <title>Personography List</title>
    <listPerson>
    {let $composer := $collection//composer ! normalize-space () => distinct-values() => sort()
    for $c in $composer
    let $cref := $collection//composer[. ! normalize-space() =$c ]/@ref ! normalize-space () ! tokenize(.,"#")[last()] => distinct-values()
   return <person xml:id="{$cref}"> {$c} </person>}
       {let $lyricist := $collection//lyricist ! normalize-space () => distinct-values() => sort()
    for $l in $lyricist
    let $lref := $collection//lyricist[. ! normalize-space() =$l ]/@ref ! normalize-space () ! tokenize(.,"#")[last()] => distinct-values()
   return <person xml:id="{$lref}"> {$l} </person>}
   {let $voiceActor := $collection//voiceActor ! normalize-space () => distinct-values() => sort()
    for $va in $voiceActor
    let $varef := $collection//voiceActor[. ! normalize-space() =$va ]/@ref ! normalize-space () ! tokenize(.,"#")[last()] => distinct-values()
   return <person xml:id="{$varef}"> {$va} </person>}
   </listPerson>




</xml>;
let $filename := "Personography.xml"
let $doc-db-uri := xmldb:store("/db/disneySongs-queries/", $filename, $thisFileContent, "xml")
return $doc-db-uri   
(: View this xml at http://newtfire.org:8338/exist/rest/db/disneySongs-queries/listofRef.xml:)