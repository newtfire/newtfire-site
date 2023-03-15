xquery version "3.1";
declare variable $Seuss := collection('/db/seuss');
declare variable $ThisFile := 
<html>
    <head><title>Seuss</title></head>
            <body>
                <table> 
                    <tr>
                        <th>Books</th>
                        <th>Count of Lines in Each Book</th>
                    </tr>
                    
                {
     
                let $titles := $Seuss//title 
                let $lines := $Seuss//title/l
                 for $t in $titles
        
                return 
                  <tr>
                      <td>{$t ! string()}</td>
                      <td>{$lines => count()}</td>
                  </tr>
                
                   
                }
             </table>
        </body>     
   </html>;
  $ThisFile
            