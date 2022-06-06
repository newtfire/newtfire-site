# XML/XQUERY Exercise 3 

1. 
xquery version "3.1";
let $disneySongs := collection('/db/disneySongs/')
for $d in $disneySongs
let $title := $d//metadata/title
return $title

This xpath grabs the 93 disney songs from the collection and specifically analyzes the title of them by going down into the the metadata which contains the needed information. 

2. 
xquery version "3.1";
let $disneySongs := collection('/db/disneySongs/')
for $d in $disneySongs
let $title := $d//metadata/title
let $lineCount := $d//ln => count()
return $lineCount

Using this xpath it is able to find the linecount of all the songs. But when you add the => count() function and return $lineCount it gets the number of lines split up by each individual song. 

3. 
let $songSL := $d//song ! string-length() 
return $songSL

This gives the amount of text per song. After discussing in class this gives a skewed number because of the excessive amount of space characters in the songs

The work I had done before using class video in the media gallery to finish the assignment. 