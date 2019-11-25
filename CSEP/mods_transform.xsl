<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:dc="http://purl.org/dc/elements/1.1/" xmlns:sru_dc="info:srw/schema/1/dc-schema"
    xmlns:oai_dc="http://www.openarchives.org/OAI/2.0/oai_dc/"
    xmlns:xlink="http://www.w3.org/1999/xlink" xmlns="http://www.loc.gov/mods/v3"
    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" exclude-result-prefixes="sru_dc oai_dc dc"
    version="2.0">
    
    <xsl:strip-space elements="*"/>
    <xsl:output indent="yes"/>
    
    
    <xsl:template match="record">
        <mods xmlns="http://www.loc.gov/mods/v3"
            xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
            xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:xlink="http://www.w3.org/1999/xlink"
            xmlns:mods="http://www.loc.gov/mods/v3" version="3.7"
            xsi:schemaLocation="http://www.loc.gov/mods/v3 http://www.loc.gov/standards/mods/v3/mods-3-7.xsd">
            <xsl:apply-templates/>
            
            <physicalDescription>
                <digitalOrigin>born digital</digitalOrigin>
                <internetMediaType>application/pdf</internetMediaType>
            </physicalDescription>
            
            <name type="corporate">
                <affiliation>Illinois Institute of Technology</affiliation>
            </name>
            
            <name type="corporate">
                <namePart>CSEP / Center for the Study of Ethics in the Professions</namePart>
            </name>
            
        </mods>
    </xsl:template>
    
    <xsl:template match="titles/title/style">
        <titleInfo>
            <title>
                <xsl:value-of select="normalize-space(.)"/>
            </title>
        </titleInfo>
    </xsl:template>
    
    <xsl:template match="author/style">
        <name>
            <role>
                <roleTerm type="text" authority="marcrelator"
                    authorityURI="http://id.loc.gov/vocabulary/relators"
                    valueURI="http://id.loc.gov/vocabulary/relators/cre">creator</roleTerm>
            </role>
            <namePart>
                <xsl:value-of select="."/>
            </namePart>
        </name>
    </xsl:template>
    
    <xsl:template match="abstract/style">
        <abstract>
            <xsl:value-of select="."/>
        </abstract>
    </xsl:template>
    
    <xsl:template match="ref-type">
        <typeOfResource authority="aat" valueURI="http://vocab.getty.edu/page/aat/300028029">
            <xsl:value-of select="@name"/>
        </typeOfResource>
    </xsl:template>
    
    <xsl:template match="full-title/style">
        <relatedItem type="host">
            <titleInfo>
                <title>
                    <xsl:value-of select="."/>
                </title>
            </titleInfo>
        </relatedItem>
    </xsl:template>
    
    <xsl:template match="dates/year/style">
        <originInfo>
            <dateCreated keyDate="yes">
                <xsl:value-of select="."/>
            </dateCreated>
        </originInfo>
    </xsl:template>
    
    <xsl:template match="publisher/style">
        <originInfo>
            <publisher>
                <xsl:value-of select="."/>
            </publisher>
        </originInfo>
    </xsl:template>
    
    <xsl:template match="isbn/style">
        <identifier type="isbn">
            <xsl:value-of select="."/>
        </identifier>            
    </xsl:template>
    
    <xsl:template match="urls/related-urls/url/style">
        <relatedItem type="otherFormat">
            <identifier>
                <xsl:value-of select="."/>
            </identifier>
        </relatedItem>            
    </xsl:template>
    
    <xsl:template match="electronic-resource-num">
        <relatedItem type="otherFormat">
            <identifier>
                <xsl:value-of select="."/>
            </identifier>
        </relatedItem>            
    </xsl:template>
    
    <xsl:template match="database | source-app | rec-number | foreign-keys | secondary-title | pdf-urls | pages | volume | number | pub-dates"></xsl:template>
    
</xsl:stylesheet>
