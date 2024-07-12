xquery version "3.1";

declare option exist:serialize "method=xhtml media-type=text/html";
declare variable $page-title := "Tibetan Text Rendering with XSLT";
declare variable $searchphrase := request:get-parameter("searchphrase", ('2-07-00048-D3871'));

<html>
    <head>
        <meta HTTP-EQUIV="Content-Type" content="text/html; charset=UTF-8"/>
        <title>{$page-title}</title>
    </head>
    <body>
        <h1>
            <center>Buddhist Canons Research Database</center>
        </h1>
        <h3>
            <center>ver. 3.0 (beta 12b)</center>
        </h3>
        <h2><center>{$page-title} for</center></h2>
        <h2>
            <center>Unified Text ID # {$searchphrase}</center>
        </h2>
{
let $paraDoc := string(concat('/db/tibetan/BOD/', $searchphrase, '.xml'))
(:   :let $input := doc("/db/apps/demo/examples/basic/Items.xml") :)
(:   :let $xsl := doc("/db/apps/demo/examples/basic/ConvertItems.xsl") :)
(:   :let $input := doc("/db/tibetan-sent/2-03-00256-D1445.xml") :)
let $input := doc($paraDoc)
let $xsl := doc("/db/tibetan/xslt/xsltStarter1_bcrd_template2.xsl")
return
    transform:transform($input, $xsl, ())
}
</body>
</html>
