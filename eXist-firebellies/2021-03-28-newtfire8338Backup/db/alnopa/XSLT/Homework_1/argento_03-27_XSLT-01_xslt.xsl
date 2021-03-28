<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="xs" version="3.0">

    <xsl:mode on-no-match="shallow-copy"/>
    <xsl:template match="title[ancestor::body]">
        <twinkie credit="{following-sibling::credit}">
            <xsl:apply-templates/>
        </twinkie>
    </xsl:template>

</xsl:stylesheet>