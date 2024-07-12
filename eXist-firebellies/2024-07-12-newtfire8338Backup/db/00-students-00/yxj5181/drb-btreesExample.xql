xquery version "3.1";
(: This is a comment in XQuery :)
(: Now we will create a variable, using a FLWOR statement :)
(:  FLWOR means: For, Let, Where, Order by, Return :)
 (: Every FLWOR MUST have Let and Return :)

<html>
  <head>
      <title>Data from the Behrend Trees Project</title>
  </head>
 <body>
     <h1>Behrend Trees and their Average Heights</h1>
<table>
    <tr><th>Common Name</th> <th>Average height</th></tr>
{
let $btrees := doc('/db/btrees/btrees_tree_book.xml')/*
let $entries := $btrees/entry
(: Let us write a for-loop over the entries :)

for $e at $pos in $entries
let $cname := $e/cname ! text()
let $height := $e/height/@avg ! data()
return
    <tr> 
        <td>{$cname}</td>
        <td>{$height}</td>
    </tr>
}
</table>

</body>
</html>


