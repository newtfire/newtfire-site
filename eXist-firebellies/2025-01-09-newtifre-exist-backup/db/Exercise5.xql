xquery version "3.1";

declare variable $ThisFileContent:=
  <html>
    <html>
  <head>
    <title>Blues Artists</title>
  </head>
  <body>
    <table>
      <thead>
        <tr>
          <th>Artist</th>
          <th>Title</th>
        </tr>
      </thead>
      <tbody>
        {
          for $song in collection("/db/blues")//blues:song
          return
            <tr>
              <td>{ $song/blues:metadata/blues:artist/text() }</td>
              <td>{ $song/blues:metadata/blues:title/text() }</td>
            </tr>
        }
      </tbody>
    </table>
  </body>
</html>
    {
      declare namespace blues = "http://newtfire.org:rest/db/2023-Class-Examples/bluesArtistTable.html.;
      <html>
        <head>
          <title>Blues Artists</title>
        </head>
        <body>
          <table>
            <thead>
              <tr>
                <th>Artist</th>
                <th>Title</th>
              </tr>
            </thead>
            <tbody>
              {
                for $song in collection("/db/blues")//blues:song
                return
                  <tr>
                    <td>{ $song/blues:metadata/blues:artist/text() }</td>
                    <td>{ $song/blues:metadata/blues:title/text() }</td>
                  </tr>
              }
            </tbody>
          </table>
        </body>
      </html>
    }
  </html>;

let $filename := "bluesArtists.html"
let $doc-db-uri := xmldb:store("/db/2023-Class-Examples", $filename, $ThisFileContent, "html")
return $doc-db-uri