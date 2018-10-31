<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:xlink="http://www.w3.org/1999/xlink"
    version="2.0">
    
    <!-- Only to be used with ETDs with NO Proquest XML attachment -->
    
    <!-- This transform moves subject values to description fields to create a new Dublin Core XML. -->
    <!-- This mapping takes place only if a subject term begins with degree information. Otherwise it leaves it in subject. -->
   
    <xsl:output method="xml" indent="yes" encoding="UTF-8"/>
    
    <xsl:template match="@*|node()">
        <xsl:copy>
            <xsl:apply-templates select="@*|node()"/>
        </xsl:copy>
    </xsl:template>
    <xsl:template match="dublin_core">
        <dublin_core schema="dc">
            
            <xsl:copy-of select="dcvalue[@element='title']"/>
            <xsl:copy-of select="dcvalue[@element='contributor']"/> 
            <xsl:copy-of select="dcvalue[@element='date']"/>           
            <xsl:copy-of select="dcvalue[@element='identifier']"/>          
            <xsl:copy-of select="dcvalue[@element='type']"/>
            <xsl:copy-of select="dcvalue[@element='language']"/>
            <xsl:copy-of select="dcvalue[@element='publisher']"/>
            <xsl:copy-of select="dcvalue[@element='format']"/>
            <xsl:copy-of select="dcvalue[@element='rights']"/>
            <xsl:copy-of select="dcvalue[@element='relation']"/>
            <xsl:copy-of select="dcvalue[@element='description']"/>
            
            <xsl:for-each select="dcvalue[@element='subject']">
                <xsl:variable name="subjectTerm" select="."/>
                <!-- Tests if subject begins with degree information, moves to description field if true -->
                <xsl:choose>
                    <xsl:when test="not(starts-with($subjectTerm, 'M.S.') or starts-with($subjectTerm, 'Ph.D') or starts-with($subjectTerm, 'PH.D') or starts-with($subjectTerm, 'M.Arch'))">
                        <dcvalue element="subject" qualifier="none" language="en_US">
                            <xsl:value-of select="$subjectTerm"/>
                        </dcvalue>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:element name="dcvalue">
                            <xsl:attribute name="element">description</xsl:attribute>
                            <xsl:attribute name="qualifier">none</xsl:attribute>
                            <xsl:attribute name="language">en_US</xsl:attribute>
                            <xsl:value-of select="$subjectTerm"/>
                        </xsl:element>
                    </xsl:otherwise>
                </xsl:choose>    
            </xsl:for-each>
        </dublin_core>
    </xsl:template>
</xsl:stylesheet>