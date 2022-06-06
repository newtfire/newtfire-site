# XPATH/XQUERY Exercise 2

1. let $plays := collection('/db/apps/shakespeare/data/')//TEI

This pulls the collectin from the exist database that we are using to evaluate documents using XPATH

2. let $speakers := $plays//speaker 

This pulls all the speakers from the play instead of diving down and pulling individual speakers like we had to do on XPATH exercise 1 with Falstaff.

3. let $distSpeakers := $speakers => distinct-values()



4. return $distSpeakers => count()

This gives a count of 966 distinct speakers that are in the collection

5. for $p at $pos in $plays
