<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    version="2.0">
    <xsl:output indent="yes"/>
    
    <xsl:template match="TechNews">
        <xsl:for-each-group select="article" group-by="issueUID">
            <xsl:copy>
                <issue>
                    <xsl:attribute name="issueId" select="current-grouping-key()"/>
                    <xsl:apply-templates select="current-group()/*"/>
                </issue>
            </xsl:copy>
        </xsl:for-each-group>
    </xsl:template>
    
<xsl:template match="issueUID"></xsl:template>
    
<xsl:template match="node() | @*">
    <xsl:copy>
        <xsl:apply-templates select="node() | @*"/>
    </xsl:copy>
</xsl:template>

    <xsl:template match="ArticleTitle">
        <titleInfo>
            <title>
                <xsl:value-of select="normalize-space(.)"/>
            </title>
        </titleInfo>
    </xsl:template>
    
</xsl:stylesheet>
