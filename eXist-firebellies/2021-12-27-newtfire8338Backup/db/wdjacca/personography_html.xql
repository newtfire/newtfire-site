xquery version "3.1";
 declare variable $collection := collection('/db/disneySongs/aladdin');
declare variable $thisFileContent :=
<html>
    <head>
        <meta charset="UTF-8"/>
        <title>Personography List</title>
        <link href="aladdin.css" rel="stylesheet" type="text/css"/>
        <script src="highlighting.js"></script>
    </head>
    <body>
        <!--#include virtual="aladdin_header.html" -->
        <h4>Personography List</h4>
        <div id="sidebar">
            <div id="legend">
                <div id="fieldset">
                    <fieldset>
                        <legend>Click to Highlight:</legend>
                         <input type="checkbox" id="toggle" name="crossFran"/>
                         <label for="crossFran"> Cross-Franchise </label>
                    </fieldset>
                </div>
            </div>
        </div>
        <ul id="content">
    {let $composer := $collection//composer ! normalize-space () => distinct-values() => sort()
    for $c in $composer
    let $cref := $collection//composer[. ! normalize-space() =$c ]/@ref ! normalize-space () ! tokenize(.,"#")[last()] => distinct-values()
   return <li><a href="#{$cref}">{$c}</a></li>}
       {let $lyricist := $collection//lyricist ! normalize-space () => distinct-values() => sort()
    for $l in $lyricist
    let $lref := $collection//lyricist[. ! normalize-space() =$l ]/@ref ! normalize-space () ! tokenize(.,"#")[last()] => distinct-values()
   return <li><a href="#{$lref}">{$l}</a></li>}
   {let $voiceActor := $collection//voiceActor ! normalize-space () => distinct-values() => sort()
    for $va in $voiceActor
    let $varef := $collection//voiceActor[. ! normalize-space() =$va ]/@ref ! normalize-space () ! tokenize(.,"#")[last()] => distinct-values()
   return <li><a href="#{$varef}">{$va}</a></li>}

</ul>
</body>
</html>;
let $filename := "personography-aladdin.html"
let $doc-db-uri := xmldb:store("/db/disneySongs-queries/", $filename, $thisFileContent, "html")
return $doc-db-uri   
(: View this xml at http://newtfire.org:8338/exist/rest/db/disneySongs-queries/listofRef.xml:)