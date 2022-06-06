<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0" xpath-default-namespace="http://www.bcrdb.org/ns/1.0">
    <xsl:include href="/db/tibetan/utils/date.xsl"/>
    
    <!-- TEST xsl:variable name="lang1" select="'SKT'"/ -->
    <xsl:variable name="lang1" select="//witness[@col = '1']/@lang"/>
    <xsl:variable name="lang2" select="//witness[@col = '2']/@lang"/>
    <xsl:variable name="lang3" select="//witness[@col = '3']/@lang"/>
    <xsl:variable name="lang4" select="//witness[@col = '4']/@lang"/>
    <xsl:variable name="lang5" select="//witness[@col = '5']/@lang"/>
    <xsl:variable name="lang6" select="//witness[@col = '6']/@lang"/>
    <xsl:variable name="lang7" select="//witness[@col = '7']/@lang"/>
    <xsl:variable name="lang8" select="//witness[@col = '8']/@lang"/>
    <xsl:variable name="docID1" select="//witness[@col = '1']/@id"/>
    <xsl:variable name="docID2" select="//witness[@col = '2']/@id"/>
    <xsl:variable name="docID3" select="//witness[@col = '3']/@id"/>
    <xsl:variable name="docID4" select="//witness[@col = '4']/@id"/>
    <xsl:variable name="docID5" select="//witness[@col = '5']/@id"/>
    <xsl:variable name="docID6" select="//witness[@col = '6']/@id"/>
    <xsl:variable name="docID7" select="//witness[@col = '7']/@id"/>
    <xsl:variable name="docID8" select="//witness[@col = '8']/@id"/>
    <xsl:variable name="numWitness" select="count(//witness)"/>
    <xsl:variable name="cellwidth" select="100 div $numWitness"/>
    <xsl:variable name="tablewidth" select="250 * $numWitness"/>
    <xsl:template match="/">
        <meta HTTP-EQUIV="Content-Type" content="text/html; charset=UTF-8"/>
        <html>
            <head>
                <meta HTTP-EQUIV="Content-Type" content="text/html; charset=UTF-8"/>
                <title>Parallel Text Table with XSLT</title>
            </head>
            <body>
                <h1>
                    <center>Buddhist Canons Research Database</center>
                </h1>
                <h3>
                    <center>ver. 3.0 (beta 16)</center>
                </h3>
                <h2>
                    <center>Parallel Text for</center>
                </h2>
                <!-- table width="{$tablewidth}" -->
                <table width="1650">
                    <xsl:apply-templates/>
                </table>
                <p>Processed: <xsl:value-of select="$date"/>
                </p>
            </body>
        </html>
    </xsl:template>
    <xsl:template match="//unifiedCatalogID">
        <h2>
            <center>
                Unified Text ID # <xsl:value-of select="."/>
            </center>
        </h2>
    </xsl:template>
    <xsl:template match="//witness">
        <xsl:choose>
            <xsl:when test="@col &gt; '5'">
                <xsl:variable name="thisID" select="replace(@id, '([0-9]+\-)', '')"/>
                <th width="{$cellwidth}%">
                    Document #<xsl:value-of select="@col"/> (<xsl:value-of select="@lang"/>): <xsl:value-of select="$thisID"/>
                </th>
            </xsl:when>
            <xsl:when test="@col = '1'">
                <!-- xsl:variable name="thisID" select="replace(@id, '([0-9]+\-)', '')"/ -->
                <xsl:variable name="getdoc" select="concat('/db/tibetan/', $lang1, '/', $docID1, '.xml')"/>
                <xsl:variable name="getlang" select="$lang1"/>
                <xsl:variable name="getid" select="@id[contains(., $docID1)]"/>
                <xsl:variable name="author" select="string-join(doc($getdoc)//sourceDesc/bibl/author/node(), '; ')"/>
                <xsl:variable name="title" select="doc($getdoc)//sourceDesc/bibl/title"/>
                <xsl:variable name="volumetitle" select="doc($getdoc)//sourceDesc/bibl/volumetitle"/>
                <xsl:variable name="journaltitle" select="doc($getdoc)//sourceDesc/bibl/journaltitle"/>
                <xsl:variable name="title">
                    <xsl:choose>
                        <xsl:when test="doc($getdoc)//sourceDesc/bibl/volumetitle/node() != ''">
                            <xsl:value-of select="concat(doc($getdoc)//sourceDesc/bibl/title/node(), ' in ', doc($getdoc)//sourceDesc/bibl/volumetitle/node())"/>
                        </xsl:when>
                        <xsl:when test="doc($getdoc)//sourceDesc/bibl/journaltitle/node() != ''">
                            <xsl:value-of select="concat(doc($getdoc)//sourceDesc/bibl/title/node(), ' in ', doc($getdoc)//sourceDesc/bibl/journaltitle/node())"/>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:value-of select="doc($getdoc)//sourceDesc/bibl/title/node()"/>
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:variable>
                <!-- xsl:variable name="pplace" select="doc($getdoc)//sourceDesc/bibl/pubPlace"/ -->
                <xsl:variable name="pplace">
                    <xsl:choose>
                        <xsl:when test="doc($getdoc)//sourceDesc/bibl/pubPlace/node() != ''">
                            <xsl:value-of select="doc($getdoc)//sourceDesc/bibl/pubPlace/node()"/>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:value-of select="''"/>
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:variable>
                <!-- xsl:variable name="ppub" select="doc($getdoc)//sourceDesc/bibl/publisher"/ -->
                <xsl:variable name="ppub">
                    <xsl:choose>
                        <xsl:when test="doc($getdoc)//sourceDesc/bibl/publisher/node() != ''">
                            <xsl:value-of select="doc($getdoc)//sourceDesc/bibl/publisher/node()"/>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:value-of select="''"/>
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:variable>
                <xsl:variable name="unparsedpubinfo">
                    <xsl:choose>
                        <xsl:when test="doc($getdoc)//sourceDesc/bibl/pubInfo/node() != ''">
                            <xsl:value-of select="doc($getdoc)//sourceDesc/bibl/pubInfo/node()"/>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:value-of select="''"/>
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:variable>
                <xsl:variable name="pubinfo">
                    <xsl:choose>
                        <xsl:when test="($pplace != '') and ($ppub != '')">
                            <xsl:value-of select="concat($pplace, ': ', $ppub, ' ')"/>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:value-of select="concat($unparsedpubinfo, ' ')"/>
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:variable>
                <xsl:variable name="pdate" select="doc($getdoc)//sourceDesc/bibl/date"/>
                <xsl:variable name="ppage">
                    <xsl:choose>
                        <xsl:when test="doc($getdoc)//sourceDesc/bibl/biblScope/node() !=''">
                            <xsl:value-of select="string-join(doc($getdoc)//sourceDesc/bibl/biblScope/node(), ', ')"/>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:value-of select="'-----'"/>
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:variable>
                <th width="{$cellwidth}%">
                    Document #<xsl:value-of select="@col"/> (<xsl:value-of select="@lang"/>) <!-- xsl:value-of select="$docID1"/ -->
                    <!-- img src="/db/tibetan/images/info2.jpg" width="15" height="15" title="Author: {$author}
						Title: {$title}
						Pub: {$pubinfo}({$pdate})
						Pagin: {$ppage}"/ -->
                    <img width="15" height="15" title="Author: {$author}&#xA;Title: {$title}&#xA;Pub: {$pubinfo}({$pdate})&#xA;Pagin: {$ppage}">
                        <xsl:attribute name="src">../images/info2.jpg</xsl:attribute>
                    </img>
                </th>
            </xsl:when>
            <xsl:when test="@col = '2'">
                <!-- xsl:variable name="thisID" select="replace(@id, '([0-9]+\-)', '')"/ -->
                <xsl:variable name="getdoc" select="concat('/db/tibetan/', $lang2, '/', $docID2, '.xml')"/>
                <xsl:variable name="getlang" select="$lang1"/>
                <xsl:variable name="getid" select="@id[contains(., $docID2)]"/>
                <xsl:variable name="author" select="string-join(doc($getdoc)//sourceDesc/bibl/author/node(), '; ')"/>
                <!-- xsl:variable name="title" select="doc($getdoc)//sourceDesc/bibl/title"/>
                <xsl:variable name="volumetitle" select="doc($getdoc)//sourceDesc/bibl/volumetitle"/>
                <xsl:variable name="journaltitle" select="doc($getdoc)//sourceDesc/bibl/journaltitle"/ -->
                <xsl:variable name="title">
                    <xsl:choose>
                        <xsl:when test="doc($getdoc)//sourceDesc/bibl/volumetitle/node() != ''">
                            <xsl:value-of select="concat(doc($getdoc)//sourceDesc/bibl/title/node(), ' in ', doc($getdoc)//sourceDesc/bibl/volumetitle/node())"/>
                        </xsl:when>
                        <xsl:when test="doc($getdoc)//sourceDesc/bibl/journaltitle/node() != ''">
                            <xsl:value-of select="concat(doc($getdoc)//sourceDesc/bibl/title/node(), ' in ', doc($getdoc)//sourceDesc/bibl/journaltitle/node())"/>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:value-of select="doc($getdoc)//sourceDesc/bibl/title/node()"/>
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:variable>
                <!-- xsl:variable name="pplace" select="doc($getdoc)//sourceDesc/bibl/pubPlace"/ -->
                <xsl:variable name="pplace">
                    <xsl:choose>
                        <xsl:when test="doc($getdoc)//sourceDesc/bibl/pubPlace/node() != ''">
                            <xsl:value-of select="doc($getdoc)//sourceDesc/bibl/pubPlace/node()"/>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:value-of select="''"/>
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:variable>
                <!-- xsl:variable name="ppub" select="doc($getdoc)//sourceDesc/bibl/publisher"/ -->
                <xsl:variable name="ppub">
                    <xsl:choose>
                        <xsl:when test="doc($getdoc)//sourceDesc/bibl/publisher/node() != ''">
                            <xsl:value-of select="doc($getdoc)//sourceDesc/bibl/publisher/node()"/>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:value-of select="''"/>
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:variable>
                <xsl:variable name="unparsedpubinfo">
                    <xsl:choose>
                        <xsl:when test="doc($getdoc)//sourceDesc/bibl/pubInfo/node() != ''">
                            <xsl:value-of select="doc($getdoc)//sourceDesc/bibl/pubInfo/node()"/>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:value-of select="''"/>
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:variable>
                <xsl:variable name="pubinfo">
                    <xsl:choose>
                        <xsl:when test="($pplace != '') and ($ppub != '')">
                            <xsl:value-of select="concat($pplace, ': ', $ppub, ' ')"/>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:value-of select="concat($unparsedpubinfo, ' ')"/>
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:variable>
                <xsl:variable name="pdate" select="doc($getdoc)//sourceDesc/bibl/date"/>
                <xsl:variable name="ppage">
                    <xsl:choose>
                        <xsl:when test="doc($getdoc)//sourceDesc/bibl/biblScope/node() !=''">
                            <xsl:value-of select="string-join(doc($getdoc)//sourceDesc/bibl/biblScope/node(), ', ')"/>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:value-of select="'-----'"/>
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:variable>
                <th width="{$cellwidth}%">
                    Document #<xsl:value-of select="@col"/> (<xsl:value-of select="@lang"/>) <!-- xsl:value-of select="$docID1"/ -->
                    <!-- img source="/images/info2.png" width="15" height="15" title="Author: {$author}
						Title: {$title}
						Pub: {$pplace}: {$ppub} ({$pdate})
						Pagin: {$ppage}" alt="info-gif"/ -->
                    <img width="15" height="15" title="Author: {$author}&#xA;Title: {$title}&#xA;Pub: {$pubinfo}({$pdate})&#xA;Pagin: {$ppage}">
                        <xsl:attribute name="src">../images/info2.jpg</xsl:attribute>
                    </img>
                </th>
            </xsl:when>
            <xsl:when test="@col = '3'">
                <!-- xsl:variable name="thisID" select="replace(@id, '([0-9]+\-)', '')"/ -->
                <xsl:variable name="getdoc" select="concat('/db/tibetan/', $lang3, '/', $docID3, '.xml')"/>
                <xsl:variable name="getlang" select="$lang1"/>
                <xsl:variable name="getid" select="@id[contains(., $docID3)]"/>
                <xsl:variable name="author" select="string-join(doc($getdoc)//sourceDesc/bibl/author/node(), '; ')"/>
                <!-- xsl:variable name="title" select="doc($getdoc)//sourceDesc/bibl/title"/>
                <xsl:variable name="volumetitle" select="doc($getdoc)//sourceDesc/bibl/volumetitle"/>
                <xsl:variable name="journaltitle" select="doc($getdoc)//sourceDesc/bibl/journaltitle"/ -->
                <xsl:variable name="title">
                    <xsl:choose>
                        <xsl:when test="doc($getdoc)//sourceDesc/bibl/volumetitle/node() != ''">
                            <xsl:value-of select="concat(doc($getdoc)//sourceDesc/bibl/title/node(), ' in ', doc($getdoc)//sourceDesc/bibl/volumetitle/node())"/>
                        </xsl:when>
                        <xsl:when test="doc($getdoc)//sourceDesc/bibl/journaltitle/node() != ''">
                            <xsl:value-of select="concat(doc($getdoc)//sourceDesc/bibl/title/node(), ' in ', doc($getdoc)//sourceDesc/bibl/journaltitle/node())"/>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:value-of select="doc($getdoc)//sourceDesc/bibl/title/node()"/>
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:variable>
                <!-- xsl:variable name="pplace" select="doc($getdoc)//sourceDesc/bibl/pubPlace"/ -->
                <xsl:variable name="pplace">
                    <xsl:choose>
                        <xsl:when test="doc($getdoc)//sourceDesc/bibl/pubPlace/node() != ''">
                            <xsl:value-of select="doc($getdoc)//sourceDesc/bibl/pubPlace/node()"/>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:value-of select="''"/>
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:variable>
                <!-- xsl:variable name="ppub" select="doc($getdoc)//sourceDesc/bibl/publisher"/ -->
                <xsl:variable name="ppub">
                    <xsl:choose>
                        <xsl:when test="doc($getdoc)//sourceDesc/bibl/publisher/node() != ''">
                            <xsl:value-of select="doc($getdoc)//sourceDesc/bibl/publisher/node()"/>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:value-of select="''"/>
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:variable>
                <xsl:variable name="unparsedpubinfo">
                    <xsl:choose>
                        <xsl:when test="doc($getdoc)//sourceDesc/bibl/pubInfo/node() != ''">
                            <xsl:value-of select="doc($getdoc)//sourceDesc/bibl/pubInfo/node()"/>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:value-of select="''"/>
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:variable>
                <xsl:variable name="pubinfo">
                    <xsl:choose>
                        <xsl:when test="($pplace != '') and ($ppub != '')">
                            <xsl:value-of select="concat($pplace, ': ', $ppub, ' ')"/>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:value-of select="concat($unparsedpubinfo, ' ')"/>
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:variable>
                <xsl:variable name="pdate" select="doc($getdoc)//sourceDesc/bibl/date"/>
                <xsl:variable name="ppage">
                    <xsl:choose>
                        <xsl:when test="doc($getdoc)//sourceDesc/bibl/biblScope/node() !=''">
                            <xsl:value-of select="string-join(doc($getdoc)//sourceDesc/bibl/biblScope/node(), ', ')"/>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:value-of select="'-----'"/>
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:variable>
                <th width="{$cellwidth}%">
                    Document #<xsl:value-of select="@col"/> (<xsl:value-of select="@lang"/>) <!-- xsl:value-of select="$docID1"/ -->
                    <!-- img source="/images/info2.png" width="15" height="15" title="Author: {$author}
						Title: {$title}
						Pub: {$pplace}: {$ppub} ({$pdate})
						Pagin: {$ppage}" alt="info-gif"/ -->
                    <img width="15" height="15" title="Author: {$author}&#xA;Title: {$title}&#xA;Pub: {$pubinfo}({$pdate})&#xA;Pagin: {$ppage}">
                        <xsl:attribute name="src">../images/info2.jpg</xsl:attribute>
                    </img>
                </th>
            </xsl:when>
            <xsl:when test="@col = '4'">
                <!-- xsl:variable name="thisID" select="replace(@id, '([0-9]+\-)', '')"/ -->
                <xsl:variable name="getdoc" select="concat('/db/tibetan/', $lang4, '/', $docID4, '.xml')"/>
                <xsl:variable name="getlang" select="$lang1"/>
                <xsl:variable name="getid" select="@id[contains(., $docID4)]"/>
                <xsl:variable name="author" select="string-join(doc($getdoc)//sourceDesc/bibl/author/node(), '; ')"/>
                <!-- xsl:variable name="title" select="doc($getdoc)//sourceDesc/bibl/title"/>
                <xsl:variable name="volumetitle" select="doc($getdoc)//sourceDesc/bibl/volumetitle"/>
                <xsl:variable name="journaltitle" select="doc($getdoc)//sourceDesc/bibl/journaltitle"/ -->
                <xsl:variable name="title">
                    <xsl:choose>
                        <xsl:when test="doc($getdoc)//sourceDesc/bibl/volumetitle/node() != ''">
                            <xsl:value-of select="concat(doc($getdoc)//sourceDesc/bibl/title/node(), ' in ', doc($getdoc)//sourceDesc/bibl/volumetitle/node())"/>
                        </xsl:when>
                        <xsl:when test="doc($getdoc)//sourceDesc/bibl/journaltitle/node() != ''">
                            <xsl:value-of select="concat(doc($getdoc)//sourceDesc/bibl/title/node(), ' in ', doc($getdoc)//sourceDesc/bibl/journaltitle/node())"/>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:value-of select="doc($getdoc)//sourceDesc/bibl/title/node()"/>
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:variable>
                <!-- xsl:variable name="pplace" select="doc($getdoc)//sourceDesc/bibl/pubPlace"/ -->
                <xsl:variable name="pplace">
                    <xsl:choose>
                        <xsl:when test="doc($getdoc)//sourceDesc/bibl/pubPlace/node() != ''">
                            <xsl:value-of select="doc($getdoc)//sourceDesc/bibl/pubPlace/node()"/>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:value-of select="''"/>
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:variable>
                <!-- xsl:variable name="ppub" select="doc($getdoc)//sourceDesc/bibl/publisher"/ -->
                <xsl:variable name="ppub">
                    <xsl:choose>
                        <xsl:when test="doc($getdoc)//sourceDesc/bibl/publisher/node() != ''">
                            <xsl:value-of select="doc($getdoc)//sourceDesc/bibl/publisher/node()"/>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:value-of select="''"/>
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:variable>
                <xsl:variable name="unparsedpubinfo">
                    <xsl:choose>
                        <xsl:when test="doc($getdoc)//sourceDesc/bibl/pubInfo/node() != ''">
                            <xsl:value-of select="doc($getdoc)//sourceDesc/bibl/pubInfo/node()"/>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:value-of select="''"/>
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:variable>
                <xsl:variable name="pubinfo">
                    <xsl:choose>
                        <xsl:when test="($pplace != '') and ($ppub != '')">
                            <xsl:value-of select="concat($pplace, ': ', $ppub, ' ')"/>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:value-of select="concat($unparsedpubinfo, ' ')"/>
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:variable>
                <xsl:variable name="pdate" select="doc($getdoc)//sourceDesc/bibl/date"/>
                <xsl:variable name="ppage">
                    <xsl:choose>
                        <xsl:when test="doc($getdoc)//sourceDesc/bibl/biblScope/node() !=''">
                            <xsl:value-of select="string-join(doc($getdoc)//sourceDesc/bibl/biblScope/node(), ', ')"/>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:value-of select="'-----'"/>
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:variable>
                <th width="{$cellwidth}%">
                    Document #<xsl:value-of select="@col"/> (<xsl:value-of select="@lang"/>) <!-- xsl:value-of select="$docID1"/ -->
                    <!-- img source="/images/info2.png" width="15" height="15" title="Author: {$author}
						Title: {$title}
						Pub: {$pplace}: {$ppub} ({$pdate})
						Pagin: {$ppage}" alt="info-gif"/ -->
                    <img width="15" height="15" title="Author: {$author}&#xA;Title: {$title}&#xA;Pub: {$pubinfo}({$pdate})&#xA;Pagin: {$ppage}">
                        <xsl:attribute name="src">../images/info2.jpg</xsl:attribute>
                    </img>
                </th>
            </xsl:when>
            <xsl:when test="@col = '5'">
                <!-- xsl:variable name="thisID" select="replace(@id, '([0-9]+\-)', '')"/ -->
                <xsl:variable name="getdoc" select="concat('/db/tibetan/', $lang5, '/', $docID5, '.xml')"/>
                <xsl:variable name="getlang" select="$lang1"/>
                <xsl:variable name="getid" select="@id[contains(., $docID5)]"/>
                <xsl:variable name="author" select="string-join(doc($getdoc)//sourceDesc/bibl/author/node(), '; ')"/>
                <!-- xsl:variable name="title" select="doc($getdoc)//sourceDesc/bibl/title"/>
                <xsl:variable name="volumetitle" select="doc($getdoc)//sourceDesc/bibl/volumetitle"/>
                <xsl:variable name="journaltitle" select="doc($getdoc)//sourceDesc/bibl/journaltitle"/ -->
                <xsl:variable name="title">
                    <xsl:choose>
                        <xsl:when test="doc($getdoc)//sourceDesc/bibl/volumetitle/node() != ''">
                            <xsl:value-of select="concat(doc($getdoc)//sourceDesc/bibl/title/node(), ' in ', doc($getdoc)//sourceDesc/bibl/volumetitle/node())"/>
                        </xsl:when>
                        <xsl:when test="doc($getdoc)//sourceDesc/bibl/journaltitle/node() != ''">
                            <xsl:value-of select="concat(doc($getdoc)//sourceDesc/bibl/title/node(), ' in ', doc($getdoc)//sourceDesc/bibl/journaltitle/node())"/>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:value-of select="doc($getdoc)//sourceDesc/bibl/title/node()"/>
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:variable>
                <!-- xsl:variable name="pplace" select="doc($getdoc)//sourceDesc/bibl/pubPlace"/ -->
                <xsl:variable name="pplace">
                    <xsl:choose>
                        <xsl:when test="doc($getdoc)//sourceDesc/bibl/pubPlace/node() != ''">
                            <xsl:value-of select="doc($getdoc)//sourceDesc/bibl/pubPlace/node()"/>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:value-of select="''"/>
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:variable>
                <!-- xsl:variable name="ppub" select="doc($getdoc)//sourceDesc/bibl/publisher"/ -->
                <xsl:variable name="ppub">
                    <xsl:choose>
                        <xsl:when test="doc($getdoc)//sourceDesc/bibl/publisher/node() != ''">
                            <xsl:value-of select="doc($getdoc)//sourceDesc/bibl/publisher/node()"/>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:value-of select="''"/>
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:variable>
                <xsl:variable name="unparsedpubinfo">
                    <xsl:choose>
                        <xsl:when test="doc($getdoc)//sourceDesc/bibl/pubInfo/node() != ''">
                            <xsl:value-of select="doc($getdoc)//sourceDesc/bibl/pubInfo/node()"/>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:value-of select="''"/>
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:variable>
                <xsl:variable name="pubinfo">
                    <xsl:choose>
                        <xsl:when test="($pplace != '') and ($ppub != '')">
                            <xsl:value-of select="concat($pplace, ': ', $ppub, ' ')"/>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:value-of select="concat($unparsedpubinfo, ' ')"/>
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:variable>
                <xsl:variable name="pdate" select="doc($getdoc)//sourceDesc/bibl/date"/>
                <xsl:variable name="ppage">
                    <xsl:choose>
                        <xsl:when test="doc($getdoc)//sourceDesc/bibl/biblScope/node() !=''">
                            <xsl:value-of select="string-join(doc($getdoc)//sourceDesc/bibl/biblScope/node(), ', ')"/>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:value-of select="'-----'"/>
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:variable>
                <th width="{$cellwidth}%">
                    Document #<xsl:value-of select="@col"/> (<xsl:value-of select="@lang"/>) <!-- xsl:value-of select="$docID1"/ -->
                    <!-- img source="/images/info2.png" width="15" height="15" title="Author: {$author}
						Title: {$title}
						Pub: {$pplace}: {$ppub} ({$pdate})
						Pagin: {$ppage}" alt="info-gif"/ -->
                    <img width="15" height="15" title="Author: {$author}&#xA;Title: {$title}&#xA;Pub: {$pubinfo}({$pdate})&#xA;Pagin: {$ppage}">
                        <xsl:attribute name="src">../images/info2.jpg</xsl:attribute>
                    </img>
                </th>
            </xsl:when>
            <xsl:when test="@col = '6'">
                <!-- xsl:variable name="thisID" select="replace(@id, '([0-9]+\-)', '')"/ -->
                <xsl:variable name="getdoc" select="concat('/db/tibetan/', $lang6, '/', $docID6, '.xml')"/>
                <xsl:variable name="getlang" select="$lang1"/>
                <xsl:variable name="getid" select="@id[contains(., $docID6)]"/>
                <xsl:variable name="author" select="string-join(doc($getdoc)//sourceDesc/bibl/author/node(), '; ')"/>
                <!-- xsl:variable name="title" select="doc($getdoc)//sourceDesc/bibl/title"/>
                <xsl:variable name="volumetitle" select="doc($getdoc)//sourceDesc/bibl/volumetitle"/>
                <xsl:variable name="journaltitle" select="doc($getdoc)//sourceDesc/bibl/journaltitle"/ -->
                <xsl:variable name="title">
                    <xsl:choose>
                        <xsl:when test="doc($getdoc)//sourceDesc/bibl/volumetitle/node() != ''">
                            <xsl:value-of select="concat(doc($getdoc)//sourceDesc/bibl/title/node(), ' in ', doc($getdoc)//sourceDesc/bibl/volumetitle/node())"/>
                        </xsl:when>
                        <xsl:when test="doc($getdoc)//sourceDesc/bibl/journaltitle/node() != ''">
                            <xsl:value-of select="concat(doc($getdoc)//sourceDesc/bibl/title/node(), ' in ', doc($getdoc)//sourceDesc/bibl/journaltitle/node())"/>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:value-of select="doc($getdoc)//sourceDesc/bibl/title/node()"/>
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:variable>
                <!-- xsl:variable name="pplace" select="doc($getdoc)//sourceDesc/bibl/pubPlace"/ -->
                <xsl:variable name="pplace">
                    <xsl:choose>
                        <xsl:when test="doc($getdoc)//sourceDesc/bibl/pubPlace/node() != ''">
                            <xsl:value-of select="doc($getdoc)//sourceDesc/bibl/pubPlace/node()"/>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:value-of select="''"/>
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:variable>
                <!-- xsl:variable name="ppub" select="doc($getdoc)//sourceDesc/bibl/publisher"/ -->
                <xsl:variable name="ppub">
                    <xsl:choose>
                        <xsl:when test="doc($getdoc)//sourceDesc/bibl/publisher/node() != ''">
                            <xsl:value-of select="doc($getdoc)//sourceDesc/bibl/publisher/node()"/>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:value-of select="''"/>
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:variable>
                <xsl:variable name="unparsedpubinfo">
                    <xsl:choose>
                        <xsl:when test="doc($getdoc)//sourceDesc/bibl/pubInfo/node() != ''">
                            <xsl:value-of select="doc($getdoc)//sourceDesc/bibl/pubInfo/node()"/>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:value-of select="''"/>
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:variable>
                <xsl:variable name="pubinfo">
                    <xsl:choose>
                        <xsl:when test="($pplace != '') and ($ppub != '')">
                            <xsl:value-of select="concat($pplace, ': ', $ppub, ' ')"/>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:value-of select="concat($unparsedpubinfo, ' ')"/>
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:variable>
                <xsl:variable name="pdate" select="doc($getdoc)//sourceDesc/bibl/date"/>
                <xsl:variable name="ppage">
                    <xsl:choose>
                        <xsl:when test="doc($getdoc)//sourceDesc/bibl/biblScope/node() !=''">
                            <xsl:value-of select="string-join(doc($getdoc)//sourceDesc/bibl/biblScope/node(), ', ')"/>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:value-of select="'-----'"/>
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:variable>
                <th width="{$cellwidth}%">
                    Document #<xsl:value-of select="@col"/> (<xsl:value-of select="@lang"/>) <!-- xsl:value-of select="$docID1"/ -->
                    <!-- img source="/images/info2.png" width="15" height="15" title="Author: {$author}
						Title: {$title}
						Pub: {$pplace}: {$ppub} ({$pdate})
						Pagin: {$ppage}" alt="info-gif"/ -->
                    <img width="15" height="15" title="Author: {$author}&#xA;Title: {$title}&#xA;Pub: {$pubinfo}({$pdate})&#xA;Pagin: {$ppage}">
                        <xsl:attribute name="src">../images/info2.jpg</xsl:attribute>
                    </img>
                </th>
            </xsl:when>
            <xsl:when test="@col = '7'">
                <!-- xsl:variable name="thisID" select="replace(@id, '([0-9]+\-)', '')"/ -->
                <xsl:variable name="getdoc" select="concat('/db/tibetan/', $lang7, '/', $docID7, '.xml')"/>
                <xsl:variable name="getlang" select="$lang1"/>
                <xsl:variable name="getid" select="@id[contains(., $docID7)]"/>
                <xsl:variable name="author" select="string-join(doc($getdoc)//sourceDesc/bibl/author/node(), '; ')"/>
                <!-- xsl:variable name="title" select="doc($getdoc)//sourceDesc/bibl/title"/>
                <xsl:variable name="volumetitle" select="doc($getdoc)//sourceDesc/bibl/volumetitle"/>
                <xsl:variable name="journaltitle" select="doc($getdoc)//sourceDesc/bibl/journaltitle"/ -->
                <xsl:variable name="title">
                    <xsl:choose>
                        <xsl:when test="doc($getdoc)//sourceDesc/bibl/volumetitle/node() != ''">
                            <xsl:value-of select="concat(doc($getdoc)//sourceDesc/bibl/title/node(), ' in ', doc($getdoc)//sourceDesc/bibl/volumetitle/node())"/>
                        </xsl:when>
                        <xsl:when test="doc($getdoc)//sourceDesc/bibl/journaltitle/node() != ''">
                            <xsl:value-of select="concat(doc($getdoc)//sourceDesc/bibl/title/node(), ' in ', doc($getdoc)//sourceDesc/bibl/journaltitle/node())"/>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:value-of select="doc($getdoc)//sourceDesc/bibl/title/node()"/>
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:variable>
                <!-- xsl:variable name="pplace" select="doc($getdoc)//sourceDesc/bibl/pubPlace"/ -->
                <xsl:variable name="pplace">
                    <xsl:choose>
                        <xsl:when test="doc($getdoc)//sourceDesc/bibl/pubPlace/node() != ''">
                            <xsl:value-of select="doc($getdoc)//sourceDesc/bibl/pubPlace/node()"/>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:value-of select="''"/>
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:variable>
                <!-- xsl:variable name="ppub" select="doc($getdoc)//sourceDesc/bibl/publisher"/ -->
                <xsl:variable name="ppub">
                    <xsl:choose>
                        <xsl:when test="doc($getdoc)//sourceDesc/bibl/publisher/node() != ''">
                            <xsl:value-of select="doc($getdoc)//sourceDesc/bibl/publisher/node()"/>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:value-of select="''"/>
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:variable>
                <xsl:variable name="unparsedpubinfo">
                    <xsl:choose>
                        <xsl:when test="doc($getdoc)//sourceDesc/bibl/pubInfo/node() != ''">
                            <xsl:value-of select="doc($getdoc)//sourceDesc/bibl/pubInfo/node()"/>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:value-of select="''"/>
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:variable>
                <xsl:variable name="pubinfo">
                    <xsl:choose>
                        <xsl:when test="($pplace != '') and ($ppub != '')">
                            <xsl:value-of select="concat($pplace, ': ', $ppub, ' ')"/>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:value-of select="concat($unparsedpubinfo, ' ')"/>
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:variable>
                <xsl:variable name="pdate" select="doc($getdoc)//sourceDesc/bibl/date"/>
                <xsl:variable name="ppage">
                    <xsl:choose>
                        <xsl:when test="doc($getdoc)//sourceDesc/bibl/biblScope/node() !=''">
                            <xsl:value-of select="string-join(doc($getdoc)//sourceDesc/bibl/biblScope/node(), ', ')"/>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:value-of select="'-----'"/>
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:variable>
                <th width="{$cellwidth}%">
                    Document #<xsl:value-of select="@col"/> (<xsl:value-of select="@lang"/>) <!-- xsl:value-of select="$docID1"/ -->
                    <!-- img source="/images/info2.png" width="15" height="15" title="Author: {$author}
						Title: {$title}
						Pub: {$pplace}: {$ppub} ({$pdate})
						Pagin: {$ppage}" alt="info-gif"/ -->
                    <img width="15" height="15" title="Author: {$author}&#xA;Title: {$title}&#xA;Pub: {$pubinfo}({$pdate})&#xA;Pagin: {$ppage}">
                        <xsl:attribute name="src">../images/info2.jpg</xsl:attribute>
                    </img>
                </th>
            </xsl:when>
            <xsl:when test="@col = '8'">
                <!-- xsl:variable name="thisID" select="replace(@id, '([0-9]+\-)', '')"/ -->
                <xsl:variable name="getdoc" select="concat('/db/tibetan/', $lang8, '/', $docID8, '.xml')"/>
                <xsl:variable name="getlang" select="$lang1"/>
                <xsl:variable name="getid" select="@id[contains(., $docID8)]"/>
                <xsl:variable name="author" select="string-join(doc($getdoc)//sourceDesc/bibl/author/node(), '; ')"/>
                <!-- xsl:variable name="title" select="doc($getdoc)//sourceDesc/bibl/title"/>
                <xsl:variable name="volumetitle" select="doc($getdoc)//sourceDesc/bibl/volumetitle"/>
                <xsl:variable name="journaltitle" select="doc($getdoc)//sourceDesc/bibl/journaltitle"/ -->
                <xsl:variable name="title">
                    <xsl:choose>
                        <xsl:when test="doc($getdoc)//sourceDesc/bibl/volumetitle/node() != ''">
                            <xsl:value-of select="concat(doc($getdoc)//sourceDesc/bibl/title/node(), ' in ', doc($getdoc)//sourceDesc/bibl/volumetitle/node())"/>
                        </xsl:when>
                        <xsl:when test="doc($getdoc)//sourceDesc/bibl/journaltitle/node() != ''">
                            <xsl:value-of select="concat(doc($getdoc)//sourceDesc/bibl/title/node(), ' in ', doc($getdoc)//sourceDesc/bibl/journaltitle/node())"/>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:value-of select="doc($getdoc)//sourceDesc/bibl/title/node()"/>
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:variable>
                <!-- xsl:variable name="pplace" select="doc($getdoc)//sourceDesc/bibl/pubPlace"/ -->
                <xsl:variable name="pplace">
                    <xsl:choose>
                        <xsl:when test="doc($getdoc)//sourceDesc/bibl/pubPlace/node() != ''">
                            <xsl:value-of select="doc($getdoc)//sourceDesc/bibl/pubPlace/node()"/>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:value-of select="''"/>
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:variable>
                <!-- xsl:variable name="ppub" select="doc($getdoc)//sourceDesc/bibl/publisher"/ -->
                <xsl:variable name="ppub">
                    <xsl:choose>
                        <xsl:when test="doc($getdoc)//sourceDesc/bibl/publisher/node() != ''">
                            <xsl:value-of select="doc($getdoc)//sourceDesc/bibl/publisher/node()"/>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:value-of select="''"/>
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:variable>
                <xsl:variable name="unparsedpubinfo">
                    <xsl:choose>
                        <xsl:when test="doc($getdoc)//sourceDesc/bibl/pubInfo/node() != ''">
                            <xsl:value-of select="doc($getdoc)//sourceDesc/bibl/pubInfo/node()"/>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:value-of select="''"/>
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:variable>
                <xsl:variable name="pubinfo">
                    <xsl:choose>
                        <xsl:when test="($pplace != '') and ($ppub != '')">
                            <xsl:value-of select="concat($pplace, ': ', $ppub, ' ')"/>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:value-of select="concat($unparsedpubinfo, ' ')"/>
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:variable>
                <xsl:variable name="pdate" select="doc($getdoc)//sourceDesc/bibl/date/node()"/>
                <xsl:variable name="ppage">
                    <xsl:choose>
                        <xsl:when test="doc($getdoc)//sourceDesc/bibl/biblScope/node() != ''">
                            <xsl:value-of select="string-join(doc($getdoc)//sourceDesc/bibl/biblScope/node(), ', ')"/>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:value-of select="'-----'"/>
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:variable>
                <th width="{$cellwidth}%">
                    Document #<xsl:value-of select="@col"/> (<xsl:value-of select="@lang"/>) <!-- xsl:value-of select="$docID1"/ -->
                    <!-- img src="/images/info2.png" width="15" height="15" title="Author: {$author}
						Title: {$title}
						Pub: {$pplace}: {$ppub} ({$pdate})
						Pagin: {$ppage}" alt="info-gif"/ -->
                    <img width="15" height="15" title="Author: {$author}&#xA;Title: {$title}&#xA;Pub: {$pubinfo}({$pdate})&#xA;Pagin: {$ppage}">
                        <xsl:attribute name="src">../images/info2.jpg</xsl:attribute>
                    </img>
                </th>
            </xsl:when>
        </xsl:choose>
    </xsl:template>
    <xsl:template match="div[@type='Inventory']">
        <tr>
            <xsl:apply-templates/>
        </tr>
    </xsl:template>
    <xsl:template match="div[@type='Cluster']">
        <tr>
            <xsl:apply-templates/>
        </tr>
    </xsl:template>
    <xsl:template match="div[@type='Sentence']|div[@type='Verse']|div[@type='Paragraph']|div[@type='Group']|div[@type='Text Colophon']|div[@type='Mantra']|div[@type='Homage']">
        <xsl:variable name="position" select="count(preceding-sibling::div)+1"/>
        <xsl:variable name="last" select="count(parent::list/div)"/>
        <xsl:choose>
            <xsl:when test="@col = '1'">
                <!-- Print data -->
                <td width="{$cellwidth}%" bgcolor="#00c3fb">
                    <!-- xsl:value-of select="concat('position = ', $position, ' col = ', @col, ' last = ', $last, ' ', 'no. witnesses', $numWitness)"/>
                    <xsl:value-of select="concat('following position = ', following-sibling::*[1]/@col, ' ')"/ -->
                    <xsl:apply-templates/>
                </td>
                <!-- CHECK to see if last dataset, if so, append blank field(s) -->
                <!-- Col = 2 -->
                <xsl:if test="(($position = $last) and ($position &lt; $numWitness))">
                    <td width="{$cellwidth}%" bgcolor="#ff00ff">
                        <xsl:variable name="status" select="$position"/>
                        <xsl:value-of select="' '"/>
                    </td>
                </xsl:if>
                <!-- Col = 3 -->
                <xsl:if test="(($position = $last) and (($position + 1) &lt; $numWitness))">
                    <td width="{$cellwidth}%" bgcolor="#cc6699">
                        <xsl:value-of select="' '"/>
                    </td>
                </xsl:if>
                <!-- Col = 4 -->
                <xsl:if test="(($position = $last) and (($position + 2) &lt; $numWitness))">
                    <td width="{$cellwidth}%" bgcolor="#00aa22">
                        <xsl:value-of select="' '"/>
                    </td>
                </xsl:if>
                <!-- Col = 5 -->
                <xsl:if test="(($position = $last) and (($position + 3) &lt; $numWitness))">
                    <td width="{$cellwidth}%" bgcolor="#ffff00">
                        <xsl:value-of select="' '"/>
                    </td>
                </xsl:if>
                <!-- Col = 6 -->
                <xsl:if test="(($position = $last) and (($position + 4) &lt; $numWitness))">
                    <td width="{$cellwidth}%" bgcolor="#00ffff">
                        <xsl:value-of select="' '"/>
                    </td>
                </xsl:if>
                <!-- Col = 7 -->
                <xsl:if test="(($position = $last) and (($position + 5) &lt; $numWitness))">
                    <td width="{$cellwidth}%" bgcolor="#99ff00">
                        <xsl:value-of select="' '"/>
                    </td>
                </xsl:if>
                <!-- Col = 8 -->
                <xsl:if test="(($position = $last) and (($position + 6) &lt; $numWitness))">
                    <td width="{$cellwidth}%" bgcolor="#f0f099">
                        <xsl:value-of select="' '"/>
                    </td>
                </xsl:if>
            </xsl:when>
            <xsl:when test="@col = '2'">
                <!-- CHECK to see if first dataset, if so, prepend blank field -->
                <!-- Col = 1 -->
                <xsl:if test="$position = 1">
                    <td width="{$cellwidth}%" bgcolor="#00c3fb">
                        <xsl:value-of select="string(' ')"/>
                    </td>
                </xsl:if>
                <!-- Print data -->
                <!-- Col = 2 -->
                <td width="{$cellwidth}%" bgcolor="#ff00ff">
                    <!-- xsl:variable name="thislang" select="$lang2"/ -->
                    <!-- xsl:value-of select="concat('position = ', $position, ' col = ', @col, ' last = ', $last, ' ')"/>
                    <xsl:value-of select="concat('preceding position = ', preceding-sibling::*[1]/@col, ' ')"/>
                    <xsl:value-of select="concat('following position = ', following-sibling::*[1]/@col, ' ')"/ -->
                    <xsl:apply-templates/>
                </td>
                <!-- CHECK to see if last dataset, if so, append blank field(s) -->
                <!-- Col = 3 -->
                <xsl:if test="(($position = $last) and ($position = @col) and ($position &lt; $numWitness))">
                    <td width="{$cellwidth}%" bgcolor="#cc6699">
                        <xsl:value-of select="' '"/>
                    </td>
                </xsl:if>
                <!-- Col = 4 -->
                <xsl:if test="(($position = $last) and ($position = @col) and (($position + 1) &lt; $numWitness))">
                    <td width="{$cellwidth}%" bgcolor="#00aa22">
                        <xsl:value-of select="' '"/>
                    </td>
                </xsl:if>
                <!-- Col = 5 -->
                <xsl:if test="(($position = $last) and ($position = @col) and (($position + 2) &lt; $numWitness))">
                    <td width="{$cellwidth}%" bgcolor="#00c3fb">
                        <xsl:value-of select="' '"/>
                    </td>
                </xsl:if>
                <!-- Col = 6 -->
                <xsl:if test="(($position = $last) and ($position = @col) and (($position + 3) &lt; $numWitness))">
                    <td width="{$cellwidth}%" bgcolor="#00ffff">
                        <xsl:value-of select="' '"/>
                    </td>
                </xsl:if>
                <!-- Col = 7 -->
                <xsl:if test="(($position = $last) and ($position = @col) and (($position + 4) &lt; $numWitness))">
                    <td width="{$cellwidth}%" bgcolor="#99ff00">
                        <xsl:value-of select="' '"/>
                    </td>
                </xsl:if>
                <!-- Col = 8 -->
                <xsl:if test="(($position = $last) and ($position = @col) and (($position + 5) &lt; $numWitness))">
                    <td width="{$cellwidth}%" bgcolor="#f0f099">
                        <xsl:value-of select="' '"/>
                    </td>
                </xsl:if>
                <!-- Now check to see if there is n-1 gaps -->
                <!-- Col = 3 -->
                <xsl:if test="(($position = $last) and ($position = (@col - 1)) and (($position + 1) &lt; $numWitness))">
                    <td width="{$cellwidth}%" bgcolor="#cc6699">
                        <xsl:value-of select="' '"/>
                    </td>
                </xsl:if>
                <!-- Col = 4 -->
                <xsl:if test="(($position = $last) and ($position = (@col - 1)) and (($position + 2) &lt; $numWitness))">
                    <td width="{$cellwidth}%" bgcolor="#00aa22">
                        <xsl:value-of select="' '"/>
                    </td>
                </xsl:if>
                <!-- Col = 5 -->
                <xsl:if test="(($position = $last) and ($position = (@col - 1)) and (($position + 3) &lt; $numWitness))">
                    <td width="{$cellwidth}%" bgcolor="#00c3fb">
                        <xsl:value-of select="' '"/>
                    </td>
                </xsl:if>
                <!-- Col = 6 -->
                <xsl:if test="(($position = $last) and ($position = (@col - 1)) and (($position + 4) &lt; $numWitness))">
                    <td width="{$cellwidth}%" bgcolor="#00ffff">
                        <xsl:value-of select="' '"/>
                    </td>
                </xsl:if>
                <!-- Col = 7 -->
                <xsl:if test="(($position = $last) and ($position = (@col - 1)) and (($position + 5) &lt; $numWitness))">
                    <td width="{$cellwidth}%" bgcolor="#99ff00">
                        <xsl:value-of select="' '"/>
                    </td>
                </xsl:if>
                <!-- Now check to see if there is n-2 gaps -->
                <!-- Col = 3 -->
                <xsl:if test="(($position = $last) and ($position = (@col - 2)) and (($position + 2) &lt; $numWitness))">
                    <td width="{$cellwidth}%" bgcolor="#cc6699">
                        <xsl:value-of select="' '"/>
                    </td>
                </xsl:if>
                <!-- Col = 4 -->
                <xsl:if test="(($position = $last) and ($position = (@col - 2)) and (($position + 3) &lt; $numWitness))">
                    <td width="{$cellwidth}%" bgcolor="#00aa22">
                        <xsl:value-of select="' '"/>
                    </td>
                </xsl:if>
                <!-- Col = 5 -->
                <xsl:if test="(($position = $last) and ($position = (@col - 2)) and (($position + 4) &lt; $numWitness))">
                    <td width="{$cellwidth}%" bgcolor="#00c3fb">
                        <xsl:value-of select="' '"/>
                    </td>
                </xsl:if>
                <!-- Col = 6 -->
                <xsl:if test="(($position = $last) and ($position = (@col - 2)) and (($position + 5) &lt; $numWitness))">
                    <td width="{$cellwidth}%" bgcolor="#00ffff">
                        <xsl:value-of select="' '"/>
                    </td>
                </xsl:if>
                <!-- Now check to see if there is n-3 gaps -->
                <!-- Col = 3 -->
                <xsl:if test="(($position = $last) and ($position = (@col - 3)) and (($position + 3) &lt; $numWitness))">
                    <td width="{$cellwidth}%" bgcolor="#cc6699">
                        <xsl:value-of select="' '"/>
                    </td>
                </xsl:if>
                <!-- Col = 4 -->
                <xsl:if test="(($position = $last) and ($position = (@col - 3)) and (($position + 4) &lt; $numWitness))">
                    <td width="{$cellwidth}%" bgcolor="#00aa22">
                        <xsl:value-of select="' '"/>
                    </td>
                </xsl:if>
                <!-- Col = 5 -->
                <xsl:if test="(($position = $last) and ($position = (@col - 3)) and (($position + 5) &lt; $numWitness))">
                    <td width="{$cellwidth}%" bgcolor="#00c3fb">
                        <xsl:value-of select="' '"/>
                    </td>
                </xsl:if>
                <!-- Now check to see if there is n-4 gaps -->
                <!-- Col = 4 -->
                <xsl:if test="(($position = $last) and ($position = (@col - 4)) and (($position + 4) &lt; $numWitness))">
                    <td width="{$cellwidth}%" bgcolor="#cc6699">
                        <xsl:value-of select="' '"/>
                    </td>
                </xsl:if>
                <!-- Col = 4 -->
                <xsl:if test="(($position = $last) and ($position = (@col - 4)) and (($position + 5) &lt; $numWitness))">
                    <td width="{$cellwidth}%" bgcolor="#00aa22">
                        <xsl:value-of select="' '"/>
                    </td>
                </xsl:if>
                <!-- Now check to see if there is n-5 gaps -->
                <!-- Col = 4 -->
                <xsl:if test="(($position = $last) and ($position = (@col - 5)) and (($position + 5) &lt; $numWitness))">
                    <td width="{$cellwidth}%" bgcolor="#cc6699">
                        <xsl:value-of select="' '"/>
                    </td>
                </xsl:if>
            </xsl:when>
            <xsl:when test="@col = '3'">
                <!-- CHECK to see if first dataset, if so, prepend blank fields -->
                <xsl:if test="$position = 1">
                    <td width="{$cellwidth}%" bgcolor="#00c3fb">
                        <xsl:value-of select="string(' ')"/>
                    </td>
                    <td width="{$cellwidth}%" bgcolor="#ff00ff">
                        <xsl:value-of select="string(' ')"/>
                    </td>
                </xsl:if>
                <!-- CHECK to see if gaps in dataset, if so, prepend blank fields -->
                <!-- Col = 2 -->
                <xsl:if test="(($position = (@col - 1)) and (preceding-sibling::*[1]/@col != (@col - 1)))">
                    <td width="{$cellwidth}%" bgcolor="#ff00ff">
                        <xsl:value-of select="string(' ')"/>
                    </td>
                </xsl:if>
                <!-- Print data -->
                <!-- Col = 3 -->
                <td width="{$cellwidth}%" bgcolor="#cc6699">
                    <!-- xsl:value-of select="@col"/ -->
                    <!-- xsl:value-of select="concat('position = ', $position, ' col = ', @col, ' last = ', $last, ' ')"/>
                    <xsl:value-of select="concat('preceding position = ', preceding-sibling::*[1]/@col, ' ')"/>
                    <xsl:value-of select="concat('following position = ', following-sibling::*[1]/@col, ' ')"/ -->
                    <xsl:apply-templates/>
                </td>
                <!-- CHECK to see if last dataset, if so, append blank field(s) -->
                <!-- Col = 4 -->
                <xsl:if test="(($position = $last) and ($position &lt; $numWitness))">
                    <td bgcolor="#00aa22">
                        <xsl:value-of select="' '"/>
                    </td>
                </xsl:if>
                <!-- Col = 5 -->
                <xsl:if test="(($position = $last) and (($position + 1) &lt; $numWitness))">
                    <td width="{$cellwidth}%" bgcolor="#00c3fb">
                        <xsl:value-of select="' '"/>
                    </td>
                </xsl:if>
                <!-- Col = 6 -->
                <xsl:if test="(($position = $last) and (($position + 2) &lt; $numWitness))">
                    <td width="{$cellwidth}%" bgcolor="#00ffff">
                        <xsl:value-of select="' '"/>
                    </td>
                </xsl:if>
                <!-- Col = 7 -->
                <xsl:if test="(($position = $last) and (($position + 3) &lt; $numWitness))">
                    <td width="{$cellwidth}%" bgcolor="#99ff00">
                        <xsl:value-of select="' '"/>
                    </td>
                </xsl:if>
                <!-- Col = 8 -->
                <xsl:if test="(($position = $last) and (($position + 4) &lt; $numWitness))">
                    <td width="{$cellwidth}%" bgcolor="#f0f099">
                        <xsl:value-of select="' '"/>
                    </td>
                </xsl:if>
            </xsl:when>
            <xsl:when test="@col = '4'">
                <!-- CHECK to see if first dataset, if so, prepend blank fields -->
                <xsl:if test="$position = 1">
                    <td width="{$cellwidth}%" bgcolor="#00c3fb">
                        <xsl:value-of select="string(' ')"/>
                    </td>
                    <td width="{$cellwidth}%" bgcolor="#ff00ff">
                        <xsl:value-of select="string(' ')"/>
                    </td>
                    <td width="{$cellwidth}%" bgcolor="#cc6699">
                        <xsl:value-of select="string(' ')"/>
                    </td>
                </xsl:if>
                <!-- CHECK to see if gaps in dataset, if so, prepend blank fields -->
                <!-- Col = 2 -->
                <xsl:if test="(($position = (@col - 2)) and (preceding-sibling::*[1]/@col != (@col - 1)) and (preceding-sibling::*[1]/@col != (@col - 2)))">
                    <td width="{$cellwidth}%" bgcolor="#ff00ff">
                        <xsl:value-of select="string(' ')"/>
                    </td>
                </xsl:if>
                <!-- Col = 3 -->
                <xsl:if test="(($position = (@col - 2)) and (preceding-sibling::*[1]/@col != (@col - 1)))">
                    <td width="{$cellwidth}%" bgcolor="#cc6699">
                        <xsl:value-of select="string(' ')"/>
                    </td>
                </xsl:if>
                <!-- Col = 3 -->
                <xsl:if test="(($position = (@col - 1)) and (preceding-sibling::*[1]/@col != (@col - 1)))">
                    <td width="{$cellwidth}%" bgcolor="#cc6699">
                        <xsl:value-of select="string(' ')"/>
                    </td>
                </xsl:if>
                <!-- Print data -->
                <!-- Col = 4 -->
                <td width="{$cellwidth}%" bgcolor="#00aa22">
                    <!-- xsl:value-of select="@col"/ -->
                    <!-- xsl:value-of select="concat('position = ', $position, ' col = ', @col, ' last = ', $last, ' ')"/>
                    <xsl:value-of select="concat('preceding position = ', preceding-sibling::*[1]/@col, ' ')"/>
                    <xsl:value-of select="concat('following position = ', following-sibling::*[1]/@col, ' ')"/ -->
                    <xsl:apply-templates/>
                </td>
                <!-- CHECK to see if last dataset, if so, append blank field(s) -->
                <!-- Col = 5 -->
                <xsl:if test="(($position = $last) and ($position &lt; $numWitness))">
                    <td width="{$cellwidth}%" bgcolor="#00c3fb">
                        <xsl:value-of select="' '"/>
                    </td>
                </xsl:if>
                <!-- Col = 6 -->
                <xsl:if test="(($position = $last) and (($position + 1) &lt; $numWitness))">
                    <td width="{$cellwidth}%" bgcolor="#00ffff">
                        <xsl:value-of select="' '"/>
                    </td>
                </xsl:if>
                <!-- Col = 7 -->
                <xsl:if test="(($position = $last) and (($position + 2) &lt; $numWitness))">
                    <td width="{$cellwidth}%" bgcolor="#99ff00">
                        <xsl:value-of select="' '"/>
                    </td>
                </xsl:if>
                <!-- Col = 8 -->
                <xsl:if test="(($position = $last) and (($position + 3) &lt; $numWitness))">
                    <td width="{$cellwidth}%" bgcolor="#f0f099">
                        <xsl:value-of select="' '"/>
                    </td>
                </xsl:if>
                <!-- Now check to see if there is n-1 gaps -->
                <!-- Col = 3 -->
                <xsl:if test="(($position = $last) and ($position = (@col - 1)) and (($position + 1) &lt; $numWitness))">
                    <td width="{$cellwidth}%" bgcolor="#cc6699">
                        <xsl:value-of select="' '"/>
                    </td>
                </xsl:if>
                <!-- Col = 4 -->
                <xsl:if test="(($position = $last) and ($position = (@col - 1)) and (($position + 2) &lt; $numWitness))">
                    <td width="{$cellwidth}%" bgcolor="#00aa22">
                        <xsl:value-of select="' '"/>
                    </td>
                </xsl:if>
                <!-- Col = 5 -->
                <xsl:if test="(($position = $last) and ($position = (@col - 1)) and (($position + 3) &lt; $numWitness))">
                    <td width="{$cellwidth}%" bgcolor="#00c3fb">
                        <xsl:value-of select="' '"/>
                    </td>
                </xsl:if>
                <!-- Now check to see if there is n-2 gaps -->
                <!-- Col = 3 -->
                <xsl:if test="(($position = $last) and ($position = (@col - 2)) and (($position + 2) &lt; $numWitness))">
                    <td width="{$cellwidth}%" bgcolor="#cc6699">
                        <xsl:value-of select="' '"/>
                    </td>
                </xsl:if>
                <!-- Col = 4 -->
                <xsl:if test="(($position = $last) and ($position = (@col - 2)) and (($position + 3) &lt; $numWitness))">
                    <td width="{$cellwidth}%" bgcolor="#00aa22">
                        <xsl:value-of select="' '"/>
                    </td>
                </xsl:if>
                <!-- Now check to see if there is n-3 gaps -->
                <!-- Col = 3 -->
                <xsl:if test="(($position = $last) and ($position = (@col - 3)) and (($position + 3) &lt; $numWitness))">
                    <td width="{$cellwidth}%" bgcolor="#cc6699">
                        <xsl:value-of select="' '"/>
                    </td>
                </xsl:if>
            </xsl:when>
            <xsl:when test="@col = '5'">
                <xsl:if test="$position = 1">
                    <td width="{$cellwidth}%" bgcolor="#00c3fb">
                        <xsl:value-of select="string(' ')"/>
                    </td>
                    <td width="{$cellwidth}%" bgcolor="#ff00ff">
                        <xsl:value-of select="string(' ')"/>
                    </td>
                    <td width="{$cellwidth}%" bgcolor="#cc6699">
                        <xsl:value-of select="string(' ')"/>
                    </td>
                    <td width="{$cellwidth}%" bgcolor="#00aa22">
                        <xsl:value-of select="string(' ')"/>
                    </td>
                </xsl:if>
                <!-- CHECK to see if gaps in dataset, if so, prepend blank fields -->
                <xsl:if test="(($position = (@col - 3)) and (preceding-sibling::*[1]/@col != (@col - 1)) and (preceding-sibling::*[1]/@col != (@col - 2)) and (preceding-sibling::*[1]/@col != (@col - 3)))">
                    <td width="{$cellwidth}%" bgcolor="#ff00ff">
                        <xsl:value-of select="string(' ')"/>
                    </td>
                </xsl:if>
                <xsl:if test="(($position = (@col - 3)) and (preceding-sibling::*[1]/@col != (@col - 1)) and (preceding-sibling::*[1]/@col != (@col - 2)))">
                    <td width="{$cellwidth}%" bgcolor="#cc6699">
                        <xsl:value-of select="string(' ')"/>
                    </td>
                </xsl:if>
                <xsl:if test="(($position = (@col - 3)) and (preceding-sibling::*[1]/@col != (@col - 1)))">
                    <td width="{$cellwidth}%" bgcolor="#00aa22">
                        <xsl:value-of select="string(' ')"/>
                    </td>
                </xsl:if>
                <xsl:if test="(($position = (@col - 2)) and (preceding-sibling::*[1]/@col != (@col - 1)) and (preceding-sibling::*[1]/@col != (@col - 2)))">
                    <td width="{$cellwidth}%" bgcolor="#cc6699">
                        <xsl:value-of select="string(' ')"/>
                    </td>
                </xsl:if>
                <xsl:if test="(($position = (@col - 2)) and (preceding-sibling::*[1]/@col != (@col - 1)))">
                    <td width="{$cellwidth}%" bgcolor="#00aa22">
                        <xsl:value-of select="string(' ')"/>
                    </td>
                </xsl:if>
                <xsl:if test="(($position = (@col - 1)) and (preceding-sibling::*[1]/@col != (@col - 1)))">
                    <td width="{$cellwidth}%" bgcolor="#00aa22">
                        <xsl:value-of select="string(' ')"/>
                    </td>
                </xsl:if>
                <!-- Print data -->
                <td width="{$cellwidth}%" bgcolor="#ffff00">
                    <!-- xsl:value-of select="@col"/ -->
                    <!-- xsl:value-of select="concat('position = ', $position, ' col = ', @col, ' last = ', $last, ' ')"/>
                    <xsl:value-of select="concat('preceding position = ', preceding-sibling::*[1]/@col, ' ')"/>
                    <xsl:value-of select="concat('following position = ', following-sibling::*[1]/@col, ' ')"/ -->
                    <xsl:apply-templates/>
                </td>
                <!-- CHECK to see if last dataset, if so, append blank field(s) -->
                <!-- Col = 6 -->
                <xsl:if test="(($position = $last) and (($position) &lt; $numWitness))">
                    <td width="{$cellwidth}%" bgcolor="#00ffff">
                        <xsl:value-of select="' '"/>
                    </td>
                </xsl:if>
                <!-- Col = 7 -->
                <xsl:if test="(($position = $last) and (($position + 1) &lt; $numWitness))">
                    <td width="{$cellwidth}%" bgcolor="#99ff00">
                        <xsl:value-of select="' '"/>
                    </td>
                </xsl:if>
                <!-- Col = 8 -->
                <xsl:if test="(($position = $last) and (($position + 2) &lt; $numWitness))">
                    <td width="{$cellwidth}%" bgcolor="#f0f099">
                        <xsl:value-of select="' '"/>
                    </td>
                </xsl:if>
                <!-- Now check to see if there is n-1 gaps -->
                <!-- Col = 6 -->
                <xsl:if test="(($position = $last) and ($position = (@col - 1)) and (($position + 1) &lt; $numWitness))">
                    <td width="{$cellwidth}%" bgcolor="#00ffff">
                        <xsl:value-of select="' '"/>
                    </td>
                </xsl:if>
                <!-- Col = 7 -->
                <xsl:if test="(($position = $last) and ($position = (@col - 1)) and (($position + 2) &lt; $numWitness))">
                    <td width="{$cellwidth}%" bgcolor="#99ff00">
                        <xsl:value-of select="' '"/>
                    </td>
                </xsl:if>
                <!-- Now check to see if there is n-2 gaps -->
                <!-- Col = 6 -->
                <xsl:if test="(($position = $last) and ($position = (@col - 2)) and (($position + 2) &lt; $numWitness))">
                    <td width="{$cellwidth}%" bgcolor="#00ffff">
                        <xsl:value-of select="' '"/>
                    </td>
                </xsl:if>
            </xsl:when>
            <xsl:when test="@col = '6'">
                <xsl:if test="$position = 1">
                    <td width="{$cellwidth}%" bgcolor="#00c3fb">
                        <xsl:value-of select="string(' ')"/>
                    </td>
                    <td width="{$cellwidth}%" bgcolor="#ff00ff">
                        <xsl:value-of select="string(' ')"/>
                    </td>
                    <td width="{$cellwidth}%" bgcolor="#cc6699">
                        <xsl:value-of select="string(' ')"/>
                    </td>
                    <td width="{$cellwidth}%" bgcolor="#00aa22">
                        <xsl:value-of select="string(' ')"/>
                    </td>
                    <td width="{$cellwidth}%" bgcolor="#00c3fb">
                        <xsl:value-of select="string(' ')"/>
                    </td>
                </xsl:if>
                <!-- CHECK to see if gaps in dataset, if so, prepend blank fields -->
				<!-- Blank Col = 2 -->
                <xsl:if test="(($position = (@col - 4)) and (preceding-sibling::*[1]/@col != (@col - 1)) and (preceding-sibling::*[1]/@col != (@col - 2)) and (preceding-sibling::*[1]/@col != (@col - 3)) and (preceding-sibling::*[1]/@col != (@col - 4)))">
                    <td width="{$cellwidth}%" bgcolor="#ff00ff">
                        <xsl:value-of select="string(' ')"/>
                    </td>
                </xsl:if>
				<!-- Blank Col = 3 -->
                <xsl:if test="(($position = (@col - 4)) and (preceding-sibling::*[1]/@col != (@col - 1)) and (preceding-sibling::*[1]/@col != (@col - 2)) and (preceding-sibling::*[1]/@col != (@col - 3)))">
                    <td width="{$cellwidth}%" bgcolor="#cc6699">
                        <xsl:value-of select="string(' ')"/>
                    </td>
                </xsl:if>
				<!-- Blank Col = 4 -->
                <xsl:if test="(($position = (@col - 4)) and (preceding-sibling::*[1]/@col != (@col - 1)) and (preceding-sibling::*[1]/@col != (@col - 2)))">
                    <td width="{$cellwidth}%" bgcolor="#00aa22">
                        <xsl:value-of select="string(' ')"/>
                    </td>
                </xsl:if>
				<!-- Blank Col = 5 -->
                <xsl:if test="(($position = (@col - 4)) and (preceding-sibling::*[1]/@col != (@col - 1)))">
                    <td width="{$cellwidth}%" bgcolor="#ffff00">
                        <xsl:value-of select="string(' ')"/>
                    </td>
                </xsl:if>
				<!-- Blank Col = 3 -->
                <xsl:if test="(($position = (@col - 3)) and (preceding-sibling::*[1]/@col != (@col - 1)) and (preceding-sibling::*[1]/@col != (@col - 2)) and (preceding-sibling::*[1]/@col != (@col - 3)))">
                    <td width="{$cellwidth}%" bgcolor="#cc6699">
                        <xsl:value-of select="string(' ')"/>
                    </td>
                </xsl:if>
				<!-- Blank Col = 4 -->
                <xsl:if test="(($position = (@col - 3)) and (preceding-sibling::*[1]/@col != (@col - 1)) and (preceding-sibling::*[1]/@col != (@col - 2)))">
                    <td width="{$cellwidth}%" bgcolor="#00aa22">
                        <xsl:value-of select="string(' ')"/>
                    </td>
                </xsl:if>
				<!-- Blank Col = 5 -->
                <xsl:if test="(($position = (@col - 3)) and (preceding-sibling::*[1]/@col != (@col - 1)))">
                    <td width="{$cellwidth}%" bgcolor="#ffff00">
                        <xsl:value-of select="string(' ')"/>
                    </td>
                </xsl:if>
				<!-- Blank Col = 4 -->
                <xsl:if test="(($position = (@col - 2)) and (preceding-sibling::*[1]/@col != (@col - 1)) and (preceding-sibling::*[1]/@col != (@col - 2)))">
                    <td width="{$cellwidth}%" bgcolor="#00aa22">
                        <xsl:value-of select="string(' ')"/>
                    </td>
                </xsl:if>
				<!-- Blank Col = 5 -->
                <xsl:if test="(($position = (@col - 2)) and (preceding-sibling::*[1]/@col != (@col - 1)))">
                    <td width="{$cellwidth}%" bgcolor="#ffff00">
                        <xsl:value-of select="string(' ')"/>
                    </td>
                </xsl:if>
				<!-- Blank Col = 5 -->
                <xsl:if test="(($position = (@col - 1)) and (preceding-sibling::*[1]/@col != (@col - 1)))">
                    <td width="{$cellwidth}%" bgcolor="#ffff00">
                        <xsl:value-of select="string(' ')"/>
                    </td>
                </xsl:if>
                <!-- Print data -->
                <td width="{$cellwidth}%" bgcolor="#00ffff">
                    <!-- xsl:value-of select="@col"/ -->
                    <!-- xsl:value-of select="concat('position = ', $position, ' col = ', @col, ' last = ', $last, ' ')"/>
                    <xsl:value-of select="concat('preceding position = ', preceding-sibling::*[1]/@col, ' ')"/>
                    <xsl:value-of select="concat('following position = ', following-sibling::*[1]/@col, ' ')"/ -->
                    <xsl:apply-templates/>
                </td>
                <!-- CHECK to see if last dataset, if so, append blank field(s) -->
                <!-- Col = 7 -->
                <xsl:if test="(($position = $last) and (($position) &lt; $numWitness))">
                    <td width="{$cellwidth}%" bgcolor="#99ff00">
                        <xsl:value-of select="' '"/>
                    </td>
                </xsl:if>
                <!-- Col = 8 -->
                <xsl:if test="(($position = $last) and (($position + 1) &lt; $numWitness))">
                    <td width="{$cellwidth}%" bgcolor="#f0f099">
                        <xsl:value-of select="' '"/>
                    </td>
                </xsl:if>
            </xsl:when>
            <xsl:when test="@col = '7'">
                <xsl:if test="$position = 1">
                    <!-- Blank Col = 1 -->
                    <td width="{$cellwidth}%" bgcolor="#00c3fb">
                        <xsl:value-of select="string(' ')"/>
                    </td>
                    <!-- Blank Col = 2 -->
                    <td width="{$cellwidth}%" bgcolor="#ff00ff">
                        <xsl:value-of select="string(' ')"/>
                    </td>
                    <!-- Blank Col = 3 -->
                    <td width="{$cellwidth}%" bgcolor="#cc6699">
                        <xsl:value-of select="string(' ')"/>
                    </td>
                    <!-- Blank Col = 4 -->
                    <td width="{$cellwidth}%" bgcolor="#00aa22">
                        <xsl:value-of select="string(' ')"/>
                    </td>
                    <!-- Blank Col = 5 -->
                    <td width="{$cellwidth}%" bgcolor="#ffff00">
                        <xsl:value-of select="string(' ')"/>
                    </td>
                    <!-- Blank Col = 6 -->
                    <td width="{$cellwidth}%" bgcolor="#00ffff">
                        <xsl:value-of select="string(' ')"/>
                    </td>
                </xsl:if>
                <!-- CHECK to see if gaps in dataset, if so, prepend blank fields -->
				<!-- Blank Col = 2 -->
                <xsl:if test="(($position = (@col - 5)) and (preceding-sibling::*[1]/@col != (@col - 1)) and (preceding-sibling::*[1]/@col != (@col - 2)) and (preceding-sibling::*[1]/@col != (@col - 3)) and (preceding-sibling::*[1]/@col != (@col - 4)) and (preceding-sibling::*[1]/@col != (@col - 5)))">
                    <td width="{$cellwidth}%" bgcolor="#ff00ff">
                        <xsl:value-of select="string(' ')"/>
                    </td>
                </xsl:if>
				<!-- Blank Col = 3 -->
                <xsl:if test="(($position = (@col - 5)) and (preceding-sibling::*[1]/@col != (@col - 1)) and (preceding-sibling::*[1]/@col != (@col - 2)) and (preceding-sibling::*[1]/@col != (@col - 3)) and (preceding-sibling::*[1]/@col != (@col - 4)))">
                    <td width="{$cellwidth}%" bgcolor="#cc6699">
                        <xsl:value-of select="string(' ')"/>
                    </td>
                </xsl:if>
				<!-- Blank Col = 4 -->
                <xsl:if test="(($position = (@col - 5)) and (preceding-sibling::*[1]/@col != (@col - 1)) and (preceding-sibling::*[1]/@col != (@col - 2)) and (preceding-sibling::*[1]/@col != (@col - 3)))">
                    <td width="{$cellwidth}%" bgcolor="#00aa22">
                        <xsl:value-of select="string(' ')"/>
                    </td>
                </xsl:if>
				<!-- Blank Col = 5 -->
                <xsl:if test="(($position = (@col - 5)) and (preceding-sibling::*[1]/@col != (@col - 1)) and (preceding-sibling::*[1]/@col != (@col - 2)))">
                    <td width="{$cellwidth}%" bgcolor="#ffff00">
                        <xsl:value-of select="string(' ')"/>
                    </td>
                </xsl:if>
				<!-- Blank Col = 6 -->
                <xsl:if test="(($position = (@col - 5)) and (preceding-sibling::*[1]/@col != (@col - 1)))">
                    <td width="{$cellwidth}%" bgcolor="#00ffff">
                        <xsl:value-of select="string(' ')"/>
                    </td>
                </xsl:if>
				<!-- Blank Col = 3 -->
                <xsl:if test="(($position = (@col - 4)) and (preceding-sibling::*[1]/@col != (@col - 1)) and (preceding-sibling::*[1]/@col != (@col - 2)) and (preceding-sibling::*[1]/@col != (@col - 3)) and (preceding-sibling::*[1]/@col != (@col - 4)))">
                    <td width="{$cellwidth}%" bgcolor="#cc6699">
                        <xsl:value-of select="string(' ')"/>
                    </td>
                </xsl:if>
				<!-- Blank Col = 4 -->
                <xsl:if test="(($position = (@col - 4)) and (preceding-sibling::*[1]/@col != (@col - 1)) and (preceding-sibling::*[1]/@col != (@col - 2)) and (preceding-sibling::*[1]/@col != (@col - 3)))">
                    <td width="{$cellwidth}%" bgcolor="#00aa22">
                        <xsl:value-of select="string(' ')"/>
                    </td>
                </xsl:if>
				<!-- Blank Col = 5 -->
                <xsl:if test="(($position = (@col - 4)) and (preceding-sibling::*[1]/@col != (@col - 1)) and (preceding-sibling::*[1]/@col != (@col - 2)))">
                    <td width="{$cellwidth}%" bgcolor="#ffff00">
                        <xsl:value-of select="string(' ')"/>
                    </td>
                </xsl:if>
				<!-- Blank Col = 6 -->
                <xsl:if test="(($position = (@col - 4)) and (preceding-sibling::*[1]/@col != (@col - 1)))">
                    <td width="{$cellwidth}%" bgcolor="#00ffff">
                        <xsl:value-of select="string(' ')"/>
                    </td>
                </xsl:if>
				<!-- Blank Col = 4 -->
                <xsl:if test="(($position = (@col - 3)) and (preceding-sibling::*[1]/@col != (@col - 1)) and (preceding-sibling::*[1]/@col != (@col - 2)) and (preceding-sibling::*[1]/@col != (@col - 3)))">
                    <td width="{$cellwidth}%" bgcolor="#00aa22">
                        <xsl:value-of select="string(' ')"/>
                    </td>
                </xsl:if>
				<!-- Blank Col = 5 -->
                <xsl:if test="(($position = (@col - 3)) and (preceding-sibling::*[1]/@col != (@col - 1)) and (preceding-sibling::*[1]/@col != (@col - 2)))">
                    <td width="{$cellwidth}%" bgcolor="#ffff00">
                        <xsl:value-of select="string(' ')"/>
                    </td>
                </xsl:if>
				<!-- Blank Col = 6 -->
                <xsl:if test="(($position = (@col - 3)) and (preceding-sibling::*[1]/@col != (@col - 1)))">
                    <td width="{$cellwidth}%" bgcolor="#00ffff">
                        <xsl:value-of select="string(' ')"/>
                    </td>
                </xsl:if>
				<!-- Blank Col = 5 -->
                <xsl:if test="(($position = (@col - 2)) and (preceding-sibling::*[1]/@col != (@col - 1)) and (preceding-sibling::*[1]/@col != (@col - 2)))">
                    <td width="{$cellwidth}%" bgcolor="#ffff00">
                        <xsl:value-of select="string(' ')"/>
                    </td>
                </xsl:if>
				<!-- Blank Col = 6 -->
                <xsl:if test="(($position = (@col - 2)) and (preceding-sibling::*[1]/@col != (@col - 1)))">
                    <td width="{$cellwidth}%" bgcolor="#00ffff">
                        <xsl:value-of select="string(' ')"/>
                    </td>
                </xsl:if>
				<!-- Blank Col = 6 -->
                <xsl:if test="(($position = (@col - 1)) and (preceding-sibling::*[1]/@col != (@col - 1)))">
                    <td width="{$cellwidth}%" bgcolor="#00ffff">
                        <xsl:value-of select="string(' ')"/>
                    </td>
                </xsl:if>
                <!-- Print data -->
                <td width="{$cellwidth}%" bgcolor="#99ff00">
                    <!-- xsl:value-of select="@col"/ -->
                    <!-- xsl:value-of select="concat('position = ', $position, ' col = ', @col, ' last = ', $last, ' ')"/>
                    <xsl:value-of select="concat('preceding position = ', preceding-sibling::*[1]/@col, ' ')"/>
                    <xsl:value-of select="concat('following position = ', following-sibling::*[1]/@col, ' ')"/ -->
                    <xsl:apply-templates/>
                </td>
                <!-- CHECK to see if last dataset, if so, append blank field(s) -->
                <!-- Col = 8 -->
                <xsl:if test="(($position = $last) and (($position + 1) &lt; $numWitness))">
                    <td width="{$cellwidth}%" bgcolor="#f0f099">
                        <xsl:value-of select="' '"/>
                    </td>
                </xsl:if>
            </xsl:when>
            <xsl:when test="@col = '8'">
                <xsl:if test="$position = 1">
                    <td width="{$cellwidth}%" bgcolor="#00c3fb">
                        <xsl:value-of select="string(' ')"/>
                    </td>
                    <td width="{$cellwidth}%" bgcolor="#ff00ff">
                        <xsl:value-of select="string(' ')"/>
                    </td>
                    <td width="{$cellwidth}%" bgcolor="#cc6699">
                        <xsl:value-of select="string(' ')"/>
                    </td>
                    <td width="{$cellwidth}%" bgcolor="#00aa22">
                        <xsl:value-of select="string(' ')"/>
                    </td>
                    <td width="{$cellwidth}%" bgcolor="#00c3fb">
                        <xsl:value-of select="string(' ')"/>
                    </td>
                    <td width="{$cellwidth}%" bgcolor="#00ffff">
                        <xsl:value-of select="string(' ')"/>
                    </td>
                     <td width="{$cellwidth}%" bgcolor="#ffff00">
                        <xsl:value-of select="string(' ')"/>
                    </td>
               </xsl:if>
                <!-- CHECK to see if gaps in dataset, if so, prepend blank fields -->
				<!-- Blank Col = 2 -->
                <xsl:if test="(($position = (@col - 6)) and (preceding-sibling::*[1]/@col != (@col - 1)) and (preceding-sibling::*[1]/@col != (@col - 2)) and (preceding-sibling::*[1]/@col != (@col - 3)) and (preceding-sibling::*[1]/@col != (@col - 4)) and (preceding-sibling::*[1]/@col != (@col - 5)) and (preceding-sibling::*[1]/@col != (@col - 6)))">
                    <td width="{$cellwidth}%" bgcolor="#ff00ff">
                        <xsl:value-of select="string(' ')"/>
                    </td>
                </xsl:if>
				<!-- Blank Col = 3 -->
                <xsl:if test="(($position = (@col - 6)) and (preceding-sibling::*[1]/@col != (@col - 1)) and (preceding-sibling::*[1]/@col != (@col - 2)) and (preceding-sibling::*[1]/@col != (@col - 3)) and (preceding-sibling::*[1]/@col != (@col - 4)) and (preceding-sibling::*[1]/@col != (@col - 5)))">
                    <td width="{$cellwidth}%" bgcolor="#cc6699">
                        <xsl:value-of select="string(' ')"/>
                    </td>
                </xsl:if>
				<!-- Blank Col = 4 -->
                <xsl:if test="(($position = (@col - 6)) and (preceding-sibling::*[1]/@col != (@col - 1)) and (preceding-sibling::*[1]/@col != (@col - 2)) and (preceding-sibling::*[1]/@col != (@col - 3)) and (preceding-sibling::*[1]/@col != (@col - 4)))">
                    <td width="{$cellwidth}%" bgcolor="#00aa22">
                        <xsl:value-of select="string(' ')"/>
                    </td>
                </xsl:if>
				<!-- Blank Col = 5 -->
                <xsl:if test="(($position = (@col - 6)) and (preceding-sibling::*[1]/@col != (@col - 1)) and (preceding-sibling::*[1]/@col != (@col - 2)) and (preceding-sibling::*[1]/@col != (@col - 3)))">
                    <td width="{$cellwidth}%" bgcolor="#ffff00">
                        <xsl:value-of select="string(' ')"/>
                    </td>
                </xsl:if>
				<!-- Blank Col = 6 -->
                <xsl:if test="(($position = (@col - 6)) and (preceding-sibling::*[1]/@col != (@col - 1)) and (preceding-sibling::*[1]/@col != (@col - 2)))">
                    <td width="{$cellwidth}%" bgcolor="#00ffff">
                        <xsl:value-of select="string(' ')"/>
                    </td>
                </xsl:if>
				<!-- Blank Col = 7 -->
                <xsl:if test="(($position = (@col - 6)) and (preceding-sibling::*[1]/@col != (@col - 1)))">
                    <td width="{$cellwidth}%" bgcolor="#99ff00">
                        <xsl:value-of select="string(' ')"/>
                    </td>
                </xsl:if>
				<!-- Blank Col = 3 -->
                <xsl:if test="(($position = (@col - 5)) and (preceding-sibling::*[1]/@col != (@col - 1)) and (preceding-sibling::*[1]/@col != (@col - 2)) and (preceding-sibling::*[1]/@col != (@col - 3)) and (preceding-sibling::*[1]/@col != (@col - 4)) and (preceding-sibling::*[1]/@col != (@col - 5)))">
                    <td width="{$cellwidth}%" bgcolor="#cc6699">
                        <xsl:value-of select="string(' ')"/>
                    </td>
                </xsl:if>
				<!-- Blank Col = 4 -->
                <xsl:if test="(($position = (@col - 5)) and (preceding-sibling::*[1]/@col != (@col - 1)) and (preceding-sibling::*[1]/@col != (@col - 2)) and (preceding-sibling::*[1]/@col != (@col - 3)) and (preceding-sibling::*[1]/@col != (@col - 4)))">
                    <td width="{$cellwidth}%" bgcolor="#00aa22">
                        <xsl:value-of select="string(' ')"/>
                    </td>
                </xsl:if>
				<!-- Blank Col = 5 -->
                <xsl:if test="(($position = (@col - 5)) and (preceding-sibling::*[1]/@col != (@col - 1)) and (preceding-sibling::*[1]/@col != (@col - 2)) and (preceding-sibling::*[1]/@col != (@col - 3)))">
                    <td width="{$cellwidth}%" bgcolor="#ffff00">
                        <xsl:value-of select="string(' ')"/>
                    </td>
                </xsl:if>
				<!-- Blank Col = 6 -->
                <xsl:if test="(($position = (@col - 5)) and (preceding-sibling::*[1]/@col != (@col - 1)) and (preceding-sibling::*[1]/@col != (@col - 2)))">
                    <td width="{$cellwidth}%" bgcolor="#00ffff">
                        <xsl:value-of select="string(' ')"/>
                    </td>
                </xsl:if>
				<!-- Blank Col = 7 -->
                <xsl:if test="(($position = (@col - 5)) and (preceding-sibling::*[1]/@col != (@col - 1)))">
                    <td width="{$cellwidth}%" bgcolor="#99ff00">
                        <xsl:value-of select="string(' ')"/>
                    </td>
                </xsl:if>
				<!-- Blank Col = 4 -->
                <xsl:if test="(($position = (@col - 4)) and (preceding-sibling::*[1]/@col != (@col - 1)) and (preceding-sibling::*[1]/@col != (@col - 2)) and (preceding-sibling::*[1]/@col != (@col - 3)) and (preceding-sibling::*[1]/@col != (@col - 4)))">
                    <td width="{$cellwidth}%" bgcolor="#00aa22">
                        <xsl:value-of select="string(' ')"/>
                    </td>
                </xsl:if>
				<!-- Blank Col = 5 -->
                <xsl:if test="(($position = (@col - 4)) and (preceding-sibling::*[1]/@col != (@col - 1)) and (preceding-sibling::*[1]/@col != (@col - 2)) and (preceding-sibling::*[1]/@col != (@col - 3)))">
                    <td width="{$cellwidth}%" bgcolor="#ffff00">
                        <xsl:value-of select="string(' ')"/>
                    </td>
                </xsl:if>
				<!-- Blank Col = 6 -->
                <xsl:if test="(($position = (@col - 4)) and (preceding-sibling::*[1]/@col != (@col - 1)) and (preceding-sibling::*[1]/@col != (@col - 2)))">
                    <td width="{$cellwidth}%" bgcolor="#00ffff">
                        <xsl:value-of select="string(' ')"/>
                    </td>
                </xsl:if>
				<!-- Blank Col = 7 -->
                <xsl:if test="(($position = (@col - 4)) and (preceding-sibling::*[1]/@col != (@col - 1)))">
                    <td width="{$cellwidth}%" bgcolor="#99ff00">
                        <xsl:value-of select="string(' ')"/>
                    </td>
                </xsl:if>
				<!-- Blank Col = 5 -->
                <xsl:if test="(($position = (@col - 3)) and (preceding-sibling::*[1]/@col != (@col - 1)) and (preceding-sibling::*[1]/@col != (@col - 2)) and (preceding-sibling::*[1]/@col != (@col - 3)))">
                    <td width="{$cellwidth}%" bgcolor="#ffff00">
                        <xsl:value-of select="string(' ')"/>
                    </td>
                </xsl:if>
				<!-- Blank Col = 6 -->
                <xsl:if test="(($position = (@col - 3)) and (preceding-sibling::*[1]/@col != (@col - 1)) and (preceding-sibling::*[1]/@col != (@col - 2)))">
                    <td width="{$cellwidth}%" bgcolor="#00ffff">
                        <xsl:value-of select="string(' ')"/>
                    </td>
                </xsl:if>
				<!-- Blank Col = 7 -->
                <xsl:if test="(($position = (@col - 3)) and (preceding-sibling::*[1]/@col != (@col - 1)))">
                    <td width="{$cellwidth}%" bgcolor="#99ff00">
                        <xsl:value-of select="string(' ')"/>
                    </td>
                </xsl:if>
				<!-- Blank Col = 6 -->
                <xsl:if test="(($position = (@col - 2)) and (preceding-sibling::*[1]/@col != (@col - 1)) and (preceding-sibling::*[1]/@col != (@col - 2)))">
                    <td width="{$cellwidth}%" bgcolor="#00ffff">
                        <xsl:value-of select="string(' ')"/>
                    </td>
                </xsl:if>
				<!-- Blank Col = 7 -->
                <xsl:if test="(($position = (@col - 2)) and (preceding-sibling::*[1]/@col != (@col - 1)))">
                    <td width="{$cellwidth}%" bgcolor="#99ff00">
                        <xsl:value-of select="string(' ')"/>
                    </td>
                </xsl:if>
				<!-- Blank Col = 7 -->
                <xsl:if test="(($position = (@col - 1)) and (preceding-sibling::*[1]/@col != (@col - 1)))">
                    <td width="{$cellwidth}%" bgcolor="#99ff00">
                        <xsl:value-of select="string(' ')"/>
                    </td>
                </xsl:if>
                <!-- Print data -->
                <!-- Col = 8 -->
                <td width="{$cellwidth}%" bgcolor="#f0f099">
                    <!-- xsl:value-of select="@col"/ -->
                    <!-- xsl:value-of select="concat('position = ', $position, ' col = ', @col, ' last = ', $last, ' ')"/>
                    <xsl:value-of select="concat('preceding position = ', preceding-sibling::*[1]/@col, ' ')"/>
                    <xsl:value-of select="concat('following position = ', following-sibling::*[1]/@col, ' ')"/ -->
                    <xsl:apply-templates/>
                </td>
            </xsl:when>
        </xsl:choose>
    </xsl:template>
    <xsl:template match="page">
        [<xsl:value-of select="@p_id"/>]
    </xsl:template>
    <xsl:template match="note">
        <sup>
            <xsl:value-of select="@print_id"/>
        </sup>
    </xsl:template>
    <xsl:template match="sentence">
        <!-- xsl:variable name="indisentence" select="load-xquery-module('http://www.bcrdb.org/ns/1.0', 
        map {'location-hints' : 'http://www.xqueryfunctions.com/xq/functx-1.0-doc-2007-01.xq' })" / -->
        <!-- xsl:value-of select="actualtext(@id)"/ -->
        <xsl:choose>
            <xsl:when test="@id[contains(., $docID1)]">
                <xsl:variable name="getdoc" select="concat('/db/tibetan/', $lang1, '/', $docID1, '.xml')"/>
                <xsl:variable name="getlang" select="$lang1"/>
                <xsl:variable name="getid" select="@id[contains(., $docID1)]"/>
                <!-- (<xsl:value-of select="$getlang"/>): -->
                <!-- xsl:value-of select="@id"/ -->
                <xsl:variable name="sentID" select="replace(@id, '(\d+\-\d+\-\d+\-[A-Z0-9]+\-SID0*)', '')"/>
                Sent. ID# <xsl:value-of select="$sentID"/>
                <!-- xsl:variable name="realtext" select="doc($getdoc)//phrase/ancestor::sentence[@s_id = $getid]"/ -->
                <xsl:for-each select="doc($getdoc)//phrase/ancestor::sentence[@s_id = $getid]">
                    <xsl:variable name="sname" select="doc($getdoc)//phrase/ancestor::sentence[@s_id = $getid]/@s_name"/>
                    (<xsl:value-of select="@type"/>
                    <xsl:if test="string-length($sname[1]) &gt; 0">
                        <xsl:value-of select="concat(' - ', string($sname[1]))"/>
                    </xsl:if>):
                    <xsl:for-each select="phrase">
                        <!-- br/><xsl:value-of select="node()"/> / -->
                        <br/>
                        <xsl:apply-templates select="node()"/>
                        <xsl:if test="$lang1 = 'BOD'">
                            <xsl:value-of select="' /'"/>
                        </xsl:if>
                        <xsl:if test="$lang1 = 'SKT'">
                            <xsl:value-of select="' |'"/>
                        </xsl:if>
                    </xsl:for-each>
                </xsl:for-each>
            </xsl:when>
            <xsl:when test="@id[contains(., $docID2)]">
                <xsl:variable name="getdoc" select="concat('/db/tibetan/', $lang2, '/', $docID2, '.xml')"/>
                <xsl:variable name="getlang" select="$lang2"/>
                <xsl:variable name="getid" select="@id[contains(., $docID2)]"/>
                <!-- (<xsl:value-of select="$getlang"/>): -->
                <xsl:variable name="sentID" select="replace(@id, '(\d+\-\d+\-\d+\-[A-Z0-9]+\-SID0*)', '')"/>
                Sent. ID# <xsl:value-of select="$sentID"/>
                <!-- xsl:variable name="realtext" select="doc($getdoc)//phrase/ancestor::sentence[@s_id = $getid]"/ -->
                <xsl:for-each select="doc($getdoc)//phrase/ancestor::sentence[@s_id = $getid]">
                    <xsl:variable name="sname" select="doc($getdoc)//phrase/ancestor::sentence[@s_id = $getid]/@s_name"/>
                    (<xsl:value-of select="@type"/>
                    <xsl:if test="string-length($sname[1]) &gt; 0">
                        <xsl:value-of select="concat(' - ', string($sname[1]))"/>
                    </xsl:if>):
                    <xsl:for-each select="phrase">
                        <br/>
                        <xsl:apply-templates select="node()"/>
                        <xsl:if test="$lang2 = 'BOD'">
                            <xsl:value-of select="' /'"/>
                        </xsl:if>
                        <xsl:if test="$lang2 = 'SKT'">
                            <xsl:value-of select="' |'"/>
                        </xsl:if>
                    </xsl:for-each>
                </xsl:for-each>
            </xsl:when>
            <xsl:when test="@id[contains(., $docID3)]">
                <xsl:variable name="getdoc" select="concat('/db/tibetan/', $lang3, '/', $docID3, '.xml')"/>
                <xsl:variable name="getlang" select="$lang3"/>
                <xsl:variable name="getid" select="@id[contains(., $docID3)]"/>
                <!-- (<xsl:value-of select="$getlang"/>): -->
                <xsl:variable name="sentID" select="replace(@id, '(\d+\-\d+\-\d+\-[A-Z0-9]+\-SID0*)', '')"/>
                Sent. ID# <xsl:value-of select="$sentID"/>
                <!-- xsl:variable name="realtext" select="doc($getdoc)//phrase/ancestor::sentence[@s_id = $getid]"/ -->
                <xsl:for-each select="doc($getdoc)//phrase/ancestor::sentence[@s_id = $getid]">
                    <xsl:variable name="sname" select="doc($getdoc)//phrase/ancestor::sentence[@s_id = $getid]/@s_name"/>
                    (<xsl:value-of select="@type"/>
                    <xsl:if test="string-length($sname[1]) &gt; 0">
                        <xsl:value-of select="concat(' - ', string($sname[1]))"/>
                    </xsl:if>):
                    <xsl:for-each select="phrase">
                        <br/>
                        <xsl:apply-templates select="node()"/>
                        <xsl:if test="$lang3 = 'BOD'">
                            <xsl:value-of select="' /'"/>
                        </xsl:if>
                    </xsl:for-each>
                </xsl:for-each>
            </xsl:when>
            <xsl:when test="@id[contains(., $docID4)]">
                <xsl:variable name="getdoc" select="concat('/db/tibetan/', $lang4, '/', $docID4, '.xml')"/>
                <xsl:variable name="getlang" select="$lang4"/>
                <xsl:variable name="getid" select="@id[contains(., $docID4)]"/>
                <!-- (<xsl:value-of select="$getlang"/>): -->
                <xsl:variable name="sentID" select="replace(@id, '(\d+\-\d+\-\d+\-[A-Z0-9]+\-SID0*)', '')"/>
                Sent. ID# <xsl:value-of select="$sentID"/>
                <!-- xsl:variable name="realtext" select="doc($getdoc)//phrase/ancestor::sentence[@s_id = $getid]"/ -->
                <xsl:for-each select="doc($getdoc)//phrase/ancestor::sentence[@s_id = $getid]">
                    <xsl:variable name="sname" select="doc($getdoc)//phrase/ancestor::sentence[@s_id = $getid]/@s_name"/>
                    (<xsl:value-of select="@type"/>
                    <xsl:if test="string-length($sname[1]) &gt; 0">
                        <xsl:value-of select="concat(' - ', string($sname[1]))"/>
                    </xsl:if>):
                    <xsl:for-each select="phrase">
                        <br/>
                        <xsl:apply-templates select="node()"/>
                        <xsl:if test="$lang4 = 'BOD'">
                            <xsl:value-of select="' /'"/>
                        </xsl:if>
                    </xsl:for-each>
                </xsl:for-each>
            </xsl:when>
            <xsl:when test="@id[contains(., $docID5)]">
                <xsl:variable name="getdoc" select="concat('/db/tibetan/', $lang5, '/', $docID5, '.xml')"/>
                <xsl:variable name="getlang" select="$lang5"/>
                <xsl:variable name="getid" select="@id[contains(., $docID5)]"/>
                <!-- (<xsl:value-of select="$getlang"/>): -->
                <xsl:variable name="sentID" select="replace(@id, '(\d+\-\d+\-\d+\-[A-Z0-9]+\-SID0*)', '')"/>
                Sent. ID# <xsl:value-of select="$sentID"/>
                <!-- xsl:variable name="realtext" select="doc($getdoc)//phrase/ancestor::sentence[@s_id = $getid]"/ -->
                <xsl:for-each select="doc($getdoc)//phrase/ancestor::sentence[@s_id = $getid]">
                    <xsl:variable name="sname" select="doc($getdoc)//phrase/ancestor::sentence[@s_id = $getid]/@s_name"/>
                    (<xsl:value-of select="@type"/>
                    <xsl:if test="string-length($sname[1]) &gt; 0">
                        <xsl:value-of select="concat(' - ', string($sname[1]))"/>
                    </xsl:if>):
                    <xsl:for-each select="phrase">
                        <br/>
                        <xsl:apply-templates select="node()"/>
                        <xsl:if test="$lang5 = 'BOD'">
                            <xsl:value-of select="' /'"/>
                        </xsl:if>
                    </xsl:for-each>
                </xsl:for-each>
            </xsl:when>
            <xsl:when test="@id[contains(., $docID6)]">
                <xsl:variable name="getdoc" select="concat('/db/tibetan/', $lang6, '/', $docID6, '.xml')"/>
                <xsl:variable name="getlang" select="$lang6"/>
                <xsl:variable name="getid" select="@id[contains(., $docID6)]"/>
                <!-- (<xsl:value-of select="$getlang"/>): -->
                <xsl:variable name="sentID" select="replace(@id, '(\d+\-\d+\-\d+\-[A-Z0-9]+\-SID0*)', '')"/>
                Sent. ID# <xsl:value-of select="$sentID"/>
                <!-- xsl:variable name="realtext" select="doc($getdoc)//phrase/ancestor::sentence[@s_id = $getid]"/ -->
                <xsl:for-each select="doc($getdoc)//phrase/ancestor::sentence[@s_id = $getid]">
                    <xsl:variable name="sname" select="doc($getdoc)//phrase/ancestor::sentence[@s_id = $getid]/@s_name"/>
                    (<xsl:value-of select="@type"/>
                    <xsl:if test="string-length($sname[1]) &gt; 0">
                        <xsl:value-of select="concat(' - ', string($sname[1]))"/>
                    </xsl:if>):
                    <xsl:for-each select="phrase">
                        <br/>
                        <xsl:apply-templates select="node()"/>
                        <xsl:if test="$lang6 = 'BOD'">
                            <xsl:value-of select="' /'"/>
                        </xsl:if>
                    </xsl:for-each>
                </xsl:for-each>
            </xsl:when>
            <xsl:when test="@id[contains(., $docID7)]">
                <xsl:variable name="getdoc" select="concat('/db/tibetan/', $lang7, '/', $docID7, '.xml')"/>
                <xsl:variable name="getlang" select="$lang7"/>
                <xsl:variable name="getid" select="@id[contains(., $docID7)]"/>
                <!-- (<xsl:value-of select="$getlang"/>): -->
                <xsl:variable name="sentID" select="replace(@id, '(\d+\-\d+\-\d+\-[A-Z0-9]+\-SID0*)', '')"/>
                Sent. ID# <xsl:value-of select="$sentID"/>
                <!-- xsl:variable name="realtext" select="doc($getdoc)//phrase/ancestor::sentence[@s_id = $getid]"/ -->
                <xsl:for-each select="doc($getdoc)//phrase/ancestor::sentence[@s_id = $getid]">
                    <xsl:variable name="sname" select="doc($getdoc)//phrase/ancestor::sentence[@s_id = $getid]/@s_name"/>
                    (<xsl:value-of select="@type"/>
                    <xsl:if test="string-length($sname[1]) &gt; 0">
                        <xsl:value-of select="concat(' - ', string($sname[1]))"/>
                    </xsl:if>):
                    <xsl:for-each select="phrase">
                        <br/>
                        <xsl:apply-templates select="node()"/>
                        <xsl:if test="$lang7 = 'BOD'">
                            <xsl:value-of select="' /'"/>
                        </xsl:if>
                    </xsl:for-each>
                </xsl:for-each>
            </xsl:when>
            <xsl:when test="@id[contains(., $docID8)]">
                <xsl:variable name="getdoc" select="concat('/db/tibetan/', $lang8, '/', $docID8, '.xml')"/>
                <xsl:variable name="getlang" select="$lang8"/>
                <xsl:variable name="getid" select="@id[contains(., $docID8)]"/>
                <!-- (<xsl:value-of select="$getlang"/>): -->
                <xsl:variable name="sentID" select="replace(@id, '(\d+\-\d+\-\d+\-[A-Z0-9]+\-SID0*)', '')"/>
                Sent. ID# <xsl:value-of select="$sentID"/>
                <!-- xsl:variable name="realtext" select="doc($getdoc)//phrase/ancestor::sentence[@s_id = $getid]"/ -->
                <xsl:for-each select="doc($getdoc)//phrase/ancestor::sentence[@s_id = $getid]">
                    <xsl:variable name="sname" select="doc($getdoc)//phrase/ancestor::sentence[@s_id = $getid]/@s_name"/>
                    (<xsl:value-of select="@type"/>
                    <xsl:if test="string-length($sname[1]) &gt; 0">
                        <xsl:value-of select="concat(' - ', string($sname[1]))"/>
                    </xsl:if>):
                    <xsl:for-each select="phrase">
                        <br/>
                        <xsl:apply-templates select="node()"/>
                        <xsl:if test="$lang8 = 'BOD'">
                            <xsl:value-of select="' /'"/>
                        </xsl:if>
                    </xsl:for-each>
                </xsl:for-each>
            </xsl:when>
        </xsl:choose>
        <br/>
    </xsl:template>
    <xsl:template match="phrase">
        <br/>
        <xsl:apply-templates/>
    </xsl:template>
</xsl:stylesheet>