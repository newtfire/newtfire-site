xquery version "3.1";
<html>
    <head><title>Organizations that founded the Arboretum</title></head>
<body>
    <h1>Organizations that founded the Arboretum</h1>
    <table>
        <tr>
            <th>Organizations</th>
            <th>Paragraph</th>
            <th>Title</th>
            <!--Found in Article-->
        </tr>
{
let $newspaperArticles := collection('/db/btrees/articles/')/*
let $body := $newspaperArticles//body
let $header := $body//header 
let $title := $header//title ! normalize-space() => distinct-values()
let $p := $body//p
let $orgs := $p/org ! normalize-space() => distinct-values() => sort()
for $o in $orgs
let $orgparas := $body//p[org ! normalize-space() = $o]/@n ! string() => sort()
let $orgtitles := $body[.//org ! normalize-space() = $o]//header/title/text()
return (: concat($o, '.......', string-join($orgparas, ',')):)
<tr>
    <td>{$o}</td>
    <td>
        <ul>{for $p in $orgparas
        return
            <li>{$p
            }</li>
        } 
        </ul>
    </td>
    <td>
      <ul>{ for $t in $orgtitles
      return
          <li>{$t}
              
          </li>
      }
          
      </ul>  
    </td>
</tr>
}
</table> 
</body>
</html>
(: $title, ':',string-join, :)
(: I am trying to print the title of the article when the orgname pops up in a paragraph number :)
