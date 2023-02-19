xquery version "3.1";
<html>
    <head>
        <title>Disney Songs</title>
    </head>
<body>
    <h1>Disney Movies with Their Songs and Composers</h1>
   <table>
        <tr><th>Movie Title</th><th>Song Title</th><th>Composers</th></tr>
    {
    let $disneySongs := collection('/db/disneySongs/') 
    (:Grabbing the disney songs collection:)
        for $s in $disneySongs
    (: Creating a variable $s for the collection $disneySongs:)
        let $mt := $s//origin/movie => distinct-values()
        let $st := $s//title => distinct-values()
        let $comp := $s//author/composer => distinct-values()
    (: Creating three variables, Movie Title, Song Title and composer out of the $s variable:)
     
    (: Making the html table with those three variables that I mentioned before:)   
    return 
       <tr>
          <td>{$mt}</td><td>{$st}</td><td>{$comp}</td>
         
               
        </tr> 
   }
   </table>
</body>
</html>

