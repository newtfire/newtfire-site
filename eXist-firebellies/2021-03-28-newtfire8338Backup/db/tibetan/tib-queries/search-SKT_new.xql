xquery version "3.1";
declare namespace bcrd="http://www.bcrdb.org/ns/1.0";

declare option exist:serialize "method=xhtml media-type=text/html";
declare variable $head-title := "Buddhist Canons Research Database";
declare variable $versionid := "ver. 3.0 (beta 12)";
declare variable $page-title := "Search results";
declare variable $searchphrase := request:get-parameter("searchphrase", ('om'));
declare variable $totalHits := 0;
declare variable $totalTexts := 0;
declare variable $sectionnames := map {
  "1-01": "Vinaya",
  "1-02": "Sūtra",
  "1-03": "Tantra",
  "1-04": "Dhāraṇī",
  "2-01": "Vinaya",
  "2-02": "Sūtra",
  "2-03": "Tantra",
  "2-04": "Dhāraṇī",
  "2-05": "Stotra",
  "2-06": "Prajñāpāramitā",
  "2-07": "Madhyamaka",
  "2-08": "Cittamātra",
  "2-09": "Abhidharma",
  "2-10": "Jataka",
  "2-11": "Letters",
  "2-12": "Pramāṇa",
  "2-13": "Grammar",
  "2-14": "Medicine",
  "2-15": "Arts",
  "2-16": "Political Ethics",
  "2-17": "Catalogues",
  "2-18": "Miscellaneous"
};

(: search-SKT_new.xql ver. 1.00, 2020-03-28 :)
(: --- based on: search-TIB_new.xql ver. 1.08, 2020-03-28 :)
(: search-TIB_new.xql ver. 1.beta09, 2020-05-30 :)

<html>
    <head>
        <meta HTTP-EQUIV="Content-Type" content="text/html; charset=UTF-8"/>
        <title>{$page-title}</title>
    </head>
    <body>
        <center><h1>{$head-title}</h1></center>
        <center><h3>{$versionid}</h3></center>
        <!-- br/ -->
        <center><h1>{$page-title}</h1></center>
        <p>Your query ("{$searchphrase}") returned<!-- {$hitCount} -->:</p>
        {
            (: let $searchresults := collection("/db/tibetan/tibetan-sent")//bcrd:phrase[contains(., $searchphrase)] :)
            let $searchresults := collection("/db/tibetan/SKT")//bcrd:phrase[contains(., $searchphrase)]
            let $sortedsearchresults :=
                for $item in $searchresults
                order by $item/@phr_id
                return $item
            let $secondsortsearchresults :=
                for $item at $spos in $sortedsearchresults
                (: eliminates redundancy within a sentence, but not within a Cluster :)
                where (($spos < 2) or (($spos > 1) and ($item/ancestor::bcrd:sentence/@s_id != $sortedsearchresults[$spos - 1]/ancestor::bcrd:sentence/@s_id)))
                return $item
            for $line at $pos in $secondsortsearchresults,
            $clusterID at $cpos in doc(concat('/db/tibetan/PARID/', string(root($line)/bcrd:bcrdCorpus/bcrd:head/bcrd:unifiedCatalogID), '-PARID.xml'))/descendant::bcrd:sentence/@id[contains(., string($line/ancestor::bcrd:sentence/@s_id))]/ancestor::bcrd:div[@type = "Cluster"]/@id
                    let $uniCatID := string(root($line)/bcrd:bcrdCorpus/bcrd:head/bcrd:unifiedCatalogID)
                    let $foundSentID := string($line/ancestor::bcrd:sentence/@s_id)
                    (: let $hitCount := count($foundSentID) :)
                    (: let $totalHits := $totalHits + $hitCount :)
                    (: let $totalTexts := count(distinct-values($uniCatID)) :)
                    let $refDoc := concat('/db/tibetan/PARID/', $uniCatID, '-PARID.xml')
                    let $parallelSentIDs := doc($refDoc)//bcrd:sentence/@id[contains(., $foundSentID)]/ancestor::bcrd:list//bcrd:sentence/@id
                    let $clusterIDall := doc($refDoc)//bcrd:sentence/@id[contains(., $foundSentID)]/ancestor::bcrd:div[@type = "Cluster"]/@id
                    (: let $clusterIDall := doc(concat('/db/tibetan/PARID/', string(root($line)/bcrd:bcrdCorpus/bcrd:head/bcrd:unifiedCatalogID), '-PARID.xml'))//bcrd:sentence/@id[contains(., string($line/ancestor::bcrd:sentence/@s_id))]/ancestor::bcrd:div[@type = "Cluster"]/@id:)
                    (: let $parallelSents := for $instance in distinct-values($clusterIDall) :)
                    let $parallelSents := for $instance in $parallelSentIDs
                            (: return doc($instFullDBPath//bcrd:sentence/@s_id[contains(., $instance)]//bcrd:sentence :)
                            let $instclusterID := concat($uniCatID, '-', $instance/ancestor::bcrd:div[@type = "Cluster"]/@id)
                            let $instDocID := substring-before($instance, '-SID')
                            let $tempinstDB := replace($instDocID, "[0-9\-]", "")
                            let $printinstDB := replace($instDocID, "[0-9]+\-", "")
                            let $instDB :=
                                if (string-length($tempinstDB) > 2) then
                                    $tempinstDB
                                else
                                    "BOD"
                            let $foundDocID := substring-before($foundSentID, '-SID')
                            let $foundinstDB := replace($foundDocID, "[0-9\-]", "")
                            let $instDocName := concat($instDocID, ".xml")
                            let $instFullDBPath := concat("/db/tibetan/", $instDB, "/", $instDocName)
                            (: let $instSentences := doc($instFullDBPath)//bcrd:sentence/@s_id[contains(., $instance)]/ancestor::bcrd:sentence :)
                            let $instSentences := 
                                if (contains($tempinstDB, 'SKT')) then
                                    (: string(concat(' ', $instance, ' == ', string-join(doc($instFullDBPath)/descendant::bcrd:sentence/@s_id[contains(., $instance)]/ancestor::bcrd:sentence/bcrd:phrase, " | "), " ||")) :)
                                    string(concat(' ', string-join(doc($instFullDBPath)/descendant::bcrd:sentence/@s_id[contains(., $instance)]/ancestor::bcrd:sentence/bcrd:phrase, " | "), " ||"))
                                else if (string-length($tempinstDB) > 2) then
                                    string(concat(' ', string-join(doc($instFullDBPath)/descendant::bcrd:sentence/@s_id[contains(., $instance)]/ancestor::bcrd:sentence/bcrd:phrase, " "), " "))
                                else
                                    string(concat(' ', string-join(doc($instFullDBPath)/descendant::bcrd:sentence/@s_id[contains(., $instance)]/ancestor::bcrd:sentence/bcrd:phrase, " / "), " //"))
                            let $instPhrases := string(concat(' ', string-join($instSentences, " ++ "), " zz"))
                            (: where string-length($instDB) > 2 :)
                            (: let $resultstring := string(concat(" Cluster ", $instclusterID, " - ", $printinstDB, ": ", string-join($instSentences, " / "), " //")) :)
                            let $resultstring := string(concat(' ', string-join($instPhrases, " / "), " //"))
                            (: let $resultmap := map { 'bib': string($bibtitle), 'string': $resultstring } :)
                            (: where $tempinstDB != $foundinstDB :)
                                (: NOTE: This excludes the text of the found returned set :)
                                (: return (concat($instDB, ": ", $instSentences)) :)
                            return $instSentences
                            (: return (concat("<img src='/images/info2.png' width='15' height='15' alt='info icon'/>", "Cluster ", $instclusterID, " - ", $printinstDB, ": ", string-join($instSentences, " / "), " //")) :)
                            (: return $instSentences :)
                    let $parallelBibls := for $instance in $parallelSentIDs
                            let $instDocID := substring-before($instance, '-SID')
                            let $tempinstDB := replace($instDocID, "[0-9\-]", "")
                            let $instDB :=
                                if (string-length($tempinstDB) > 2) then
                                    $tempinstDB
                                else
                                    "BOD"
                            let $foundDocID := substring-before($foundSentID, '-SID')
                            let $foundinstDB := replace($foundDocID, "[0-9\-]", "")
                            let $instDocName := concat($instDocID, ".xml")
                            let $instFullDBPath := concat("/db/tibetan/", $instDB, "/", $instDocName)
                            let $bibauthor := 
                                if (empty(doc($instFullDBPath)/bcrd:bcrdCorpus/bcrd:head/bcrd:sourceDesc/bcrd:bibl/bcrd:author)) then
                                    ""
                                else if (one-or-more(doc($instFullDBPath)/bcrd:bcrdCorpus/bcrd:head/bcrd:sourceDesc/bcrd:bibl/bcrd:author)) then
                                    concat('Author: ', string-join((doc($instFullDBPath)/bcrd:bcrdCorpus/bcrd:head/bcrd:sourceDesc/bcrd:bibl//bcrd:author), '; '), '&#xA;')
                                else
                                    ""
                            let $bibpubl := 
                                if (empty(doc($instFullDBPath)/bcrd:bcrdCorpus/bcrd:head/bcrd:sourceDesc/bcrd:bibl/bcrd:publisher)) then
                                    ""
                                else if (one-or-more(doc($instFullDBPath)/bcrd:bcrdCorpus/bcrd:head/bcrd:sourceDesc/bcrd:bibl/bcrd:publisher)) then
                                    string-join((doc($instFullDBPath)/bcrd:bcrdCorpus/bcrd:head/bcrd:sourceDesc/bcrd:bibl//bcrd:publisher), '; ')
                                else
                                    ""
                            let $bibplace := 
                                if (empty(doc($instFullDBPath)/bcrd:bcrdCorpus/bcrd:head/bcrd:sourceDesc/bcrd:bibl/bcrd:pubPlace)) then
                                    ""
                                else if (one-or-more(doc($instFullDBPath)/bcrd:bcrdCorpus/bcrd:head/bcrd:sourceDesc/bcrd:bibl/bcrd:pubPlace)) then
                                    string-join((doc($instFullDBPath)/bcrd:bcrdCorpus/bcrd:head/bcrd:sourceDesc/bcrd:bibl//bcrd:pubPlace), '; ')
                                else
                                    ""
                            let $bibjourn := 
                                if (empty(doc($instFullDBPath)/bcrd:bcrdCorpus/bcrd:head/bcrd:sourceDesc/bcrd:bibl/bcrd:pubInfo)) then
                                    ""
                                else if (one-or-more(doc($instFullDBPath)/bcrd:bcrdCorpus/bcrd:head/bcrd:sourceDesc/bcrd:bibl/bcrd:pubInfo)) then
                                    concat('in ', (doc($instFullDBPath)/bcrd:bcrdCorpus/bcrd:head/bcrd:sourceDesc/bcrd:bibl//bcrd:pubInfo), '&#xA;')
                                else
                                    ""
                            let $bibvol := 
                                if (empty(doc($instFullDBPath)/bcrd:bcrdCorpus/bcrd:head/bcrd:sourceDesc/bcrd:bibl/bcrd:volumetitle)) then
                                    ""
                                else if (one-or-more(doc($instFullDBPath)/bcrd:bcrdCorpus/bcrd:head/bcrd:sourceDesc/bcrd:bibl/bcrd:volumetitle)) then
                                    concat('in ', (doc($instFullDBPath)/bcrd:bcrdCorpus/bcrd:head/bcrd:sourceDesc/bcrd:bibl//bcrd:volumetitle), '&#xA;')
                                else
                                    ""
                            let $bibdate := 
                                if (empty(doc($instFullDBPath)/bcrd:bcrdCorpus/bcrd:head/bcrd:sourceDesc/bcrd:bibl/bcrd:date)) then
                                    ""
                                else if (one-or-more(doc($instFullDBPath)/bcrd:bcrdCorpus/bcrd:head/bcrd:sourceDesc/bcrd:bibl/bcrd:date)) then
                                    string-join((doc($instFullDBPath)/bcrd:bcrdCorpus/bcrd:head/bcrd:sourceDesc/bcrd:bibl//bcrd:date), '; ')
                                else
                                    ""
                            let $bibinfo := 
                                if (($bibpubl != '') and ($bibplace != '') and ($bibdate != '')) then
                                    concat('Pub: ', $bibplace, ': ', $bibpubl, ' (', $bibdate, ')&#xA;')
                                else if ($bibdate != '') then
                                    concat('Pub: (', $bibdate, ')&#xA;')
                                else
                                    ""
                            let $bibtitle := concat(string($bibauthor), 'Title: ', string(doc($instFullDBPath)/bcrd:bcrdCorpus/bcrd:head/bcrd:sourceDesc/bcrd:bibl/bcrd:title/node()), '&#xA;', string($bibjourn), string($bibvol), string($bibinfo), '&#xA;')
                            (: where $tempinstDB != $foundinstDB :)
                                (: NOTE: This excludes Tib texts by id-ing them as having 1 or 2 char length Sigla :)
                                (: return (concat($instDB, ": ", $instSentences)) :)
                            return $bibtitle
            where (($pos < 200) or (1) or (($pos > 1) and (not ( string(root($searchresults[$pos])/bcrd:bcrdCorpus/bcrd:head/bcrd:unifiedCatalogID) = string(root($searchresults[$pos - 1])/bcrd:bcrdCorpus/bcrd:head/bcrd:unifiedCatalogID) ) or (0) )))
            return
                <p>
                    {
                        (: Set Division Names :)
                        if (($pos < 2) and (substring(string(root($secondsortsearchresults[$pos])/bcrd:bcrdCorpus/bcrd:head/bcrd:unifiedCatalogID/text()), 1, 1) = '1')) then
                            <h1><b>Kangyur Entries:</b></h1>
                        else if (($pos < 2) and (substring(string(root($secondsortsearchresults[$pos])/bcrd:bcrdCorpus/bcrd:head/bcrd:unifiedCatalogID/text()), 1, 1) = '2')) then
                            <h1><b>Tengyur Entries:</b></h1>
                        else  if (($pos < 2) and (substring(string(root($secondsortsearchresults[$pos])/bcrd:bcrdCorpus/bcrd:head/bcrd:unifiedCatalogID/text()), 1, 1) = '3')) then
                            <h1><b>Post-canonical Entries:</b></h1>
                        else if ($pos > 1) then
                            if ((substring(string(root($secondsortsearchresults[$pos])/bcrd:bcrdCorpus/bcrd:head/bcrd:unifiedCatalogID/text()), 1, 1) != substring(string(root($secondsortsearchresults[$pos - 1])/bcrd:bcrdCorpus/bcrd:head/bcrd:unifiedCatalogID/text()), 1, 1) ) and (substring(string(root($secondsortsearchresults[$pos])/bcrd:bcrdCorpus/bcrd:head/bcrd:unifiedCatalogID/text()), 1, 1) = '2')) then
                                <h1><b>Tengyur Entries:</b></h1>
                            else if ((substring(string(root($secondsortsearchresults[$pos])/bcrd:bcrdCorpus/bcrd:head/bcrd:unifiedCatalogID/text()), 1, 1) != substring(string(root($secondsortsearchresults[$pos - 1])/bcrd:bcrdCorpus/bcrd:head/bcrd:unifiedCatalogID/text()), 1, 1) ) and (substring(string(root($secondsortsearchresults[$pos])/bcrd:bcrdCorpus/bcrd:head/bcrd:unifiedCatalogID/text()), 1, 1) = '3')) then
                                <h1><b>Post-canonical Entries:</b></h1>
                            else
                                <p></p>
                        else <p></p>
                    }
                    {
                        (: Set Section Names :)
                        if ($pos < 2) then
                            <h2><b><i><span style='margin-right:1.25em; display:inline-block;'/>{ map:get($sectionnames, substring(string(root($secondsortsearchresults[$pos])/bcrd:bcrdCorpus/bcrd:head/bcrd:unifiedCatalogID/text()), 1, 4) ) } Entries:</i></b></h2>
                        else if ($pos > 1) then
                            if (substring(string(root($secondsortsearchresults[$pos])/bcrd:bcrdCorpus/bcrd:head/bcrd:unifiedCatalogID/text()), 1, 4) != substring(string(root($secondsortsearchresults[$pos - 1])/bcrd:bcrdCorpus/bcrd:head/bcrd:unifiedCatalogID/text()), 1, 4) ) then
                                <h2><b><i><span style='margin-right:1.25em; display:inline-block;'/>{ map:get($sectionnames, substring(string(root($secondsortsearchresults[$pos])/bcrd:bcrdCorpus/bcrd:head/bcrd:unifiedCatalogID/text()), 1, 4) ) } Entries:</i></b></h2>
                            else
                                <p></p>
                        else <p></p>
                    }
                    <ul style="list-style-type:none;">
                    <li>
                        <!-- p>{$pos} - {string(concat('/db/tibetan/PARID/', string(root($line)/bcrd:bcrdCorpus/bcrd:head/bcrd:unifiedCatalogID), '-PARID.xml'))} - {string($clusterID)} in {index-of($secondsortsearchresults, $line)}, from: {$uniCatID} = {string(root($secondsortsearchresults[$pos])/bcrd:bcrdCorpus/bcrd:head/bcrd:unifiedCatalogID/text())}, <b>{string(root($line)/bcrd:bcrdCorpus/bcrd:head/bcrd:sourceDesc/bcrd:bibl/bcrd:author)} // {string(root($line)/bcrd:bcrdCorpus/bcrd:head/bcrd:title)}</b>, {string($line/@phr_id)}</p -->
                    {
                        (: check for author and multiple occurences in same text :)
                        if (($pos < 2) and (string-length(string(root($line)/bcrd:bcrdCorpus/bcrd:head/bcrd:author)) > 0)) then
                            <h3><b>{string(root($line)/bcrd:bcrdCorpus/bcrd:head/bcrd:author)} // {string(root($line)/bcrd:bcrdCorpus/bcrd:head/bcrd:title)}</b></h3>
                        else if (($pos < 2) and (string-length(string(root($line)/bcrd:bcrdCorpus/bcrd:head/bcrd:author)) < 1)) then
                            <h3><b>{string(root($line)/bcrd:bcrdCorpus/bcrd:head/bcrd:title)}</b></h3>
                        else if ((string(root($secondsortsearchresults[$pos])/bcrd:bcrdCorpus/bcrd:head/bcrd:unifiedCatalogID/text()) ne string(root($secondsortsearchresults[$pos - 1])/bcrd:bcrdCorpus/bcrd:head/bcrd:unifiedCatalogID/text())) and (string-length(string(root($line)/bcrd:bcrdCorpus/bcrd:head/bcrd:author)) > 0)) then
                            <h3><b>{string(root($line)/bcrd:bcrdCorpus/bcrd:head/bcrd:author)} // {string(root($line)/bcrd:bcrdCorpus/bcrd:head/bcrd:title)}</b></h3>
                        else if ((string(root($secondsortsearchresults[$pos])/bcrd:bcrdCorpus/bcrd:head/bcrd:unifiedCatalogID/text()) ne string(root($secondsortsearchresults[$pos - 1])/bcrd:bcrdCorpus/bcrd:head/bcrd:unifiedCatalogID/text())) and (string-length(string(root($line)/bcrd:bcrdCorpus/bcrd:head/bcrd:author)) < 1)) then
                            <h3><b>{string(root($line)/bcrd:bcrdCorpus/bcrd:head/bcrd:title)}</b></h3>
                        else
                            <span></span>
                    }
                    <i><b>{string($line)}</b></i><!-- in {$foundSentID} -->:<br/>
                    <i>{concat(string-join(($line/ancestor::bcrd:sentence//bcrd:phrase), " / "), " //")}</i>
                    <ul>in parallel passages:
                    <!-- {if (count($parallelSents) > 0) then
                    <p>Parallel sentences:</p>
                    else <p>No language parallels.</p>} -->
                    <!-- p>{$refDoc}</p -->
                    <!-- p>{$foundSentID}</p -->
                    <!-- p>{string-join($parallelSentIDs, ' // ')}</p -->
                    <!-- ul>{for $myone in $parallelSents return <li>{string-join($myone/phrase/text(), " / ")}</li>}</ul -->
                    <!-- ul>{for $myone in $parallelSentIDs return <li>{$myone/string()}</li>}</ul -->
                    <!-- ul>{for $mytwo in $parallelSents, $mythree in $parallelBibls return <li><img source='/images/info2.png' width='15' height='15' alt='info icon' title='{$mythree}'/>{position()} {$mytwo}</li>}</ul -->
                    <ul>{for $x at $position in $parallelSents 
                        return 
                                <li>
                                    <img src='../images/info2.jpg' width='15' height='15' title='{$parallelBibls[$position]}'/> <!--{$position} = {position()}: --> {$x}
                                </li>
                    }
                    <!-- ul>{for $myone in $parallelSents return <li>{$myone/@s_id}</li>}</ul -->
                </ul></ul></li></ul>
            </p>}
        <br/>
        <!-- p>For a total of {$hitCount} hits in </p -->
    </body>
</html>
