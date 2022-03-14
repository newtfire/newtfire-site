xquery version "3.1";
<html>
    <head>
        <title>Behrend Trees</title>
    </head>
    
    <body>
        <h1>Behrend Trees and their Average Heights</h1>
        <table> 
            <tr><th>Common Name</th> <th>Average Height</th></tr>
            {
            let $btrees := doc('/db/btrees/btrees_tree_book.xml')/*
            let $entries := $btrees/entry
            
            for $e at $pos in $entries
            let $cname := $e/cname ! text()
            let $height := $e/height/@avg ! data()
            return 
                <tr><td>{$cname}</td><td>{$height}</td></tr>
            }
        </table>
    </body>
</html>
