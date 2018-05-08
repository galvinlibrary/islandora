<?xml version="1.0" encoding="UTF-8"?>	
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
    xmlns:dc="http://purl.org/dc/elements/1.1/" 
    xmlns:sru_dc="info:srw/schema/1/dc-schema" 
    xmlns:oai_dc="http://www.openarchives.org/OAI/2.0/oai_dc/" 
    xmlns:xlink="http://www.w3.org/1999/xlink" xmlns="http://www.loc.gov/mods/v3" 
    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" exclude-result-prefixes="sru_dc oai_dc dc" 
    version="2.0">
    
    <xsl:output method="xml" indent="yes" encoding="UTF-8"/>
    
    <xsl:param name="multisubjects" select="dcvalue[@element='subject']"/>
   
    <xsl:template match="dublin_core">
        <mods version="3.4" xmlns="http://www.loc.gov/mods/v3" 
            xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" 
            xsi:schemaLocation="http://www.loc.gov/mods/v3 http://www.loc.gov/standards/mods/v3/mods-3-4.xsd">
            <xsl:call-template name="dcMain"/>                     
        </mods>
        
  <!-- this version removed the metadata_iit hard coding and nested all physicalDescription subelements together -->
  <!-- this version removed non nested physicalDescription tags -->    
    </xsl:template>  
    <xsl:template name="dcMain">
        <xsl:apply-templates select="dcvalue[@element='title'][@qualifier='none']"/>
        <xsl:apply-templates select="dcvalue[@element='title'][@qualifier='alternative']"/>
        <xsl:apply-templates select="dcvalue[@element='contributor'][@qualifier='author']"/>
        <xsl:apply-templates select="dcvalue[@element='contributor'][@qualifier='editor']"/>
        <xsl:apply-templates select="dcvalue[@element='contributor'][@qualifier='other']"/>
        <xsl:apply-templates select="dcvalue[@element='contributor'][@qualifier='advisor']"/>
        <xsl:apply-templates select="dcvalue[@element='coverage'][@qualifier='spatial']"/>        
        <xsl:apply-templates select="dcvalue[@element='description'][@qualifier='abstract']"/>
        <xsl:apply-templates select="dcvalue[@element='description'][@qualifier='provenance']"/>
        <xsl:apply-templates select="dcvalue[@element='description'][@qualifier='sponsorship']"/>
        <xsl:apply-templates select="dcvalue[@element='description'][@qualifier='none']"/>       
        <xsl:apply-templates select="dcvalue[@element='date'][@qualifier='none']"/>
        <xsl:apply-templates select="dcvalue[@element='date'][@qualifier='accessioned']"/>
        <xsl:apply-templates select="dcvalue[@element='date'][@qualifier='available']"/>
        <xsl:apply-templates select="dcvalue[@element='date'][@qualifier='copyright']"/>
        <xsl:apply-templates select="dcvalue[@element='date'][@qualifier='issued']"/>
        <xsl:apply-templates select="dcvalue[@element='embargo'][@qualifier='terms']"/>
        <xsl:apply-templates select="dcvalue[@element='format'][@qualifier='original']"/>
        <xsl:apply-templates select="dcvalue[@element='identifier'][@qualifier='govdoc']"/>
        <xsl:apply-templates select="dcvalue[@element='identifier'][@qualifier='ipc']"/>
        <xsl:apply-templates select="dcvalue[@element='identifier'][@qualifier='isbn']"/>
        <xsl:apply-templates select="dcvalue[@element='identifier'][@qualifier='ismn']"/>
        <xsl:apply-templates select="dcvalue[@element='identifier'][@qualifier='pn']"/>
        <xsl:apply-templates select="dcvalue[@element='identifier'][@qualifier='uri']"/>
        <xsl:apply-templates select="dcvalue[@element='identifier'][@qualifier='other']"/>
        <xsl:apply-templates select="dcvalue[@element='identifier'][@qualifier='none']"/>
        <xsl:apply-templates select="dcvalue[@element='language'][@qualifier='iso']"/>
        <xsl:apply-templates select="dcvalue[@element='publisher']"/>
        <xsl:apply-templates select="dcvalue[@element='relation'][@qualifier='hasversion']"/>
        <xsl:apply-templates select="dcvalue[@element='rights'][@qualifier='none']"/>
        <xsl:apply-templates select="dcvalue[@element='rights'][@qualifier='uri']"/>        
        <xsl:apply-templates select="dcvalue[@element='source']"/>
        <xsl:apply-templates select="dcvalue[@element='subject']"/>
        <xsl:apply-templates select="dcvalue[@element='subject'][@qualifier='other']"/>
        <xsl:apply-templates select="dcvalue[@element='type']"/>
        <xsl:apply-templates select="dcvalue[@element='type'][@qualifier='architectural']"/>       
    </xsl:template>

    <xsl:template match="dcvalue[@element='title']"> <!-- selects element from xml -->
        <titleInfo>
            <title>
                <xsl:apply-templates/>
            </title>
        </titleInfo>
    </xsl:template>
    
    <xsl:template match="dcvalue[@element='title'][@qualifier='alternative']">
        <titleInfo type="alternative">
            <title>
                <xsl:apply-templates/>
            </title>
        </titleInfo>
    </xsl:template>
    
    <xsl:template match="dcvalue[@element='contributor'][@qualifier='advisor']">
        <name>
            <role>
                <roleTerm type="text">
                    <xsl:text>advisor</xsl:text>
                </roleTerm>
            </role>
            <namePart>
                <xsl:apply-templates/>
            </namePart>           
        </name>
    </xsl:template>
    
    <xsl:template match="dcvalue[@element='contributor'][@qualifier='author']">
        <name>
            <role>
                <roleTerm type="text">
                    <xsl:text>creator</xsl:text>
                </roleTerm>
            </role>
            <namePart>
                <xsl:apply-templates/>
            </namePart>          
        </name>
    </xsl:template>
    <xsl:template match="dcvalue[@element='contributor'][@qualifier='editor']">
        <name>
            <role>
                <roleTerm type="text">
                    <xsl:text>editor</xsl:text>
                </roleTerm>
            </role>
            <namePart>
                <xsl:apply-templates/>
            </namePart>           
        </name>
    </xsl:template>
    <xsl:template match="dcvalue[@element='contributor'][@qualifier='other']">
        <name>
            <role>
                <roleTerm type="text">
                    <xsl:text>other</xsl:text>
                </roleTerm>
            </role>
            <namePart>
                <xsl:apply-templates/>
            </namePart>
        </name>
    </xsl:template>
    
    <xsl:template match="dcvalue[@element='coverage'][@qualifier='spatial']">
        <subject>
            <geographic>
                <xsl:apply-templates/>
            </geographic>
        </subject>
    </xsl:template>
    <xsl:template match="dcvalue[@element='date'][@qualifier='accessioned']">
        <extension>
            <dateAccessioned encoding='iso8601'>
                <xsl:apply-templates/>
            </dateAccessioned>
        </extension>
    </xsl:template>
    <xsl:template match="dcvalue[@element='date'][@qualifier='available']">
        <extension>
            <dateAvailable encoding='iso8601'>
                <xsl:apply-templates/>
            </dateAvailable>
        </extension>
    </xsl:template>
    <xsl:template match="dcvalue[@element='date'][@qualifier='copyright']">
        <originInfo>
            <copyrightDate encoding='iso8601'>
                <xsl:apply-templates/>
            </copyrightDate>
        </originInfo>
    </xsl:template>
    <xsl:template match="dcvalue[@element='date'][@qualifier='issued']">
        <originInfo>
            <dateIssued encoding='iso8601' keyDate='yes'>
                <xsl:apply-templates/>
            </dateIssued>
        </originInfo>
    </xsl:template>
    <xsl:template match="dcvalue[@element='date'][@qualifier='none']">
        <originInfo>
            <dateCaptured encoding="iso8601">
                <xsl:apply-templates/>
            </dateCaptured>
        </originInfo>
    </xsl:template>
    <xsl:template match="dcvalue[@element='description'][@qualifier='abstract']">
        <abstract>
            <xsl:value-of select="normalize-space(.)" />          
        </abstract>
    </xsl:template>
    <xsl:template match="dcvalue[@element='description'][@qualifier='none']">
        <note>
            <xsl:value-of select="normalize-space(.)" />
        </note>
    </xsl:template>
    <xsl:template match="dcvalue[@element='description'][@qualifier='provenance']">
        <note type="provenance">
            <xsl:value-of select="normalize-space(.)" />
        </note>
    </xsl:template>
    <xsl:template match="dcvalue[@element='description'][@qualifier='sponsorship']">
        <name>
            <role>
                <roleTerm type="text">
                    <xsl:text>sponsor</xsl:text>
                </roleTerm>
            </role>
            <namePart>
                <xsl:apply-templates/>
            </namePart>
        </name>
    </xsl:template>
    <xsl:template match="dcvalue[@element='embargo'][@qualifier='term']">
        <note type="embargo">
            <xsl:text>Embargo expires </xsl:text>
            <xsl:value-of select="."/>
        </note>
    </xsl:template>
    <xsl:template match="dcvalue[@element='format'][@qualifier='original']">
        <physicalDescription>
            <form>
                <xsl:apply-templates/>
            </form>
            <digitalOrigin>born digital</digitalOrigin>
            <internetMediaType>
                <!-- MIME type, pull from file information -->
            </internetMediaType>
        </physicalDescription>
    </xsl:template>
    <xsl:template match="dcvalue[@element='relation'][@qualifier='hasversion']">  
        <xsl:choose>
            <xsl:when test="starts-with(text(), 'http://')">
                <relatedItem type='otherVersion'>
                <location>
                    <url>
                        <xsl:value-of select="."/>
                    </url>
                </location>
                </relatedItem>
            </xsl:when>
                <xsl:otherwise>
                    <relatedItem type="constituent">
                        <xsl:value-of select="."/>
                    </relatedItem> 
                </xsl:otherwise>
        </xsl:choose>   
    </xsl:template>
    <xsl:template match="dcvalue[@element='relation'][@qualifier='uri']">  
        <xsl:choose>
            <xsl:when test="starts-with(text(), 'http://')">
                <relatedItem type='otherVersion'>
                    <location>
                        <url>
                            <xsl:value-of select="."/>
                        </url>
                    </location>
                </relatedItem>
            </xsl:when>
            <xsl:otherwise>
                <relatedItem type="constituent">
                    <xsl:value-of select="."/>
                </relatedItem> 
            </xsl:otherwise>
        </xsl:choose>   
    </xsl:template>
    
    <xsl:template match="dcvalue[@element='identifier'][@qualifier='govdoc']">
        <identifier>                              
           <xsl:attribute name="type"> 
               <xsl:text>govdoc</xsl:text>  
           </xsl:attribute>
           <xsl:apply-templates/>
        </identifier>
    </xsl:template>
    <xsl:template match="dcvalue[@element='identifier'][@qualifier='ipc']">
        <identifier>                              
            <xsl:attribute name="type"> 
                <xsl:text>ipc</xsl:text>  
            </xsl:attribute>
            <xsl:apply-templates/>
        </identifier>
    </xsl:template>
    <xsl:template match="dcvalue[@element='identifier'][@qualifier='isbn']">
        <identifier>                              
            <xsl:attribute name="type"> 
                <xsl:text>isbn</xsl:text>  
            </xsl:attribute>
            <xsl:apply-templates/>
        </identifier>
    </xsl:template>
    <xsl:template match="dcvalue[@element='identifier'][@qualifier='ismn']">
        <identifier>                              
            <xsl:attribute name="type"> 
                <xsl:text>ismn</xsl:text>  
            </xsl:attribute>
            <xsl:apply-templates/>
        </identifier>
    </xsl:template>
    <xsl:template match="dcvalue[@element='identifier'][@qualifier='issn']">
        <identifier>                              
            <xsl:attribute name="type"> 
                <xsl:text>issn</xsl:text>  
            </xsl:attribute>
            <xsl:apply-templates/>
        </identifier>
    </xsl:template>
    <xsl:template match="dcvalue[@element='identifier'][@qualifier='pn']">
        <identifier>                              
            <xsl:attribute name="type"> 
                <xsl:text>pn</xsl:text>  
            </xsl:attribute>
            <xsl:apply-templates/>
        </identifier>
    </xsl:template>
    
    <xsl:template match="dcvalue[@element='identifier'][@qualifier='uri']">
        <identifier>
            <xsl:attribute name="type"> 
                <xsl:choose>                 
                    <xsl:when test="starts-with(text(),'http://hdl.')">
                        <xsl:text>hdl</xsl:text>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:text>uri</xsl:text>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:attribute>
            <xsl:apply-templates/>
        </identifier>
        <location>
            <url>
                <xsl:apply-templates/>
            </url>            
        </location>
    </xsl:template>
    
    <xsl:template match="dcvalue[@element='identifier'][@qualifier='other']">
        <identifier>                              
            <xsl:attribute name="type"> 
                <xsl:text>local</xsl:text>  
            </xsl:attribute>
            <xsl:apply-templates/>
        </identifier>
    </xsl:template>
    
    <xsl:template match="dcvalue[@element='identifier'][@qualifier='none']">
        <identifier>                              
            <xsl:attribute name="type"> 
                <xsl:text>local</xsl:text>  
            </xsl:attribute>
            <xsl:apply-templates/>
        </identifier>
    </xsl:template>
                     
    <xsl:template match="dcvalue[@element='language']">
        <xsl:variable name="langcode" select="current()" />
        <language>
            <languageTerm type="code" authority="rfc3066">            
                <xsl:value-of select="substring($langcode/text(),1,2)"/>               
            </languageTerm>
        </language>
    </xsl:template>
    <xsl:template match="dcvalue[@element='publisher']">
        <originInfo>
            <publisher>
                <xsl:apply-templates/>
            </publisher>
        </originInfo>
    </xsl:template>
    <xsl:template match="dcvalue[@element='relation']">
        <!--If begins with "http://"-->
        <relatedItem>
            <location>
                <url>
                    <xsl:apply-templates/>
                </url>
            </location>
        </relatedItem>
    </xsl:template>
    <xsl:template match="dcvalue[@element='rights'][@qualifier='none']">
        <accessCondition type="useAndReproduction">
            <xsl:apply-templates/>
        </accessCondition>
    </xsl:template>
    <xsl:template match="dcvalue[@element='rights'][@qualifier='uri']">
        <accessCondition type='uri'> 
            <xsl:apply-templates/>
        </accessCondition>
    </xsl:template>
    <xsl:template match="dcvalue[@element='source']">
        <relatedItem displayLabel="Collection">
            <xsl:apply-templates/>
        </relatedItem>
    </xsl:template>    
    
    <xsl:template match="dcvalue[@element='subject']">
        <subject>          
                <xsl:call-template name="tokenize">
                    <xsl:with-param name="text" select="."/>
                </xsl:call-template>           
        </subject>
    </xsl:template>
    
    <xsl:template name="tokenize">
        <xsl:param name="text"/>
        <xsl:param name="sep" select="', '"/>
        <xsl:choose>
            <xsl:when test="contains($text, $sep)">
                <topic>
                    <xsl:value-of select="substring-before($text, $sep)"/>
                </topic>
                <!--recursive call -->
                <xsl:call-template name="tokenize">
                    <xsl:with-param name="text" select="substring-after($text, $sep)" />
                </xsl:call-template>
            </xsl:when>
        <xsl:otherwise>
            <topic>
                <xsl:value-of select="$text"/>
            </topic>
        </xsl:otherwise>
   </xsl:choose>
    
  </xsl:template>
                
    
    <xsl:template match="dcvalue[@element='type']">
        <!--2.0: Variable test for any dc:type with value of collection for mods:typeOfResource -->
        <!-- Transforms DC type value to MODS typeOfResource controlled vocabulary value-->
        <!-- And and creates new genre element with original DC type value-->
        <!---Islandora SOLR index on genre value--> 
        <xsl:variable name="collection">
            <xsl:if test="../dc:dcvalue[@element='type'][string(text()) = 'collection' or string(text()) = 'Collection']">true</xsl:if>
        </xsl:variable>
        <xsl:choose>
            <xsl:when test="contains(text(), 'Collection') or contains(text(), 'collection')">
                <genre authority="gmgpc">
                    <xsl:text>collection</xsl:text>
                </genre>
            </xsl:when>
            <xsl:otherwise>
                <!-- dc.type to mods.typeOfResource is based on LOC Dublin Core Metadata Element Set Mapping to MODS Version 3 mapping at  -->
                <xsl:choose>
                    <xsl:when test="string(text()) = 'Dataset' or string(text()) = 'dataset'">
                        <typeOfResource>
                            <xsl:if test="$collection='true'">
                                <xsl:attribute name="collection">
                                    <xsl:text>yes</xsl:text>
                                </xsl:attribute>
                            </xsl:if>	
                            <xsl:text>software, multimedia</xsl:text>
                        </typeOfResource>
                        <genre authority="coar" authorityURI="c_ddb1">
                            <xsl:text>dataset</xsl:text>
                        </genre>
                    </xsl:when>
                    <xsl:when test="string(text()) = 'Article' or string(text()) = 'article'">
                        <typeOfResource>
                            <xsl:if test="$collection='true'">
                                <xsl:attribute name="collection">
                                    <xsl:text>yes</xsl:text>
                                </xsl:attribute>
                            </xsl:if>	
                            <xsl:text>text</xsl:text>
                        </typeOfResource>
                        <genre authority="aat" authorityURI="300048715">
                            <xsl:text>article</xsl:text>
                        </genre>
                    </xsl:when>
                    <xsl:when test="string(text()) = 'Book' or string(text()) = 'book'">
                        <typeOfResource>
                            <xsl:if test="$collection='true'">
                                <xsl:attribute name="collection">
                                    <xsl:text>yes</xsl:text>
                                </xsl:attribute>
                            </xsl:if>	
                            <xsl:text>text</xsl:text>
                        </typeOfResource>
                        <genre authority="gmgpc" authorityURI="tgm001221">
                            <xsl:text>book</xsl:text>
                        </genre>
                    </xsl:when>
                    <xsl:when test="string(text()) = 'Book chapter' or string(text()) = 'book chapter'">
                        <typeOfResource>
                            <xsl:if test="$collection='true'">
                                <xsl:attribute name="collection">
                                    <xsl:text>yes</xsl:text>
                                </xsl:attribute>
                            </xsl:if>	
                            <xsl:text>text</xsl:text>
                        </typeOfResource>
                        <genre authority="aat" authorityURI="300311699">
                            <xsl:text>chapter</xsl:text>
                        </genre>
                    </xsl:when>
                    <xsl:when test="string(text()) = 'Deliverable' or string(text()) = 'deliverable'">
                        <typeOfResource>
                            <xsl:if test="$collection='true'">
                                <xsl:attribute name="collection">
                                    <xsl:text>yes</xsl:text>
                                </xsl:attribute>
                            </xsl:if>	
                            <xsl:text>mixed material</xsl:text>
                        </typeOfResource>
                        <genre>
                            <xsl:value-of select="."/>
                        </genre>
                    </xsl:when>
                    <xsl:when test="string(text()) = 'Dissertation' or string(text()) = 'dissertation'">
                        <typeOfResource>
                            <xsl:if test="$collection='true'">
                                <xsl:attribute name="collection">
                                    <xsl:text>yes</xsl:text>
                                </xsl:attribute>
                            </xsl:if>	
                            <xsl:text>text</xsl:text>
                        </typeOfResource>
                        <genre authority="coar" authorityURI="c_db06">
                            <xsl:text>doctoral thesis</xsl:text>
                        </genre>
                    </xsl:when>
                    <xsl:when test="string(text()) = 'Image' or string(text()) = 'image'">
                        <typeOfResource>
                            <xsl:if test="$collection='true'">
                                <xsl:attribute name="collection">
                                    <xsl:text>yes</xsl:text>
                                </xsl:attribute>
                            </xsl:if>
                            <xsl:text>still image</xsl:text>
                        </typeOfResource>
                        <genre authority="coar" authorityURI="c_db06">
                            <xsl:text>still image</xsl:text>
                        </genre>
                    </xsl:when>
                    <xsl:when test="string(text()) = 'Software' or string(text()) = 'software'">
                        <typeOfResource>
                            <xsl:if test="$collection='true'">
                                <xsl:attribute name="collection">
                                    <xsl:text>yes</xsl:text>
                                </xsl:attribute>
                            </xsl:if>
                            <xsl:text>software, multimedia</xsl:text>
                        </typeOfResource>
                        <genre authority="coar" authorityURI="c_5ce6">
                            <xsl:text>software</xsl:text>
                        </genre>
                    </xsl:when>
                    <xsl:when test="string(text()) = 'Image, Moving' or string(text()) = 'image, moving' or string(text()) = 'Video' or string(text()) = 'video'">
                        <typeOfResource>
                            <xsl:if test="$collection='true'">
                                <xsl:attribute name="collection">
                                    <xsl:text>yes</xsl:text>
                                </xsl:attribute>
                            </xsl:if>
                            <xsl:text>moving image</xsl:text>
                        </typeOfResource>
                        <genre authority="gmgpc" authorityURI="tgm006804">
                            <xsl:text>moving picture</xsl:text>
                        </genre>
                    </xsl:when>
                    <xsl:when test="string(text()) = 'Image, 3-D' or string(text()) = 'image, 3-D'">
                        <typeOfResource>
                            <xsl:if test="$collection='true'">
                                <xsl:attribute name="collection">
                                    <xsl:text>yes</xsl:text>
                                </xsl:attribute>
                            </xsl:if>
                            <xsl:text>three dimensional object</xsl:text>
                        </typeOfResource>
                        <genre authority="gmgpc" authorityURI="tgm007159">
                            <xsl:text>object</xsl:text>
                        </genre>
                    </xsl:when>
                    <xsl:when test="string(text()) = 'Master&amp;apos;s Project' or string(text()) = 'master&amp;apos;s project'">
                        <typeOfResource>
                            <xsl:if test="$collection='true'">
                                <xsl:attribute name="collection">
                                    <xsl:text>yes</xsl:text>
                                </xsl:attribute>
                            </xsl:if>
                            <xsl:text>mixed material</xsl:text>
                        </typeOfResource>
                        <genre>
                            <xsl:value-of select="."/> 
                        </genre>                        
                    </xsl:when>
                    <xsl:when test="string(text()) = 'Software' or string(text()) = 'software'">
                        <typeOfResource>
                            <xsl:if test="$collection='true'">
                                <xsl:attribute name="collection">
                                    <xsl:text>yes</xsl:text>
                                </xsl:attribute>
                            </xsl:if>
                            <xsl:text>software, multimedia</xsl:text>
                        </typeOfResource>
                        <genre authority="aat" authorityURI="300028566">
                            <xsl:text>software</xsl:text>
                        </genre>
                    </xsl:when>
                    <xsl:when test="string(text()) = 'Patent' or string(text()) = 'patent'">
                        <typeOfResource>
                            <xsl:if test="$collection='true'">
                                <xsl:attribute name="collection">
                                    <xsl:text>yes</xsl:text>
                                </xsl:attribute>
                            </xsl:if>
                            <xsl:text>text</xsl:text>
                        </typeOfResource>
                        <genre authority="gmgpc" authorityURI="tgm007520">
                            <xsl:text>patent</xsl:text>
                        </genre>
                    </xsl:when>
                    <xsl:when test="string(text()) = 'Photographs' or string(text()) = 'photographs' or string(text()) = 'photograph' or string(text()) = 'Photograph'">
                        <typeOfResource>
                            <xsl:if test="$collection='true'">
                                <xsl:attribute name="collection">
                                    <xsl:text>yes</xsl:text>
                                </xsl:attribute>
                            </xsl:if>
                            <xsl:text>still image</xsl:text>
                        </typeOfResource>
                        <genre authority="gmgpc" authorityURI="tgm007721">
                            <xsl:text>photograph</xsl:text>
                        </genre>
                    </xsl:when>
                    <xsl:when test="string(text()) = 'Plan or blueprint'">
                        <typeOfResource>
                            <xsl:if test="$collection='true'">
                                <xsl:attribute name="collection">
                                    <xsl:text>yes</xsl:text>
                                </xsl:attribute>
                            </xsl:if>
                            <xsl:text>still image</xsl:text>
                        </typeOfResource>
                        <genre authority="gmgpc" authorityURI="tgm007871">
                            <xsl:text>plan</xsl:text>
                        </genre>
                    </xsl:when>
                    <xsl:when test="string(text()) = 'StillImage' or string(text()) = 'stillimage' or string(text()) = 'Still Image' or string(text()) = 'still image' or string(text()) = 'stillImage' or string(text()) = 'Still image' ">
                        <typeOfResource>
                            <xsl:if test="$collection='true'">
                                <xsl:attribute name="collection">
                                    <xsl:text>yes</xsl:text>
                                </xsl:attribute>
                            </xsl:if>
                            <xsl:text>still image</xsl:text>
                        </typeOfResource>                        
                    </xsl:when>
                    <xsl:when test="string(text()) = 'Text' or string(text()) = 'text'">
                        <typeOfResource>
                            <xsl:if test="$collection='true'">
                                <xsl:attribute name="collection">
                                    <xsl:text>yes</xsl:text>
                                </xsl:attribute>
                            </xsl:if>
                            <xsl:text>text</xsl:text>
                        </typeOfResource>
                    </xsl:when>
                    <xsl:when test="string(text()) = 'Thesis' or string(text()) = 'thesis'">
                        <typeOfResource>
                            <xsl:if test="$collection='true'">
                                <xsl:attribute name="collection">
                                    <xsl:text>yes</xsl:text>
                                </xsl:attribute>
                            </xsl:if>
                            <xsl:text>text</xsl:text>
                        </typeOfResource>
                        <genre authority="coar" authorityURI="c_46ec">
                            <xsl:text>thesis</xsl:text>
                        </genre>
                    </xsl:when>
                    <xsl:when test="string(text()) = 'Poster' or string(text()) = 'poster'">
                        <typeOfResource>
                            <xsl:if test="$collection='true'">
                                <xsl:attribute name="collection">
                                    <xsl:text>yes</xsl:text>
                                </xsl:attribute>
                            </xsl:if>
                            <xsl:text>mixed material</xsl:text>
                        </typeOfResource>
                        <genre authority="gmgpc" authorityURI="tgm008104">
                            <xsl:text>poster</xsl:text>
                        </genre>
                    </xsl:when>
                    <xsl:when test="string(text()) = 'Preprint' or string(text()) = 'preprint'">
                        <typeOfResource>
                            <xsl:if test="$collection='true'">
                                <xsl:attribute name="collection">
                                    <xsl:text>yes</xsl:text>
                                </xsl:attribute>
                            </xsl:if>
                            <xsl:text>text</xsl:text>
                        </typeOfResource>
                        <genre>
                            <xsl:value-of select="."/>
                        </genre>
                    </xsl:when>
                    <xsl:when test="string(text()) = 'Presentation' or string(text()) = 'presentation'">
                        <typeOfResource>
                            <xsl:if test="$collection='true'">
                                <xsl:attribute name="collection">
                                    <xsl:text>yes</xsl:text>
                                </xsl:attribute>
                            </xsl:if>
                            <xsl:text>mixed material</xsl:text>
                        </typeOfResource> 
                        <genre>
                            <xsl:value-of select="."/>
                        </genre>
                    </xsl:when>
                    <xsl:when test="string(text()) = 'Project' or string(text()) = 'project'">
                        <typeOfResource>
                            <xsl:if test="$collection='true'">
                                <xsl:attribute name="collection">
                                    <xsl:text>yes</xsl:text>
                                </xsl:attribute>
                            </xsl:if>
                            <xsl:text>mixed material</xsl:text>
                        </typeOfResource>  
                        <genre>
                            <xsl:value-of select="."/>
                        </genre>
                    </xsl:when>
                    <xsl:when test="string(text()) = 'Project Plan'">
                        <typeOfResource>
                            <xsl:if test="$collection='true'">
                                <xsl:attribute name="collection">
                                    <xsl:text>yes</xsl:text>
                                </xsl:attribute>
                            </xsl:if>
                            <xsl:text>text</xsl:text>
                        </typeOfResource>
                        <genre>
                            <xsl:value-of select="."/>
                        </genre>
                    </xsl:when>
                    <xsl:when test="string(text()) = 'Recording, oral'">
                        <typeOfResource>
                            <xsl:if test="$collection='true'">
                                <xsl:attribute name="collection">
                                    <xsl:text>yes</xsl:text>
                                </xsl:attribute>
                            </xsl:if>
                            <xsl:text>sound recording</xsl:text>
                        </typeOfResource>
                        <genre authority="gmgpc" authorityURI="tgm009871">
                            <xsl:text>sound recording</xsl:text>
                        </genre>
                    </xsl:when>
                    <xsl:when test="string(text()) = 'Technical Report'">
                        <typeOfResource>
                            <xsl:if test="$collection='true'">
                                <xsl:attribute name="collection">
                                    <xsl:text>yes</xsl:text>
                                </xsl:attribute>
                            </xsl:if>
                            <xsl:text>text</xsl:text>
                        </typeOfResource>
                        <genre authority="lcgft" authorityURI="gf2015026093">
                            <xsl:text>technical report</xsl:text>
                        </genre>
                    </xsl:when>
                    <xsl:when test="string(text()) = 'Working Paper'">
                        <typeOfResource>
                            <xsl:if test="$collection='true'">
                                <xsl:attribute name="collection">
                                    <xsl:text>yes</xsl:text>
                                </xsl:attribute>
                            </xsl:if>
                            <xsl:text>text</xsl:text>
                        </typeOfResource>
                        <genre>
                            <xsl:value-of select="."/>
                        </genre>
                    </xsl:when>
                    <xsl:otherwise>
                            <genre>
                                <xsl:value-of select="."/>
                            </genre>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>   
    <xsl:template match="dcvalue[@element='type'][@qualifier='architectural']">
        <genre>
            <xsl:value-of select="."/>
        </genre>
    </xsl:template>

    <xsl:template match="dcvalue[@element='source']">
        <relatedItem type="host" displayLabel="collection">
            <xsl:apply-templates/>
        </relatedItem>
    </xsl:template>
    
   
    <xsl:template match="dcterms[@elements='rights'][@qualifier='none']">
        <accessCondition type="useAndReproduction">
            <xsl:apply-templates/>
        </accessCondition>
    </xsl:template>
    
    <xsl:template match="dcvalue[@elements='rights'][@qualifier='uri']">
        <accessCondition>
            <variable name="xlink:simpleLink">
                 <xsl:value-of select="."/>                         
            </variable>
            <xsl:apply-templates/>
        </accessCondition>
    </xsl:template>
    
    
    
</xsl:stylesheet>
    
