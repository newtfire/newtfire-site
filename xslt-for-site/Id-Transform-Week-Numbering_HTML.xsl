<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:math="http://www.w3.org/2005/xpath-functions/math" 
    exclude-result-prefixes="xs math"
version="3.0">
 <!--ebb: This adds week numbers to the schedule template for a given semester. Updated in August 2018 to work on table elements rather than divs. -->   
    <xsl:mode on-no-match="shallow-copy"/>
    
    <xsl:template match="table">
        
        <table>
            <tr>
                <th id="Week{count(preceding::table) + 1}">Week <xsl:sequence select="count(preceding::table) + 1"/></th>
                <th><span class="h4"><em>Class topics</em></span></th>
                
                <th><span class="h4"><em>Due next time</em></span></th>
            
            </tr>
            <xsl:apply-templates/>
        
        </table>
    </xsl:template>
 
 <xsl:template match="td[not(* | text())]">
     
     <td class="{@class}"><xsl:text>...</xsl:text></td>
 </xsl:template>
    
</xsl:stylesheet>
    
