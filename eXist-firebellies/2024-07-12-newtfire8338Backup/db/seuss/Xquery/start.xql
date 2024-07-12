xquery version "3.1";
declare variable $Seuss := collection('/db/seuss');
(:declare variable $Places := collection('/db/seuss/oh_the_places_you'll_go');:)
declare variable $FoxBox := collection('/db/seuss/FoxinSox1965.xml');
declare variable $Fish := collection('/db/seuss/one_fish_two_fish_1960.xml');
declare variable $Dave := collection('/db/seuss/too_many_daves_1961');
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
                for $t in $titles
        
                return 
                  <tr>
                      <td>{$t ! string()}</td>
                      <td>{$lines</td>
                  </tr>
                
                
                   
                }
             </table>
        </body>     
   </html>;
  $ThisFile
            