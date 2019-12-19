<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:dc="http://purl.org/dc/elements/1.1/" xmlns:sru_dc="info:srw/schema/1/dc-schema"
    xmlns:oai_dc="http://www.openarchives.org/OAI/2.0/oai_dc/"
    xmlns:xlink="http://www.w3.org/1999/xlink" xmlns="http://www.loc.gov/mods/v3"
    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" exclude-result-prefixes="sru_dc oai_dc dc"
    version="2.0">

    <xsl:strip-space elements="*"/>
    <xsl:output indent="yes"/>


    <xsl:template match="issue">
        <mods xmlns="http://www.loc.gov/mods/v3"
            xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
            xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:xlink="http://www.w3.org/1999/xlink"
            xmlns:mods="http://www.loc.gov/mods/v3" version="3.7"
            xsi:schemaLocation="http://www.loc.gov/mods/v3 http://www.loc.gov/standards/mods/v3/mods-3-7.xsd">
            <xsl:apply-templates/>

            <xsl:choose>
                <xsl:when test="VolumeNo[1] &lt; 111">
                    <identifier type="local">
                        <xsl:text>0271002-</xsl:text>
                        <xsl:value-of select="issueUID[1]"/>
                    </identifier>
                    <relatedItem type="host" displayLabel="Collection">
                        <titleInfo>
                            <title>
                                <xsl:text>Technology News Microfilm collection, 1928-1981</xsl:text>
                            </title>
                        </titleInfo>
                        <location>
                            <physicalLocation>
                                <xsl:text>027.10.02, Technology News Microfilm collection, 1928-1981, University Archives and Special Collections, Paul V. Galvin Library, Illinois Institute of Technology.</xsl:text>
                            </physicalLocation>
                        </location>
                    </relatedItem>
                    <relatedItem type="host">
                        <location>
                            <url note="Finding Aid">
                                <xsl:text>http://findingaids.archives.iit.edu/repositories/2/resources/1826</xsl:text>
                            </url>
                        </location>
                    </relatedItem>
                    <physicalDescription>
                        <form>
                            <xsl:text>microfilm</xsl:text>
                        </form>
                    </physicalDescription>
                </xsl:when>
                <xsl:otherwise>
                    <identifier type="local">
                        <xsl:text>0271001-</xsl:text>
                        <xsl:value-of select="issueUID[1]"/>
                    </identifier>
                    <relatedItem type="host" displayLabel="Collection">
                        <titleInfo>
                            <title>
                                <xsl:text>Technology News print collection, 1940-2019</xsl:text>
                            </title>
                        </titleInfo>
                        <location>
                            <physicalLocation>
                                <xsl:text>027.10.01, Technology News print collection, 1940-2019, University Archives and Special Collections, Paul V. Galvin Library, Illinois Institute of Technology.</xsl:text>
                            </physicalLocation>
                        </location>
                    </relatedItem>
                    <relatedItem type="host">
                    <location>
                        <url note="Finding Aid">
                            <xsl:text>http://findingaids.archives.iit.edu/repositories/2/resources/2314</xsl:text>
                        </url>
                    </location>
                    </relatedItem>
                </xsl:otherwise>
            </xsl:choose>

            <xsl:choose>
                <xsl:when test="VolumeNo[1] &gt; 110 and VolumeNo[1] &lt; 155">
                    <physicalDescription>
                        <form>
                            <xsl:text>newspaper</xsl:text>
                        </form>
                    </physicalDescription>              
                </xsl:when>
            </xsl:choose>

            <xsl:choose>
                <xsl:when test="VolumeNo[1] &lt; 155">
                    <physicalDescription>
                        <digitalOrigin>
                            <xsl:text>digitized microfilm</xsl:text>
                        </digitalOrigin>
                    </physicalDescription>
                </xsl:when>
                <xsl:otherwise>
                    <physicalDescription>
                        <digitalOrigin>
                            <xsl:text>born digital</xsl:text>
                        </digitalOrigin>
                    </physicalDescription>
                </xsl:otherwise>
            </xsl:choose>
        
            <xsl:choose>
                <xsl:when test="VolumeNo[1] &lt; 26 ">
                    <titleInfo>
                        <title>
                            <xsl:text>Armour Tech News</xsl:text>
                            <xsl:text>, </xsl:text>
                            <xsl:choose>
                                <xsl:when test="contains(Date[1], '-01-')">
                                    <xsl:text>January </xsl:text>
                                    <xsl:value-of select="substring(Date[1],9,10)"/>
                                    <xsl:text>, </xsl:text>
                                    <xsl:value-of select="substring(Date[1],1,4)"/>
                                </xsl:when>
                                <xsl:when test="contains(Date[1], '-02-')">
                                    <xsl:text>February </xsl:text>
                                    <xsl:value-of select="substring(Date[1],9,10)"/>
                                    <xsl:text>, </xsl:text>
                                    <xsl:value-of select="substring(Date[1],1,4)"/>
                                </xsl:when>
                                <xsl:when test="contains(Date[1], '-03-')">
                                    <xsl:text>March </xsl:text>
                                    <xsl:value-of select="substring(Date[1],9,10)"/>
                                    <xsl:text>, </xsl:text>
                                    <xsl:value-of select="substring(Date[1],1,4)"/>
                                </xsl:when>
                                <xsl:when test="contains(Date[1], '-04-')">
                                    <xsl:text>April </xsl:text>
                                    <xsl:value-of select="substring(Date[1],9,10)"/>
                                    <xsl:text>, </xsl:text>
                                    <xsl:value-of select="substring(Date[1],1,4)"/>
                                </xsl:when>
                                <xsl:when test="contains(Date[1], '-05-')">
                                    <xsl:text>May </xsl:text>
                                    <xsl:value-of select="substring(Date[1],9,10)"/>
                                    <xsl:text>, </xsl:text>
                                    <xsl:value-of select="substring(Date[1],1,4)"/>
                                </xsl:when>
                                <xsl:when test="contains(Date[1], '-06-')">
                                    <xsl:text>June </xsl:text>
                                    <xsl:value-of select="substring(Date[1],9,10)"/>
                                    <xsl:text>, </xsl:text>
                                    <xsl:value-of select="substring(Date[1],1,4)"/>
                                </xsl:when>
                                <xsl:when test="contains(Date[1], '-07-')">
                                    <xsl:text>July </xsl:text>
                                    <xsl:value-of select="substring(Date[1],9,10)"/>
                                    <xsl:text>, </xsl:text>
                                    <xsl:value-of select="substring(Date[1],1,4)"/>
                                </xsl:when>
                                <xsl:when test="contains(Date[1], '-08-')">
                                    <xsl:text>August </xsl:text>
                                    <xsl:value-of select="substring(Date[1],9,10)"/>
                                    <xsl:text>, </xsl:text>
                                    <xsl:value-of select="substring(Date[1],1,4)"/>
                                </xsl:when>
                                <xsl:when test="contains(Date[1], '-09-')">
                                    <xsl:text>September </xsl:text>
                                    <xsl:value-of select="substring(Date[1],9,10)"/>
                                    <xsl:text>, </xsl:text>
                                    <xsl:value-of select="substring(Date[1],1,4)"/>
                                </xsl:when>
                                <xsl:when test="contains(Date[1], '-10-')">
                                    <xsl:text>October </xsl:text>
                                    <xsl:value-of select="substring(Date[1],9,10)"/>
                                    <xsl:text>, </xsl:text>
                                    <xsl:value-of select="substring(Date[1],1,4)"/>
                                </xsl:when>
                                <xsl:when test="contains(Date[1], '-11-')">
                                    <xsl:text>November </xsl:text>
                                    <xsl:value-of select="substring(Date[1],9,10)"/>
                                    <xsl:text>, </xsl:text>
                                    <xsl:value-of select="substring(Date[1],1,4)"/>
                                </xsl:when>
                                <xsl:when test="contains(Date[1], '-12-')">
                                    <xsl:text>December </xsl:text>
                                    <xsl:value-of select="substring(Date[1],9,10)"/>
                                    <xsl:text>, </xsl:text>
                                    <xsl:value-of select="substring(Date[1],1,4)"/>
                                </xsl:when>
                            </xsl:choose>
                        </title>
                    </titleInfo>
                </xsl:when>
                <xsl:when test="VolumeNo[1] &lt; 145">
                    <titleInfo>
                        <title>
                            <xsl:text>Technology News</xsl:text>
                            <xsl:text>, </xsl:text>
                            <xsl:choose>
                                <xsl:when test="contains(Date[1], '-01-')">
                                    <xsl:text>January </xsl:text>
                                    <xsl:value-of select="substring(Date[1],9,10)"/>
                                    <xsl:text>, </xsl:text>
                                    <xsl:value-of select="substring(Date[1],1,4)"/>
                                </xsl:when>
                                <xsl:when test="contains(Date[1], '-02-')">
                                    <xsl:text>February </xsl:text>
                                    <xsl:value-of select="substring(Date[1],9,10)"/>
                                    <xsl:text>, </xsl:text>
                                    <xsl:value-of select="substring(Date[1],1,4)"/>
                                </xsl:when>
                                <xsl:when test="contains(Date[1], '-03-')">
                                    <xsl:text>March </xsl:text>
                                    <xsl:value-of select="substring(Date[1],9,10)"/>
                                    <xsl:text>, </xsl:text>
                                    <xsl:value-of select="substring(Date[1],1,4)"/>
                                </xsl:when>
                                <xsl:when test="contains(Date[1], '-04-')">
                                    <xsl:text>April </xsl:text>
                                    <xsl:value-of select="substring(Date[1],9,10)"/>
                                    <xsl:text>, </xsl:text>
                                    <xsl:value-of select="substring(Date[1],1,4)"/>
                                </xsl:when>
                                <xsl:when test="contains(Date[1], '-05-')">
                                    <xsl:text>May </xsl:text>
                                    <xsl:value-of select="substring(Date[1],9,10)"/>
                                    <xsl:text>, </xsl:text>
                                    <xsl:value-of select="substring(Date[1],1,4)"/>
                                </xsl:when>
                                <xsl:when test="contains(Date[1], '-06-')">
                                    <xsl:text>June </xsl:text>
                                    <xsl:value-of select="substring(Date[1],9,10)"/>
                                    <xsl:text>, </xsl:text>
                                    <xsl:value-of select="substring(Date[1],1,4)"/>
                                </xsl:when>
                                <xsl:when test="contains(Date[1], '-07-')">
                                    <xsl:text>July </xsl:text>
                                    <xsl:value-of select="substring(Date[1],9,10)"/>
                                    <xsl:text>, </xsl:text>
                                    <xsl:value-of select="substring(Date[1],1,4)"/>
                                </xsl:when>
                                <xsl:when test="contains(Date[1], '-08-')">
                                    <xsl:text>August </xsl:text>
                                    <xsl:value-of select="substring(Date[1],9,10)"/>
                                    <xsl:text>, </xsl:text>
                                    <xsl:value-of select="substring(Date[1],1,4)"/>
                                </xsl:when>
                                <xsl:when test="contains(Date[1], '-09-')">
                                    <xsl:text>September </xsl:text>
                                    <xsl:value-of select="substring(Date[1],9,10)"/>
                                    <xsl:text>, </xsl:text>
                                    <xsl:value-of select="substring(Date[1],1,4)"/>
                                </xsl:when>
                                <xsl:when test="contains(Date[1], '-10-')">
                                    <xsl:text>October </xsl:text>
                                    <xsl:value-of select="substring(Date[1],9,10)"/>
                                    <xsl:text>, </xsl:text>
                                    <xsl:value-of select="substring(Date[1],1,4)"/>
                                </xsl:when>
                                <xsl:when test="contains(Date[1], '-11-')">
                                    <xsl:text>November </xsl:text>
                                    <xsl:value-of select="substring(Date[1],9,10)"/>
                                    <xsl:text>, </xsl:text>
                                    <xsl:value-of select="substring(Date[1],1,4)"/>
                                </xsl:when>
                                <xsl:when test="contains(Date[1], '-12-')">
                                    <xsl:text>December </xsl:text>
                                    <xsl:value-of select="substring(Date[1],9,10)"/>
                                    <xsl:text>, </xsl:text>
                                    <xsl:value-of select="substring(Date[1],1,4)"/>
                                </xsl:when>
                            </xsl:choose>
                        </title>
                    </titleInfo>
                </xsl:when>
                <xsl:when test="VolumeNo[1] = 145 and IssueNo[1] &lt; 8">
                    <titleInfo>
                        <title>
                            <xsl:text>Tech News</xsl:text>
                            <xsl:text>, </xsl:text>
                            <xsl:choose>
                                <xsl:when test="contains(Date[1], '-01-')">
                                    <xsl:text>January </xsl:text>
                                    <xsl:value-of select="substring(Date[1],9,10)"/>
                                    <xsl:text>, </xsl:text>
                                    <xsl:value-of select="substring(Date[1],1,4)"/>
                                </xsl:when>
                                <xsl:when test="contains(Date[1], '-02-')">
                                    <xsl:text>February </xsl:text>
                                    <xsl:value-of select="substring(Date[1],9,10)"/>
                                    <xsl:text>, </xsl:text>
                                    <xsl:value-of select="substring(Date[1],1,4)"/>
                                </xsl:when>
                                <xsl:when test="contains(Date[1], '-03-')">
                                    <xsl:text>March </xsl:text>
                                    <xsl:value-of select="substring(Date[1],9,10)"/>
                                    <xsl:text>, </xsl:text>
                                    <xsl:value-of select="substring(Date[1],1,4)"/>
                                </xsl:when>
                                <xsl:when test="contains(Date[1], '-04-')">
                                    <xsl:text>April </xsl:text>
                                    <xsl:value-of select="substring(Date[1],9,10)"/>
                                    <xsl:text>, </xsl:text>
                                    <xsl:value-of select="substring(Date[1],1,4)"/>
                                </xsl:when>
                                <xsl:when test="contains(Date[1], '-05-')">
                                    <xsl:text>May </xsl:text>
                                    <xsl:value-of select="substring(Date[1],9,10)"/>
                                    <xsl:text>, </xsl:text>
                                    <xsl:value-of select="substring(Date[1],1,4)"/>
                                </xsl:when>
                                <xsl:when test="contains(Date[1], '-06-')">
                                    <xsl:text>June </xsl:text>
                                    <xsl:value-of select="substring(Date[1],9,10)"/>
                                    <xsl:text>, </xsl:text>
                                    <xsl:value-of select="substring(Date[1],1,4)"/>
                                </xsl:when>
                                <xsl:when test="contains(Date[1], '-07-')">
                                    <xsl:text>July </xsl:text>
                                    <xsl:value-of select="substring(Date[1],9,10)"/>
                                    <xsl:text>, </xsl:text>
                                    <xsl:value-of select="substring(Date[1],1,4)"/>
                                </xsl:when>
                                <xsl:when test="contains(Date[1], '-08-')">
                                    <xsl:text>August </xsl:text>
                                    <xsl:value-of select="substring(Date[1],9,10)"/>
                                    <xsl:text>, </xsl:text>
                                    <xsl:value-of select="substring(Date[1],1,4)"/>
                                </xsl:when>
                                <xsl:when test="contains(Date[1], '-09-')">
                                    <xsl:text>September </xsl:text>
                                    <xsl:value-of select="substring(Date[1],9,10)"/>
                                    <xsl:text>, </xsl:text>
                                    <xsl:value-of select="substring(Date[1],1,4)"/>
                                </xsl:when>
                                <xsl:when test="contains(Date[1], '-10-')">
                                    <xsl:text>October </xsl:text>
                                    <xsl:value-of select="substring(Date[1],9,10)"/>
                                    <xsl:text>, </xsl:text>
                                    <xsl:value-of select="substring(Date[1],1,4)"/>
                                </xsl:when>
                                <xsl:when test="contains(Date[1], '-11-')">
                                    <xsl:text>November </xsl:text>
                                    <xsl:value-of select="substring(Date[1],9,10)"/>
                                    <xsl:text>, </xsl:text>
                                    <xsl:value-of select="substring(Date[1],1,4)"/>
                                </xsl:when>
                                <xsl:when test="contains(Date[1], '-12-')">
                                    <xsl:text>December </xsl:text>
                                    <xsl:value-of select="substring(Date[1],9,10)"/>
                                    <xsl:text>, </xsl:text>
                                    <xsl:value-of select="substring(Date[1],1,4)"/>
                                </xsl:when>
                            </xsl:choose>
                        </title>
                    </titleInfo>
                </xsl:when>
                <xsl:otherwise>
                    <titleInfo>
                        <title>
                            <xsl:text>TechNews</xsl:text>
                            <xsl:text>, </xsl:text>
                            <xsl:choose>
                                <xsl:when test="contains(Date[1], '-01-')">
                                    <xsl:text>January </xsl:text>
                                    <xsl:value-of select="substring(Date[1],9,10)"/>
                                    <xsl:text>, </xsl:text>
                                    <xsl:value-of select="substring(Date[1],1,4)"/>
                                </xsl:when>
                                <xsl:when test="contains(Date[1], '-02-')">
                                    <xsl:text>February </xsl:text>
                                    <xsl:value-of select="substring(Date[1],9,10)"/>
                                    <xsl:text>, </xsl:text>
                                    <xsl:value-of select="substring(Date[1],1,4)"/>
                                </xsl:when>
                                <xsl:when test="contains(Date[1], '-03-')">
                                    <xsl:text>March </xsl:text>
                                    <xsl:value-of select="substring(Date[1],9,10)"/>
                                    <xsl:text>, </xsl:text>
                                    <xsl:value-of select="substring(Date[1],1,4)"/>
                                </xsl:when>
                                <xsl:when test="contains(Date[1], '-04-')">
                                    <xsl:text>April </xsl:text>
                                    <xsl:value-of select="substring(Date[1],9,10)"/>
                                    <xsl:text>, </xsl:text>
                                    <xsl:value-of select="substring(Date[1],1,4)"/>
                                </xsl:when>
                                <xsl:when test="contains(Date[1], '-05-')">
                                    <xsl:text>May </xsl:text>
                                    <xsl:value-of select="substring(Date[1],9,10)"/>
                                    <xsl:text>, </xsl:text>
                                    <xsl:value-of select="substring(Date[1],1,4)"/>
                                </xsl:when>
                                <xsl:when test="contains(Date[1], '-06-')">
                                    <xsl:text>June </xsl:text>
                                    <xsl:value-of select="substring(Date[1],9,10)"/>
                                    <xsl:text>, </xsl:text>
                                    <xsl:value-of select="substring(Date[1],1,4)"/>
                                </xsl:when>
                                <xsl:when test="contains(Date[1], '-07-')">
                                    <xsl:text>July </xsl:text>
                                    <xsl:value-of select="substring(Date[1],9,10)"/>
                                    <xsl:text>, </xsl:text>
                                    <xsl:value-of select="substring(Date[1],1,4)"/>
                                </xsl:when>
                                <xsl:when test="contains(Date[1], '-08-')">
                                    <xsl:text>August </xsl:text>
                                    <xsl:value-of select="substring(Date[1],9,10)"/>
                                    <xsl:text>, </xsl:text>
                                    <xsl:value-of select="substring(Date[1],1,4)"/>
                                </xsl:when>
                                <xsl:when test="contains(Date[1], '-09-')">
                                    <xsl:text>September </xsl:text>
                                    <xsl:value-of select="substring(Date[1],9,10)"/>
                                    <xsl:text>, </xsl:text>
                                    <xsl:value-of select="substring(Date[1],1,4)"/>
                                </xsl:when>
                                <xsl:when test="contains(Date[1], '-10-')">
                                    <xsl:text>October </xsl:text>
                                    <xsl:value-of select="substring(Date[1],9,10)"/>
                                    <xsl:text>, </xsl:text>
                                    <xsl:value-of select="substring(Date[1],1,4)"/>
                                </xsl:when>
                                <xsl:when test="contains(Date[1], '-11-')">
                                    <xsl:text>November </xsl:text>
                                    <xsl:value-of select="substring(Date[1],9,10)"/>
                                    <xsl:text>, </xsl:text>
                                    <xsl:value-of select="substring(Date[1],1,4)"/>
                                </xsl:when>
                                <xsl:when test="contains(Date[1], '-12-')">
                                    <xsl:text>December </xsl:text>
                                    <xsl:value-of select="substring(Date[1],9,10)"/>
                                    <xsl:text>, </xsl:text>
                                    <xsl:value-of select="substring(Date[1],1,4)"/>
                                </xsl:when>
                            </xsl:choose>
                        </title>
                    </titleInfo>
                </xsl:otherwise>
            </xsl:choose>

            <physicalDescription>
                <internetMediaType>application/pdf</internetMediaType>
            </physicalDescription>
            
            <typeOfResource authority="coar" valueURI="http://purl.org/coar/resource_type/c_18cf">
                <xsl:text>Text</xsl:text>
            </typeOfResource>
                
            <accessCondition type="useAndReproduction" displayLabel="rightsstatements.org">
                <xsl:text>In Copyright</xsl:text>
            </accessCondition>
            
            <accessCondition type="useAndReproduction" displayLabel="rightsstatements.orgURI">
                <xsl:text>http://rightsstatements.org/vocab/InC/1.0/</xsl:text>
            </accessCondition>
            
            <name type="corporate">
                <namePart>
                    <xsl:text>Illinois Tech Libraries</xsl:text>
                </namePart>
                <affiliation>
                    <xsl:text>Illinois Institute of Technology</xsl:text>
                </affiliation>
                <role>
                    <roleTerm type="text">
                        <xsl:text>Affiliated department</xsl:text>
                    </roleTerm>
                </role>
            </name>
            

            <xsl:choose>
                <xsl:when test="VolumeNo[1] &lt; 26">
                    <name>
                        <role>
                            <roleTerm authority="marcrelator" type="text">Creator</roleTerm>
                        </role>
                        <namePart>Armour Institute of Technology</namePart>
                    </name>
                </xsl:when>
                <xsl:otherwise>
                    <name>
                        <role>
                            <roleTerm authority="marcrelator" type="text">Creator</roleTerm>
                        </role>
                        <namePart>Illinois Institute of Technology</namePart>
                    </name>
                </xsl:otherwise>
            </xsl:choose>

            <language>
                <languageTerm type="code" authority="iso639-2b">en</languageTerm>
            </language>
            <abstract>
                <xsl:value-of select="SpecialEdition[1]"/>
            </abstract>

        </mods>
    </xsl:template>

    <xsl:template match="VolumeNo[1]">
        <part>
            <detail type="volume">
                <number>
                    <xsl:value-of select="."/>
                </number>
            </detail>
        </part>
    </xsl:template>

    <xsl:template match="IssueNo[1]">
        <part>
            <detail type="issue">
                <number>
                    <xsl:value-of select="."/>
                </number>
            </detail>
        </part>
    </xsl:template>


    <xsl:template match="Date[1]">

        <originInfo>
            <dateCreated encoding="iso8601" keyDate="yes">
                <xsl:value-of select="."/>
            </dateCreated>
            <dateIssued encoding="iso8601">
                <xsl:value-of select="."/>
            </dateIssued>
        </originInfo>
        
    </xsl:template>
    
    <xsl:template match="relatedItem">
        <relatedItem type="constituent">
            <titleInfo>
                <title>
                    <xsl:value-of select="titleInfo/title"/>
                </title>
            </titleInfo>
            <name>
                <role>
                    <roleTerm authority="marcrelator" type="text">Creator</roleTerm>
                </role>
                <namePart>
                    <xsl:value-of select="name/namePart"/>
                </namePart>
            </name>
            
            <subject>
                <xsl:for-each select="subject/topic">
                <topic>
                    <xsl:value-of select="."/>
                </topic>
                </xsl:for-each>
                
                <xsl:for-each select="subject/geographic">
                <geographic>
                     <xsl:value-of select="."/>
                </geographic>
                </xsl:for-each>
            </subject>
            
            
        </relatedItem>
    </xsl:template>

    <xsl:template
        match="ArticleUID | issueUID | Status | SpecialEdition | IssueNotes | VolumeNo | IssueNo | PageNo | ColumnNo | Date | ArticleAuthor | Scope | ArticleType | ArticleFrequency | Realm | TechTags | Keywords | People | Location"> </xsl:template>

</xsl:stylesheet>
