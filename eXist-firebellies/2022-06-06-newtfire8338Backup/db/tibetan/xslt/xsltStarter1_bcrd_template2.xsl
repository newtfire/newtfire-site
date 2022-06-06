<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns="http://www.w3.org/1999/xhtml" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema" xpath-default-namespace="http://www.bcrdb.org/ns/1.0" exclude-result-prefixes="xs" version="3.0">
    <xsl:output method="xhtml" indent="yes" doctype-system="about:legacy-compat" omit-xml-declaration="yes"/>

<!--ebb: We will write templates rules here. -->
    <xsl:template match="/">
                <xsl:apply-templates select="descendant::text"/>
    </xsl:template>
    <!-- xsl:template mode="header" match="text/sentence/phrase[ancestor::sentence/@type eq 'Text Title']">
        <xsl:apply-templates/>
    </xsl:template -->
    <xsl:template match="text/sentence/phrase[ancestor::sentence/@type eq 'Text Title']">
        <h3>
            <xsl:apply-templates/> /
        </h3>
    </xsl:template>
    <xsl:template match="text/sentence/phrase[ancestor::sentence/@type eq 'Paragraph']">
        <p>
            <xsl:apply-templates/> /
        </p>
    </xsl:template>
    <xsl:template match="text/sentence/phrase[ancestor::sentence/@type eq 'Sentence']">
        <p>
            <xsl:apply-templates/> /
        </p>
    </xsl:template>
    <xsl:template match="text/sentence[@type eq 'Verse']">
        <ul style="list-style-type:none">
            <xsl:value-of select="@s_name"/><xsl:apply-templates/>
        </ul>
    </xsl:template>
    <xsl:template match="text/sentence/phrase[ancestor::sentence/@type eq 'Verse']">
        <li>
            <xsl:apply-templates/> /
        </li>
    </xsl:template>
    <xsl:template match="text/sentence/phrase[ancestor::sentence/@type eq 'Mantra']">
        <p>
            <xsl:apply-templates/> /
        </p>
    </xsl:template>
    <xsl:template match="text/sentence/phrase[ancestor::sentence/@type eq 'Text Colophon']">
        <p>
            <xsl:apply-templates/> //
        </p>
    </xsl:template>
    <xsl:template match="page">
        [<xsl:value-of select="@p_id"/>]
    </xsl:template>
</xsl:stylesheet>