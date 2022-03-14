xquery version "3.1";

<html>
    <head><title>Years When Cars Were Manufactured</title></head>
    
    <body>
      <h1> Years When Cars Were Manufactured </h1>
     <table>
      <tr>
          <th>Year</th>
          <th>Cars Manufactured</th>
      </tr>
       {
        let $car := collection('/db/auto')/*
let $build := $car//built
let $year := $build/@when ! string () => distinct-values() =>sort ()


for $y in $year
let $name := $car[.//built/@when=$y]//name/text()

return 
    <tr>
        <td>{$y}</td>
    <td>
    <ul>
        {for $n in $name
            return
                <li>{$n}</li>
        }
    </ul>
        </td>
    </tr>
       }
    </table>
</body>
  
    
</html>