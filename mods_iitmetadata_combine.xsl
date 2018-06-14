<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:mods="http://www.loc.gov/mods/v3"
    version="2.0">
    
    <xsl:output method="xml" indent="yes" encoding="UTF-8"/>
    
    <xsl:template match="@*|node()">
        <xsl:copy>
            <xsl:apply-templates select="@*|node()"/>
        </xsl:copy>
    </xsl:template>  
    <xsl:template match="/mods:mods">
        <mods version="3.4" xmlns="http://www.loc.gov/mods/v3" 
            xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" 
            xsi:schemaLocation="http://www.loc.gov/mods/v3 http://www.loc.gov/standards/mods/v3/mods-3-4.xsd"> 
            <xsl:copy-of select="*" copy-namespaces="no"/>
            <xsl:for-each select="document('metadata_iit.xml')/dublin_core/dcvalue[@element='type']">
                <genre>
                    <xsl:apply-templates/>
                </genre>
            </xsl:for-each>
            <xsl:for-each select="document('metadata_iit.xml')/dublin_core/dcvalue[@element='ipro']">
                <note type="track">
                    <xsl:text>IPRO track: </xsl:text>
                    <xsl:apply-templates/>
                </note>
            </xsl:for-each> 
            <name type="corporate">               
                <namePart><xsl:value-of select="document('metadata_iit.xml')/dublin_core/dcvalue[@element='department']"/></namePart>
                <affiliation>Illinois Institute of Technology</affiliation>
                <role>
                    <roleTerm type="text">Affiliated department</roleTerm>
                </role>
            </name>                  
        </mods>
    </xsl:template>
</xsl:stylesheet>