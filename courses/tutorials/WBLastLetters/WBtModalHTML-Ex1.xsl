<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="3.0"
    xmlns="http://www.w3.org/1999/xhtml">
    
    <xsl:output method="xhtml" html-version="5" omit-xml-declaration="yes" 
        include-content-type="no" indent="yes"/>
    
    <xsl:variable name="WBColl" select="collection('XML/?select=*.xml')"/>   
    
    <xsl:template match="/">
        <html>
            <head>
                <title>Warren Behrend’s Last Correspondence and Memorial</title>
                <link rel="stylesheet" type="text/css" href="style.css"/>
            </head>
            <body>
                <h1>Warren Behrend’s Last Correspondence and Memorial</h1>
                
                <section id="toc">
                    <h2>Contents</h2>
                    <ul>
                        <xsl:apply-templates select="$WBColl//xml" mode="toc">
                          <!--  <xsl:sort select="descendant::date[1]"/>-->
                        </xsl:apply-templates>
                    </ul>
                </section>
                <section id="fulltext">
                    <xsl:apply-templates select="$WBColl//xml"/>
                </section>
  
            </body>
        </html>
    </xsl:template>
    
    <!--Templates in toc mode for the table of contents -->
    <xsl:template match="xml" mode="toc">
        <li><xsl:apply-templates select="descendant::title" mode="toc"/></li>
    </xsl:template>
    

    
    <!--Normal templates for fulltext view -->
    <xsl:template match="xml">
        <section class="doc" id="{descendant::title/@xml:id}">
            <div class="facsimile"><xsl:apply-templates select="descendant::graphic"/></div>
            <div class="text">
                <h2><xsl:apply-templates select="descendant::title"/></h2>
            <xsl:apply-templates select="child::body"/>
            </div>
          
        </section>
    </xsl:template>
    
    <xsl:template match="graphic">
       <figure>
           <img src="{substring-after(@src, '../')}" alt="{@alt}"/>
           <figcaption><xsl:value-of select="@alt"/></figcaption>
       </figure>
    </xsl:template>
    
    <xsl:template match="body">
        <xsl:apply-templates/>
        
    </xsl:template>
    
    <xsl:template match="header">
        <div class="header">
            <xsl:apply-templates/>
        </div>
    </xsl:template>
    
    <xsl:template match="header/date">
        <div class="date"><xsl:apply-templates/></div>
    </xsl:template>
    <xsl:template match="greeting">
        <div class="greeting"><xsl:apply-templates/></div>
    </xsl:template>
    
    <xsl:template match="p">
        <p><xsl:apply-templates/></p>
    </xsl:template>
    <xsl:template match="closer">
        <div class="closer">
            <xsl:apply-templates/>
        </div>
    </xsl:template>
    <xsl:template match="p/ln | closer/ln">
       <xsl:if test="not(current()/@n='1')"> <br/></xsl:if>
        <span class="lineNum"><xsl:value-of select="count(preceding::ln[parent::p or parent::closer]) + 1"/></span>
        <xsl:text>  </xsl:text>
        
    </xsl:template>
    <xsl:template match="fw">
    </xsl:template>
    
    

    
</xsl:stylesheet>