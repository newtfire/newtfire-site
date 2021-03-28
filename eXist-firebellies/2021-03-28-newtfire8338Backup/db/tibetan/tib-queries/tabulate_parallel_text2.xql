declare option exist:serialize "method=xhtml media-type=text/html";
declare variable $page-title := "Tabular Data with XSLT";
declare variable $searchphrase := request:get-parameter("searchphrase", ('2-07-00048'));

let $paraDoc := string(concat('/db/tibetan/PARID/', $searchphrase, '-PARID.xml'))
let $input := doc($paraDoc)
let $xsl := doc("/db/tibetan/xslt/xslt_parid_table_v16b.xsl")
return
    transform:transform($input, $xsl, ())

