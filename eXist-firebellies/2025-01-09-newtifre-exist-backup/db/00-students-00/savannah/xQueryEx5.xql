xquery version "3.1";

let $ThisFileContent:=
    <html>
        <!--Your HTML file you're constructing here, complete with XQuery inside -->
        <head><title>Blues Content</title></head>
        <body>
            <h1>Blues Table</h1>
            <table>
                <tr><th>No.</th> <th>Title</th> <th>Record Date</th></tr>
                {
                let $blues := collection('/db/blues')/*
                let $title := $blues//title ! normalize-space() => distinct-values() => sort()
                for $c at $pos in $title
                    let $cDates := $blues[.//title ! normalize-space() = $c]//recordDate ! normalize-space() => distinct-values() => sort() => string-join(', ')
                    return
                        <tr><th>{$pos}</th> <th>{$c}</th> <th>{$cDates}</th></tr>
                
                }
                
            </table>
        </body>
    </html>
(:  :return $ThisFileContent :)

let $filename := "myBluesTable.html"
let $doc-db-uri := xmldb:store("/db/00-students-00/savannah", $filename, $ThisFileContent, "html")
return $doc-db-uri


