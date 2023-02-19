xquery version "3.1";
declare variable $disney := collection('/db/disneySongs/');
declare variable $ThisFileContent :=
<html>
    <head>
        <title>Disney</title>
    </head>
    <body>

<h1>Titles</h1>
<h1>Voice Actors</h1>
<h1>Roles</h1>

<ol> 
   { let $title := $disneySongs//metadata/title ! normalize-space() => sort()
   for $t in $disneySongs
      return 
       <li>{$t}</li>
       
   }
</ol>

<h2></h2>

<table>
   <tr>
       <th>Title</th>
       <th>Date</th>
       <th>Voice Actor</th>
       <th>Role</th>
   </tr>

{
let $disneySongs := collection('/db/disneySongs/')
    let $title := $disneySongs//title ! normalize-space() => distinct-values() => sort()
     for $t at $pos in $title
       let $date := $disneySongs[.//date ! normalize-space() = $c]//title ! normalize-space() => distinct-values() => sort() => string-join(', ')
       let $movie := $disneySongs//movie
       let $voiceAct := $disneySongs//voiceActor
       let $role := $disneySongs//role

 return $title
     <tr>
          <td>{$pos}</td>
          <td>{$t}</td>
       <td>
          <ol>
              {
                  let $title := $disneySongs//title ! normalize-space() => distinct-values() => sort()
                 for $t at $c in $title
                 return
                <li>Title {$t}: {$t}</li>
               }
          </ol>
      </td>
               
        </tr> 
}



</table>

</body>
</html>
$ThisFileContent

