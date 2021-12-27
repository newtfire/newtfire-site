xquery version "3.1";
declare namespace bcrd="http://www.bcrdb.org/ns/1.0";
declare namespace functx = "http://www.functx.com";
declare function functx:escape-for-regex
  ( $arg as xs:string? )  as xs:string {

   replace($arg,
           '(\.|\[|\]|\\|\||\-|\^|\$|\?|\*|\+|\{|\}|\(|\))','\\$1')
 } ;
declare function functx:substring-after-last
  ( $arg as xs:string? ,
    $delim as xs:string )  as xs:string {
    replace ($arg,concat('^.*',functx:escape-for-regex($delim)),'')
 } ;
declare option exist:serialize "method=xhtml media-type=text/html";
declare variable $head-title := "Buddhist Canons Research Database";
declare variable $versionid := "ver. 3.0 (beta 16)";
declare variable $page-title := "Search results";
declare variable $searchphrase := request:get-parameter("searchphrase", ());
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
  "2-18": "Miscellaneous",
  "9-01": "Mind Training"
};

(: search-2_new.xql ver. 1.01, 2020-03-16 :)
(: search-2_new.xql ver. 1.02, 2020-03-19 :)
(: search-2_new.xql ver. 1.03, 2020-03-21 :)
(: search-2_new.xql ver. 1.04, 2020-03-22 :)
(: search-2_new.xql ver. 1.05, 2020-03-22 :)
(: search-2_new.xql ver. 1.06, 2020-03-23 :)
(: search-2_new.xql ver. 1.07, 2020-03-28 :)
(: search-TIB_new.xql ver. 1.08, 2020-03-28 :)
(: search-TIB_new.xql ver. 1.09, 2020-04-03 :)
(: search-TIB_new.xql ver. 1.beta12, 2020-04-04 :)
(: search-TIB_new.xql ver. 1.beta13, 2020-04-08 :)
(: search-TIB_new.xql ver. 1.beta14, 2020-05-21 :)
(: search-TIB_new.xql ver. 1.beta15, 2020-05-31 :)
(: search-TIB_new.xql ver. 1.beta16, 2020-06-03 :)
(: search-TIB_new.xql ver. 1.beta17, 2020-09-10 :)

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
        <p></p>
        {
            (: let $searchresults := collection("/db/tibetan/tibetan-sent")//bcrd:phrase[contains(., $searchphrase)] :)
            let $searchresults := collection("/db/tibetan/BOD")//bcrd:phrase[contains(., $searchphrase)]
            let $sortedsearchresults :=
                for $item in $searchresults
                (: sort by Sentence id :)
                order by $item/parent::sentence/@s_id
                return $item
            let $secondsortsearchresults :=
                for $item at $spos in $sortedsearchresults
                (: eliminates redundancy within a sentence, but not within a Cluster :)
                where (($spos < 2) or (($spos > 1) and ($item/ancestor::bcrd:sentence/@s_id != $sortedsearchresults[$spos - 1]/ancestor::bcrd:sentence/@s_id)))
                return $item
            let $thirdsortsearchresults :=
                for $item at $tpos in $secondsortsearchresults, $clusterID in doc(concat('/db/tibetan/PARID/', string(root($item)/bcrd:bcrdCorpus/bcrd:head/bcrd:unifiedCatalogID), '-PARID.xml'))/descendant::bcrd:sentence/@id[contains(., string($item/ancestor::bcrd:sentence/@s_id))]/../../../parent::bcrd:div/@id
                (: sort by Cluster id :)
                order by $clusterID
                return $item
            let $clusterresults :=
                for $item at $tpos in $secondsortsearchresults, $clusterID in doc(concat('/db/tibetan/PARID/', string(root($item)/bcrd:bcrdCorpus/bcrd:head/bcrd:unifiedCatalogID), '-PARID.xml'))/descendant::bcrd:sentence/@id[contains(., string($item/ancestor::bcrd:sentence/@s_id))]/../../../parent::bcrd:div/@id
                (: sort by Cluster id :)
                order by $clusterID
                return $clusterID
            let $fourthsortsearchresults :=
                for $item at $tpos in $thirdsortsearchresults
                (: eliminates redundancy within a Cluster :)
                where (($tpos < 2) or (($tpos > 1) and ($clusterresults[$tpos] != $clusterresults[$tpos - 1])))
                return $item
            (: Calculate total hits, but unsure how to print :)
            let $resultcount := count($fourthsortsearchresults)
            for $line at $pos in $fourthsortsearchresults,
            $clusterID at $cpos in doc(concat('/db/tibetan/PARID/', string(root($line)/bcrd:bcrdCorpus/bcrd:head/bcrd:unifiedCatalogID), '-PARID.xml'))/descendant::bcrd:sentence/@id[contains(., string($line/ancestor::bcrd:sentence/@s_id))]/ancestor::bcrd:div[@type = "Cluster"]/@id
                    let $uniCatID := string(root($line)/bcrd:bcrdCorpus/bcrd:head/bcrd:unifiedCatalogID)
                    let $foundSentID := string($line/ancestor::bcrd:sentence/@s_id)
                    (: let $hitCount := count($foundSentID) :)
                    (: let $totalHits := $totalHits + $hitCount :)
                    (: let $totalTexts := count(distinct-values($uniCatID)) :)
                    let $refDoc := concat('/db/tibetan/PARID/', $uniCatID, '-PARID.xml')
                    let $parallelSentIDs := doc($refDoc)//bcrd:sentence/@id[contains(., $foundSentID)]/ancestor::bcrd:list//bcrd:sentence/@id
                    let $parallelGroups := doc($refDoc)//bcrd:sentence/@id[contains(., $foundSentID)]/../../parent::bcrd:list//bcrd:div
                    let $clusterIDall := doc($refDoc)//bcrd:sentence/@id[contains(., $foundSentID)]/ancestor::bcrd:div[@type = "Cluster"]/@id
                    let $parallelGroupSents := for $grinstance in $parallelGroups
                            let $grparallelSentIDs := $grinstance//bcrd:sentence/@id
							let $parallelSents := for $instance in $grparallelSentIDs
									(: return doc($instFullDBPath//bcrd:sentence/@s_id[contains(., $instance)]//bcrd:sentence :)
									(: let $instclusterID := concat($uniCatID, '-', $instance/ancestor::bcrd:div[@type = "Cluster"]/@id) :)
									let $instclusterID := string($instance/ancestor::bcrd:div[@type = "Cluster"]/@id)
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
									let $instSentences := 
										if (contains($tempinstDB, 'SKT')) then
											string(concat(' ', string-join(doc($instFullDBPath)/descendant::bcrd:sentence/@s_id[contains(., $instance)]/ancestor::bcrd:sentence/bcrd:phrase, " | "), " || "))
										else if (string-length($tempinstDB) > 2) then
											string(concat(' ', string-join(doc($instFullDBPath)/descendant::bcrd:sentence/@s_id[contains(., $instance)]/ancestor::bcrd:sentence/bcrd:phrase, " "), " "))
										else
											string(concat(' ', string-join(doc($instFullDBPath)/descendant::bcrd:sentence/@s_id[contains(., $instance)]/ancestor::bcrd:sentence/bcrd:phrase, " / "), " // "))
									let $instPhrases := string(concat(' ', string-join($instSentences, " ++ "), " zz"))
									let $resultstring := string(concat(' ', string-join($instPhrases, " / "), " //"))
									return $instSentences
                            let $grinstSentences := string-join($parallelSents)
                            return $grinstSentences
                    let $parallelGroupBibs := for $grinstance in $parallelGroups
                            let $grparallelSentIDs := $grinstance//bcrd:sentence/@id
							let $parallelBibls := for $instance at $pbpos in $grparallelSentIDs
									let $instDocID := substring-before($instance, '-SID')
									let $tibID := functx:substring-after-last($instDocID, "-")
									let $tempinstDB := replace($instDocID, "[0-9\-]", "")
									let $instDB :=
										if (string-length($tempinstDB) > 2) then
											$tempinstDB
										else
											"BOD"
									let $printabletibID :=
										if (string-length($tempinstDB) < 3) then
											concat(string($tibID), ", ")
										else
											""
									let $foundDocID := substring-before($foundSentID, '-SID')
									let $foundinstDB := replace($foundDocID, "[0-9\-]", "")
									let $instDocName := concat($instDocID, ".xml")
									let $instFullDBPath := concat("/db/tibetan/", $instDB, "/", $instDocName)
									let $snameB := string(doc($instFullDBPath)/bcrd:bcrdCorpus/bcrd:text/bcrd:sentence[@s_id = $instance]/@s_name)
									let $foundpageID := 
										if (string-length($printabletibID) <= 0) then
											""
										else
											concat('Citation: ', string($printabletibID))
									let $firstfoundpageID := 
												if (empty(doc($instFullDBPath)/bcrd:bcrdCorpus/bcrd:text/bcrd:sentence[@s_id = $instance]/bcrd:phrase/bcrd:page/@p_id)) then
													string((doc($instFullDBPath)/bcrd:bcrdCorpus/bcrd:text/bcrd:sentence[@s_id = $instance]/preceding::bcrd:sentence/bcrd:phrase/bcrd:page/@p_id)[last()])
												else if (one-or-more(doc($instFullDBPath)/bcrd:bcrdCorpus/bcrd:text/bcrd:sentence[@s_id = $instance]/bcrd:phrase/bcrd:page/@p_id)) then
													string((doc($instFullDBPath)/bcrd:bcrdCorpus/bcrd:text/bcrd:sentence[@s_id = $instance]/bcrd:phrase/bcrd:page/@p_id)[1])
												else
													""
									let $lastfoundpageID := 
												if (empty(doc($instFullDBPath)/bcrd:bcrdCorpus/bcrd:text/bcrd:sentence[@s_id = $instance]/bcrd:phrase/bcrd:page/@p_id)) then
													string((doc($instFullDBPath)/bcrd:bcrdCorpus/bcrd:text/bcrd:sentence[@s_id = $instance]/preceding::bcrd:sentence/bcrd:phrase/bcrd:page/@p_id)[last()])
												else if (one-or-more(doc($instFullDBPath)/bcrd:bcrdCorpus/bcrd:text/bcrd:sentence[@s_id = $instance]/bcrd:phrase/bcrd:page/@p_id)) then
													string((doc($instFullDBPath)/bcrd:bcrdCorpus/bcrd:text/bcrd:sentence[@s_id = $instance]/bcrd:phrase/bcrd:page/@p_id)[last()])
												else
													""
									let $sname := 
										if (string-length($snameB) <= 0) then
											""
										else
											concat('Citation: ', string($snameB))
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
									let $bibunparsedinfo := 
										if (empty(doc($instFullDBPath)/bcrd:bcrdCorpus/bcrd:head/bcrd:sourceDesc/bcrd:bibl/bcrd:pubInfo)) then
											""
										else if (one-or-more(doc($instFullDBPath)/bcrd:bcrdCorpus/bcrd:head/bcrd:sourceDesc/bcrd:bibl/bcrd:pubInfo)) then
											string-join((doc($instFullDBPath)/bcrd:bcrdCorpus/bcrd:head/bcrd:sourceDesc/bcrd:bibl//bcrd:pubInfo), '; ')
										else
											""
									let $bibjourn := 
										if (empty(doc($instFullDBPath)/bcrd:bcrdCorpus/bcrd:head/bcrd:sourceDesc/bcrd:bibl/bcrd:journaltitle)) then
											""
										else if (one-or-more(doc($instFullDBPath)/bcrd:bcrdCorpus/bcrd:head/bcrd:sourceDesc/bcrd:bibl/bcrd:journaltitle)) then
											concat('in ', (doc($instFullDBPath)/bcrd:bcrdCorpus/bcrd:head/bcrd:sourceDesc/bcrd:bibl//bcrd:journaltitle), '&#xA;')
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
										else if (($bibunparsedinfo != '') and ($bibvol = '') and ($bibjourn = '') and ($bibdate != '')) then
											concat('Pub: ', $bibunparsedinfo, ' (', $bibdate, ')&#xA;')
										else if ($bibdate != '') then
											concat('Pub: (', $bibdate, ')&#xA;')
										else
											""
									(: let $bibtitle := concat(string($bibauthor), 'Title: ', string(doc($instFullDBPath)/bcrd:bcrdCorpus/bcrd:head/bcrd:sourceDesc/bcrd:bibl/bcrd:title/node()), '&#xA;', string($bibjourn), string($bibvol), string($bibinfo), string($sname), ' ', string($foundpageID)) :)
								    let $bibtitle := 
									    if (($pbpos = 1) and ($pbpos = count($grparallelSentIDs)) and ($firstfoundpageID != $lastfoundpageID)) then
									        concat(string($bibauthor), 'Title: ', string(doc($instFullDBPath)/bcrd:bcrdCorpus/bcrd:head/bcrd:sourceDesc/bcrd:bibl/bcrd:title/node()), '&#xA;', string($bibjourn), string($bibvol), string($bibinfo), string($sname), ' ', string($foundpageID), ' ', string($firstfoundpageID), '-', string($lastfoundpageID)) 
									    else if (($pbpos = 1) and ($pbpos = count($grparallelSentIDs)) and ($firstfoundpageID = $lastfoundpageID)) then
									        concat(string($bibauthor), 'Title: ', string(doc($instFullDBPath)/bcrd:bcrdCorpus/bcrd:head/bcrd:sourceDesc/bcrd:bibl/bcrd:title/node()), '&#xA;', string($bibjourn), string($bibvol), string($bibinfo), string($sname), ' ', string($foundpageID), ' ', string($firstfoundpageID)) 
									    else if (($pbpos = 1) and ($pbpos < count($grparallelSentIDs))) then
									        concat(string($bibauthor), 'Title: ', string(doc($instFullDBPath)/bcrd:bcrdCorpus/bcrd:head/bcrd:sourceDesc/bcrd:bibl/bcrd:title/node()), '&#xA;', string($bibjourn), string($bibvol), string($bibinfo), string($sname), ' ', string($foundpageID), ' ', string($firstfoundpageID)) 
									    else if (($pbpos > 1) and ($pbpos = count($grparallelSentIDs)) and ($firstfoundpageID != $lastfoundpageID)) then
									        concat('-', string($lastfoundpageID))
									    else
									        ""
									return $bibtitle
                            let $grparallelBibls := string-join($parallelBibls)
                            return $grparallelBibls
            where (($pos < 200) or (1) or (($pos > 1) and (not ( string(root($searchresults[$pos])/bcrd:bcrdCorpus/bcrd:head/bcrd:unifiedCatalogID) = string(root($searchresults[$pos - 1])/bcrd:bcrdCorpus/bcrd:head/bcrd:unifiedCatalogID) ) or (0) )))
            return
                <p>
                    {
                        (: enumerate results :)
                        (: Set Division Names :)
                        if (($pos < 2) and (substring(string(root($fourthsortsearchresults[$pos])/bcrd:bcrdCorpus/bcrd:head/bcrd:unifiedCatalogID/text()), 1, 1) = '1')) then
                            <p><h4>Your query ("{$searchphrase}") returned {$resultcount} instances:</h4><h1><b>Kangyur Entries:</b></h1></p>
                        else if (($pos < 2) and (substring(string(root($fourthsortsearchresults[$pos])/bcrd:bcrdCorpus/bcrd:head/bcrd:unifiedCatalogID/text()), 1, 1) = '2')) then
                            <p><h4>Your query ("{$searchphrase}") returned {$resultcount} instances:</h4><h1><b>Tengyur Entries:</b></h1></p>
                        else  if (($pos < 2) and (substring(string(root($fourthsortsearchresults[$pos])/bcrd:bcrdCorpus/bcrd:head/bcrd:unifiedCatalogID/text()), 1, 1) = '3')) then
                            <p><h4>Your query ("{$searchphrase}") returned {$resultcount} instances:</h4><h1><b>Post-canonical Entries:</b></h1></p>
                        else  if (($pos < 2) and (substring(string(root($fourthsortsearchresults[$pos])/bcrd:bcrdCorpus/bcrd:head/bcrd:unifiedCatalogID/text()), 1, 1) = '9')) then
                            <p><h4>Your query ("{$searchphrase}") returned {$resultcount} instances:</h4><h1><b>Wisdom Entries:</b></h1></p>
                        else if ($pos > 1) then
                            if ((substring(string(root($fourthsortsearchresults[$pos])/bcrd:bcrdCorpus/bcrd:head/bcrd:unifiedCatalogID/text()), 1, 1) != substring(string(root($fourthsortsearchresults[$pos - 1])/bcrd:bcrdCorpus/bcrd:head/bcrd:unifiedCatalogID/text()), 1, 1) ) and (substring(string(root($fourthsortsearchresults[$pos])/bcrd:bcrdCorpus/bcrd:head/bcrd:unifiedCatalogID/text()), 1, 1) = '2')) then
                                <h1><b>Tengyur Entries:</b></h1>
                            else if ((substring(string(root($fourthsortsearchresults[$pos])/bcrd:bcrdCorpus/bcrd:head/bcrd:unifiedCatalogID/text()), 1, 1) != substring(string(root($fourthsortsearchresults[$pos - 1])/bcrd:bcrdCorpus/bcrd:head/bcrd:unifiedCatalogID/text()), 1, 1) ) and (substring(string(root($fourthsortsearchresults[$pos])/bcrd:bcrdCorpus/bcrd:head/bcrd:unifiedCatalogID/text()), 1, 1) = '3')) then
                                <h1><b>Post-canonical Entries:</b></h1>
                            else if ((substring(string(root($fourthsortsearchresults[$pos])/bcrd:bcrdCorpus/bcrd:head/bcrd:unifiedCatalogID/text()), 1, 1) != substring(string(root($fourthsortsearchresults[$pos - 1])/bcrd:bcrdCorpus/bcrd:head/bcrd:unifiedCatalogID/text()), 1, 1) ) and (substring(string(root($fourthsortsearchresults[$pos])/bcrd:bcrdCorpus/bcrd:head/bcrd:unifiedCatalogID/text()), 1, 1) = '9')) then
                                <h1><b>Wisdom Entries:</b></h1>
                            else
                                <p></p>
                        else <p></p>
                    }
                    {
                        (: Set Section Names :)
                        if ($pos < 2) then
                            <h2><b><i><span style='margin-right:1.25em; display:inline-block;'/>{ map:get($sectionnames, substring(string(root($fourthsortsearchresults[$pos])/bcrd:bcrdCorpus/bcrd:head/bcrd:unifiedCatalogID/text()), 1, 4) ) } Entries:</i></b></h2>
                        else if ($pos > 1) then
                            if (substring(string(root($fourthsortsearchresults[$pos])/bcrd:bcrdCorpus/bcrd:head/bcrd:unifiedCatalogID/text()), 1, 4) != substring(string(root($fourthsortsearchresults[$pos - 1])/bcrd:bcrdCorpus/bcrd:head/bcrd:unifiedCatalogID/text()), 1, 4) ) then
                                <h2><b><i><span style='margin-right:1.25em; display:inline-block;'/>{ map:get($sectionnames, substring(string(root($fourthsortsearchresults[$pos])/bcrd:bcrdCorpus/bcrd:head/bcrd:unifiedCatalogID/text()), 1, 4) ) } Entries:</i></b></h2>
                            else
                                <p></p>
                        else <p></p>
                    }
                    <ul style="list-style-type:none;">
                    <li>
                        <!-- p>{$pos} - {string(concat('/db/tibetan/PARID/', string(root($line)/bcrd:bcrdCorpus/bcrd:head/bcrd:unifiedCatalogID), '-PARID.xml'))} - {string($clusterID)} in {index-of($fourthsortsearchresults, $line)}, from: {$uniCatID} = {string(root($fourthsortsearchresults[$pos])/bcrd:bcrdCorpus/bcrd:head/bcrd:unifiedCatalogID/text())}, <b>{string(root($line)/bcrd:bcrdCorpus/bcrd:head/bcrd:sourceDesc/bcrd:bibl/bcrd:author)} // {string(root($line)/bcrd:bcrdCorpus/bcrd:head/bcrd:title)}</b>, {string($line/@phr_id)}</p -->
                    {
                        (: check for author and multiple occurences in same text :)
                        if (($pos < 2) and (string-length(string(root($line)/bcrd:bcrdCorpus/bcrd:head/bcrd:author)) > 0)) then
                            <h3><b>{string(root($line)/bcrd:bcrdCorpus/bcrd:head/bcrd:author)} // {string(root($line)/bcrd:bcrdCorpus/bcrd:head/bcrd:title)}</b></h3>
                        else if (($pos < 2) and (string-length(string(root($line)/bcrd:bcrdCorpus/bcrd:head/bcrd:author)) < 1)) then
                            <h3><b>{string(root($line)/bcrd:bcrdCorpus/bcrd:head/bcrd:title)}</b></h3>
                        else if ((string(root($fourthsortsearchresults[$pos])/bcrd:bcrdCorpus/bcrd:head/bcrd:unifiedCatalogID/text()) ne string(root($fourthsortsearchresults[$pos - 1])/bcrd:bcrdCorpus/bcrd:head/bcrd:unifiedCatalogID/text())) and (string-length(string(root($line)/bcrd:bcrdCorpus/bcrd:head/bcrd:author)) > 0)) then
                            <h3><b>{string(root($line)/bcrd:bcrdCorpus/bcrd:head/bcrd:author)} // {string(root($line)/bcrd:bcrdCorpus/bcrd:head/bcrd:title)}</b></h3>
                        else if ((string(root($fourthsortsearchresults[$pos])/bcrd:bcrdCorpus/bcrd:head/bcrd:unifiedCatalogID/text()) ne string(root($fourthsortsearchresults[$pos - 1])/bcrd:bcrdCorpus/bcrd:head/bcrd:unifiedCatalogID/text())) and (string-length(string(root($line)/bcrd:bcrdCorpus/bcrd:head/bcrd:author)) < 1)) then
                            <h3><b>{string(root($line)/bcrd:bcrdCorpus/bcrd:head/bcrd:title)}</b></h3>
                        else
                            <span></span>
                    }
                    <i><b>{string($line)}</b></i><!-- in {$foundSentID} -->:<br/>
                    <i>{concat(string-join(($line/ancestor::bcrd:sentence//bcrd:phrase), " / "), " //")}</i>
                    <ul>in parallel passages:
                    <ul>{for $x at $position in $parallelGroupSents 
                        return 
                                <li>
                                    <img src='../images/info2.jpg' width='15' height='15' title='{$parallelGroupBibs[$position]}'/> <!--{$position} = {position()}: --> {$x}
                                </li>
                    }
                </ul></ul></li></ul>
            </p>}
        <br/>
        <!-- p>For a total of {$resultcount} hits in </p -->
    </body>
</html>
