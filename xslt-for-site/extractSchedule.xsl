<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:math="http://www.w3.org/2005/xpath-functions/math" exclude-result-prefixes="xs math"
    xpath-default-namespace="http://www.w3.org/1999/xhtml"
    xmlns="http://www.w3.org/1999/xhtml" version="3.0">
    
    <xsl:mode on-no-match="shallow-copy"/>
    
<xsl:template match="/">
    <xsl:apply-templates select="//div[@id='schedule']"/>
</xsl:template>
    
    
    
</xsl:stylesheet>
    
