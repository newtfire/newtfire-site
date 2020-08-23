<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:math="http://www.w3.org/2005/xpath-functions/math" exclude-result-prefixes="xs math"
    xpath-default-namespace="http://www.w3.org/1999/xhtml"
    xmlns="http://www.w3.org/1999/xhtml" version="3.0">
    
    <xsl:mode on-no-match="shallow-copy"/>
    
 <xsl:template match="table[not(descendant::th/@id='Week17')]/tr[1]">
     <tr><xsl:copy-of select="th[1]"/>
     <th><span class="h4">Topics</span></th>
     <th><span class="h4">Do before class</span></th>
     <th><span class="h4">Group A</span></th>
     <th><span class="h4">Group B</span></th></tr>
 </xsl:template>
        
        <xsl:template match="tr[@id][not(preceding::th/@id='Week17')]">
           <tr id="{@id}"> 
               <xsl:copy-of select="td[h4]"/>
               <td class="topic">...</td>
               <td class="doBeforeClass">...</td>
               <td class="GroupA">...</td>
               <td class="GroupB">...</td>

           </tr>
    </xsl:template>
    
    
</xsl:stylesheet>
    
