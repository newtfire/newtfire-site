<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:math="http://www.w3.org/2005/xpath-functions/math"
    exclude-result-prefixes="xs math" xmlns="http://www.w3.org/1999/xhtml"
    version="3.0">
    
    <xsl:output method="xhtml" html-version="5" omit-xml-declaration="yes" 
        include-content-type="no" indent="yes"/>
    
    <xsl:template match="/">
        <html>
            <head>
                <title>Skyrim</title>
                <link/>
            </head>
            <body>
                
                <xsl:apply-templates select="descendant::cover"/>
                
                <xsl:apply-templates select="descendant::body"/>
                
                
            </body>
  
        </html>
        
    </xsl:template>
    
    <xsl:template match="title">
        <h1><xsl:apply-templates/></h1>
    </xsl:template>
    <xsl:template match="attribution">
        <p><xsl:apply-templates/></p>
    </xsl:template>
    <xsl:template match="subtitle"><p><xsl:apply-templates/></p></xsl:template>
    
    <xsl:template match="paragraph">
        <p><xsl:apply-templates/></p>
    </xsl:template>
    <xsl:template match="faction">
        <span class="{preceding::faction[@id = current()/@ref]/@alignment}"><xsl:apply-templates/></span>
    </xsl:template>
    
    
</xsl:stylesheet>