<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:xlink="http://www.w3.org/1999/xlink" xmlns:mods="http://www.loc.gov/mods/v3"
    version="2.0">
    
    <!-- This template adds elements from metadata_iit.xml from DSpace to MODS records -->
    
    <xsl:output method="xml" indent="yes" encoding="UTF-8"/>
    
    <xsl:template match="@*|node()">
        <xsl:copy>
            <xsl:apply-templates select="@*|node()"/>
        </xsl:copy>
    </xsl:template>  
    <xsl:template match="/mods:mods">
        <mods version="3.7" xmlns="http://www.loc.gov/mods/v3" 
            xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" 
            xsi:schemaLocation="http://www.loc.gov/mods/v3 http://www.loc.gov/standards/mods/v3/mods-3-7.xsd">
            
            <xsl:copy-of select="*" copy-namespaces="no"/>
            
            <xsl:for-each select="document('metadata_iit.xml')/dublin_core/dcvalue[@element='type']">
                <xsl:choose>
                    <xsl:when test="string(text()) = '3-D Rendering'">
                        <typeOfResource authority="coar" valueURI="http://purl.org/coar/resource_type/c_ecc8">
                            <xsl:text>Still image</xsl:text>
                        </typeOfResource>
                    </xsl:when>
                    <xsl:when test="string(text()) = 'Charts'">
                        <typeOfResource authority="gmgpg" valueURI="http://id.loc.gov/vocabulary/graphicMaterials/tgm001907">
                            <xsl:text>Chart</xsl:text>
                        </typeOfResource>
                    </xsl:when>
                    <xsl:when test="string(text()) = 'Details'">
                        <typeOfResource authority="gmgpg" valueURI="http://id.loc.gov/vocabulary/graphicMaterials/tgm003035">
                            <xsl:text>Detail</xsl:text>
                        </typeOfResource>
                    </xsl:when>
                    <xsl:when test="string(text()) = 'Elevations'">
                        <typeOfResource authority="gmgpg" valueURI="http://id.loc.gov/vocabulary/graphicMaterials/tgm003539">
                            <xsl:text>Elevation</xsl:text>
                        </typeOfResource>
                    </xsl:when>
                    <xsl:when test="string(text()) = 'Graphs'">
                        <typeOfResource authority="gmgpg" valueURI="http://id.loc.gov/vocabulary/graphicMaterials/tgm004702">
                            <xsl:text>Graph</xsl:text>
                        </typeOfResource>
                    </xsl:when>
                    <xsl:when test="string(text()) = 'Image, Moving'">
                        <typeOfResource authority="coar" valueURI="http://purl.org/coar/resource_type/c_8a7e">
                            <xsl:text>Moving image</xsl:text>
                        </typeOfResource>
                    </xsl:when>
                    <xsl:when test="string(text()) = 'Maps'">
                        <typeOfResource authority="lcgft" valueURI="http://id.loc.gov/authorities/genreForms/gf2011026113">
                            <xsl:text>Cartographic material</xsl:text>
                        </typeOfResource>
                    </xsl:when>
                    <xsl:when test="string(text()) = 'Models'">
                        <typeOfResource authority="gmgpg" valueURI="http://id.loc.gov/vocabulary/graphicMaterials/tgm000461">
                            <xsl:text>Architectural model</xsl:text>
                        </typeOfResource>
                    </xsl:when>
                    <xsl:when test="string(text()) = 'Photographs'">
                        <typeOfResource authority="coar" valueURI="http://purl.org/coar/resource_type/c_ecc8">
                            <xsl:text>Still image</xsl:text>
                        </typeOfResource>
                        <physicalDescription>
                            <form authority="aat" valueURI="http://vocab.getty.edu/page/aat/300046300">Photographs</form>
                        </physicalDescription>
                    </xsl:when>
                    <xsl:when test="string(text()) = 'Plans'">
                        <typeOfResource authority="gmgpg" valueURI="http://id.loc.gov/vocabulary/graphicMaterials/tgm007871">
                            <xsl:text>Plan</xsl:text>
                        </typeOfResource>
                    </xsl:when>
                    <xsl:when test="string(text()) = 'Section'">
                        <typeOfResource authority="gmgpg" valueURI="http://id.loc.gov/vocabulary/graphicMaterials/tgm009349">
                            <xsl:text>Section</xsl:text>
                        </typeOfResource>
                    </xsl:when>
                    <xsl:when test="string(text()) = 'Site Plans'">
                        <typeOfResource authority="gmgpg" valueURI="http://id.loc.gov/vtrackocabulary/graphicMaterials/tgm009663">
                            <xsl:text>Site plan</xsl:text>
                        </typeOfResource>
                    </xsl:when>
                    <xsl:otherwise>
                        <typeOfResource>                                                       
                            <xsl:value-of select="."/>
                        </typeOfResource>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:for-each>
            <xsl:for-each select="document('metadata_iit.xml')/dublin_core/dcvalue[@element='ipro']">
                <note type="ipro">
                    <xsl:apply-templates/>
                </note>
            </xsl:for-each> 
            <xsl:variable name="deptname" select="document('metadata_iit.xml')/dublin_core/dcvalue[@element='department']"/>
            <name type="corporate">        
                <xsl:choose>
                    <xsl:when test="$deptname = 'ARCH / College of Architecture'">
                        <namePart>ARCH / Architecture</namePart>
                    </xsl:when>
                    <xsl:when test="$deptname = 'Libraries and Archives'">
                        <namePart>Illinois Tech Libraries</namePart>
                    </xsl:when>
                    <xsl:when test="$deptname = 'INTM / Industrial Technology and Management'">
                        <namePart>SAT / School of Applied Technology</namePart>
                    </xsl:when>
                    <xsl:when test="$deptname = 'ITM / Information Technology and Management'">
                        <namePart>SAT / School of Applied Technology</namePart>
                    </xsl:when>
                    <xsl:when test="$deptname = 'SOC / Social Sciences'">
                        <namePart>SSCI / Social Sciences</namePart>
                    </xsl:when>
                    <xsl:when test="$deptname = 'other'">
                        <namePart>Other</namePart>
                    </xsl:when>
                    <xsl:otherwise>
                        <namePart><xsl:value-of select= "$deptname"/></namePart>
                    </xsl:otherwise>
                </xsl:choose>               
                <affiliation>Illinois Institute of Technology</affiliation>
                <role>
                    <roleTerm type="text">Affiliated department</roleTerm>
                </role>
            </name>                  
        </mods>
    </xsl:template>
</xsl:stylesheet>

