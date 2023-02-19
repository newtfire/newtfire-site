xquery version "3.1";
declare default element namespace "http://www.tei-c.org/ns/1.0";
(: For XQuery Exercise 2, we'll be exploring FLWOR statements and XPath functions count() and distinct-values() :)
(: Big Task: Which Shakespeare plays have more than 50 distinct speakers?  :)
let $plays := collection('/db/apps/shakespeare/data/')//TEI
(: //TEI//sp[speaker="Falstaff"] => count() :)
let $speakers := $plays//speaker 
let $distSpeakers := $speakers => distinct-values()
(: 966 distinct speakers in all the plays: Almost a cast of thousands? :)
(: But how many are in *each* play? For that, we need a for statement.:)
let $countDS := $distSpeakers => count()
for $p at $pos in $plays
   let $countSpk := $p//speaker => distinct-values() => count()
   let $title := $p//titleStmt/title ! string()
   let $filePath := $p ! base-uri(.) ! tokenize(., '/')[last()]
   where $countSpk > 50
   return 
      concat($filePath, " is ", $title, ": ", $countSpk) 




