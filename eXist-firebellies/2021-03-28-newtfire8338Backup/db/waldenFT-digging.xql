xquery version "3.1";
declare namespace tei="http://www.tei-c.org/ns/1.0";
let $waldenft := collection('/db/waldenft')
let $paras := $waldenft//tei:body//tei:p[not(ancestor::tei:note)]
let $parasWithoutSegs := $paras[not(descendant::tei:seg)]
let $parentfiles := $parasWithoutSegs/base-uri() ! tokenize(., '/')[last()]
let $segsAboveParagraphs := $waldenft//tei:body//tei:seg[not(ancestor::tei:p)]
let $allSegs := $waldenft//tei:body//tei:seg
let $countAllSegs := count($allSegs)
let $segsWithoutAttN := $allSegs[not(@n)]
let $segAtts := $allSegs/@* ! name() => distinct-values()
return $segAtts
