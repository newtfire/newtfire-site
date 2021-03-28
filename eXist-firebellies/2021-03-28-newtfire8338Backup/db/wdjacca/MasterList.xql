xquery version "3.1";
declare variable $collection := collection('/db/disneySongs/');
declare variable $thisFileContent := 
<xml>
    <title>List of Composers</title>
    <listComposer>
    {let $composer := $collection//composer ! normalize-space () => distinct-values() => sort()
for $c in $composer
let $ref := $collection//composer[. ! normalize-space() =$c ]/@ref ! normalize-space () ! tokenize(.,"#")[last()] => distinct-values()

return <person xml:id="{string-join($ref, ',')}">{$c}</person>}</listComposer>
   <listLyrics>
    {let $lyric := $collection//lyricist ! normalize-space () => distinct-values() => sort()
for $l in $lyric
let $ref := $collection//lyricist[. ! normalize-space() =$l ]/@ref ! normalize-space () ! tokenize(.,"#")[last()] => distinct-values()

return <person xml:id="{string-join($ref, ',')}">{$l}</person>}</listLyrics>
   <listVoiceActor>
    {let $voiceActor := $collection//voiceActor ! normalize-space () => distinct-values() => sort()
for $va in $voiceActor
let $ref := $collection//voiceActor[. ! normalize-space() =$va ]/@ref ! normalize-space () ! tokenize(.,"#")[last()] => distinct-values()

return <person xml:id="{string-join($ref, ',')}">{$va}</person>}</listVoiceActor>
</xml>
;
let $filename := "masterList.xml"
let $doc-db-uri := xmldb:store("/db/wdjacca/", $filename, $thisFileContent, "xml")
return $doc-db-uri   
(: View this xml at http://newtfire.org:8338/exist/rest/db/wdjacca/masterList.xml  :)