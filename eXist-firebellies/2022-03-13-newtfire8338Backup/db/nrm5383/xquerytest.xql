xquery version "3.1";
<html>
    <title> X Query Test </title>
    <head></head>
    <body>
        <table><tr><th>Loop Position</th><th>Section Title</th><th>Speech Count</th><th>Speaker Count</th></tr>
        {
            let $collection := doc('/db/assassinsCreed/assassinscreedodyssey.xml')
            let $intro := $collection//intro
            let $numChap := $collection//chapterNum
            let $section := ($intro, $numChap)
            for $s at $pos in $section
            let $title := 
            if ($s[$pos = 1])
            then 'intro'
            else $s//chapTitles
            let $speechCount := $s//sp => count () 
            let $speaker := $s//speaker ! normalize-space() => distinct-values() => count()
            order by $speechCount descending
            return 
                <tr><td>{$pos}</td><td>{$title}</td><td>{$speechCount}</td><td>{$speaker}</td></tr>
        }
        </table>
    </body>
</html>
(:  return concat('For Loop Position: ', $pos,', Section Title: ', $title,', Speech Count: ', $speechCount, ', Speaker Count: ', $speaker):)
