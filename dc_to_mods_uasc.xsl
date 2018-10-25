<?xml version="1.0" encoding="UTF-8"?>	
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
    xmlns:dc="http://purl.org/dc/elements/1.1/" 
    xmlns:sru_dc="info:srw/schema/1/dc-schema" 
    xmlns:oai_dc="http://www.openarchives.org/OAI/2.0/oai_dc/" 
    xmlns:xlink="http://www.w3.org/1999/xlink" xmlns="http://www.loc.gov/mods/v3" 
    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" exclude-result-prefixes="sru_dc oai_dc dc" 
    version="2.0">
    
    <!-- This template transforms Dublin Core metadata from repository.iit DSpace instance to MODS version 3. Created August 2018-->
    <!-- customized for UASC -->
    
    <!-- Fields defined in Islandora Metadata Registry and DC and MODS crosswalks Google sheets -->
    <!-- URIs added for controlled vocabularies whenever possible -->    
    
    <!-- Will need to add MIME type, see internetMediaType element -->
    
    <xsl:output method="xml" indent="yes" encoding="UTF-8"/>
   
    <xsl:param name="genreTerm" select="."/>  

    <xsl:template match="dublin_core"> <!-- creates MODS top element wrapper-->
        <mods version="3.7" xmlns="http://www.loc.gov/mods/v3" 
            xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" 
            xsi:schemaLocation="http://www.loc.gov/mods/v3 http://www.loc.gov/standards/mods/v3/mods-3-7.xsd">
            <xsl:call-template name="dcMain"/> <!-- calls template-->                        
            <physicalDescription>
                <!-- Hard coded reformatted digital since most UASC content are reformatted digital-->
                <digitalOrigin>reformatted digital</digitalOrigin>
                <internetMediaType>
                    <!-- MIME type, pull from file information -->
                </internetMediaType>   
            </physicalDescription>
            <!-- Hard coded In Copyright - Educational Use Permitted but should evaluate before applying -->
            <accessCondition type='useAndReproduction' displayLabel='rightsstatements.org'>In Copyright - Educational Use Permitted</accessCondition>
            <accessCondition type='useAndReproduction' displayLabel='rightsstatements.orgURI'>http://rightsstatements.org/vocab/InC-EDU/1.0/</accessCondition>
        </mods>

    </xsl:template>  
    <xsl:template name="dcMain"> <!-- Main template, applies a template for each Dublin Core element. 
        Formatted to match DSpace Dublin Core elements -->
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
        <xsl:apply-templates select="dcvalue[@element='relation'][@qualifier='isversionof']"/>
        <xsl:apply-templates select="dcvalue[@element='relation'][@qualifier='ispartofseries']"/>
        <xsl:apply-templates select="dcvalue[@element='relation'][@qualifier='uri']"/>
        <xsl:apply-templates select="dcvalue[@element='relation'][@qualifier='none']"/>
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
                <roleTerm type="text" authority="marcrelator" authorityURI="http://id.loc.gov/vocabulary/relators" valueURI="http://id.loc.gov/vocabulary/relators/ths">
                    <xsl:text>advisor</xsl:text>
                </roleTerm>
            </role>
            <namePart>
                <xsl:apply-templates/>
            </namePart>           
        </name>
    </xsl:template>
    
    <!-- Keep first letter of each word in the name capitalized, lower case the rest -->
    <xsl:template match="dcvalue[@element='contributor'][@qualifier='author']">
        <name>
            <role>
                <roleTerm type="text" authority="marcrelator" authorityURI="http://id.loc.gov/vocabulary/relators" valueURI="http://id.loc.gov/vocabulary/relators/cre">
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
                <roleTerm type="text" authority="marcrelator" authorityURI="http://id.loc.gov/vocabulary/relators" valueURI="http://id.loc.gov/vocabulary/relators/edt">
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
                <roleTerm type="text" authority="marcrelator" authorityURI="http://id.loc.gov/vocabulary/relators" valueURI="http://id.loc.gov/vocabulary/relators/ctb">
                    <xsl:text>contributor</xsl:text>
                </roleTerm>
            </role>
            <namePart>
                <xsl:apply-templates/>
            </namePart>
        </name>
    </xsl:template>
    
    <xsl:template match="dcvalue[@element='coverage'][@qualifier='spatial']">
        <subject authority="naf" authorityURI="http://id.loc.gov/authorities/names">
            <geographic>
                <xsl:apply-templates/>
            </geographic>
        </subject>
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
        <xsl:call-template name ="splitDatesIssued">
            <xsl:with-param name="dates" select="."/>
        </xsl:call-template>
        </originInfo>
    </xsl:template>
    
    <!-- If the date element contains a range (YYYY-YYYY) then date segments are pulled into 
        separate date elements with start/end attributes-->
    <xsl:template name="splitDatesIssued">
        <xsl:param name="dates"/>
        <xsl:param name="dash" select="'-'"/>
        <xsl:choose>
            <xsl:when test="translate(., '123456789', '000000000') = '0000-0000'">
                <dateIssued encoding='iso8601' point='start'>
                    <xsl:value-of select="substring-before($dates, $dash)"/>
                </dateIssued>
                <dateIssued encoding='iso8601' point='end'>
                    <xsl:value-of select="substring-after($dates, $dash)" />
                </dateIssued>
            </xsl:when>
            <xsl:otherwise>
                <dateIssued>
                    <xsl:value-of select="$dates"/>
                </dateIssued>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>   
    
    <!-- Date with no attribute maps to dateCreated-->
    <xsl:template match="dcvalue[@element='date'][@qualifier='none']">
        <originInfo>
            <xsl:call-template name ="splitDates">
                <xsl:with-param name="dates" select="."/>
            </xsl:call-template>
        </originInfo>
    </xsl:template>
    
    <!-- If the date element contains a range (YYYY-YYYY) then date segments are pulled into 
        separate date elements with start/end attributes-->     
    <xsl:template name="splitDates">
        <xsl:param name="dates"/>
        <xsl:param name="dash" select="'-'"/>
        <xsl:choose>
            <xsl:when test="translate(., '123456789', '000000000') = '0000-0000'">
                <dateCreated keyDate="yes" encoding='iso8601' point='start'>
                    <xsl:value-of select="substring-before($dates, $dash)"/>
                </dateCreated>
                <dateCreated keyDate="yes" encoding='iso8601' point='end'>
                    <xsl:value-of select="substring-after($dates, $dash)" />
                </dateCreated>
            </xsl:when>
            <xsl:otherwise>
                <dateCreated keyDate="yes">
                    <xsl:value-of select="$dates"/>
                </dateCreated>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>   
    
    <xsl:template match="dcvalue[@element='description'][@qualifier='abstract']">
        <abstract>
            <xsl:value-of select="normalize-space(.)" />          
        </abstract>
    </xsl:template>
    <xsl:template match="dcvalue[@element='description'][@qualifier='none']">
        <abstract>
            <xsl:value-of select="normalize-space(.)" />
        </abstract>
    </xsl:template>
    <xsl:template match="dcvalue[@element='description'][@qualifier='provenance']">
        <note type="provenance">
            <xsl:value-of select="normalize-space(.)" />
        </note>
    </xsl:template>
    <xsl:template match="dcvalue[@element='description'][@qualifier='sponsorship']">
        <note type="funding">
            <xsl:apply-templates/>
        </note>
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
        </physicalDescription>       
    </xsl:template>
   
        
  
    <!--Related item: For migrated records: if relation element exists, it is either another version published elsewhere on internet, or is part of a series (patents) --> 
    <!-- UPDATED: Commented out 9/2018. All related items from DSpace go into relatedItem/identifier regardless of attribute.
    <xsl:template match="dcvalue[@element='relation'][@qualifier='uri']"> 
        <relatedItem type='otherVersion'>
            <location>
                <url>
                    <xsl:value-of select="."/>
                </url>
            </location>
        </relatedItem>
    </xsl:template>
    <xsl:template match="dcvalue[@element='relation'][@qualifier='isversionof']"> 
        <relatedItem type='otherVersion'>
            <location>
                <url>
                    <xsl:value-of select="."/>
                </url>
            </location>
        </relatedItem>
    </xsl:template>
    <xsl:template match="dcvalue[@element='relation'][@qualifier='hasversion']"> 
        <relatedItem type='otherVersion'>
            <location>
                <url>
                    <xsl:value-of select="."/>
                </url>
            </location>
        </relatedItem>
    </xsl:template>
    <xsl:template match="dcvalue[@element='relation'][@qualifier='ispartseries']"> 
        <relatedItem type='host'>
            <titleInfo>
                <title>
                    <xsl:value-of select="."/>
                </title>
            </titleInfo>
        </relatedItem>
    </xsl:template>    
        
        <xsl:template match="dcvalue[@element='related'][@qualifier='none']">
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
                    <relatedItem type="host" displayLabel="collection">
                        <titleInfo>
                            <title><xsl:value-of select="."/></title>
                        </titleInfo>                      
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
    </xsl:template> -->
    <xsl:template match="dcvalue[@element='identifier'][@qualifier='citation']">
        <relatedItem type="otherFormat">
            <identifier>
                <xsl:apply-templates/>
            </identifier>
        </relatedItem>
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
        <xsl:choose>
            <xsl:when test="starts-with(text(),'http://hdl.')">
                <identifier type="hdl">
                    <xsl:apply-templates/>
                </identifier>
            </xsl:when>
            <xsl:otherwise>
                <relation type="otherFormat">
                    <identifier>
                        <xsl:apply-templates/>
                    </identifier>
                </relation>
            </xsl:otherwise>
        </xsl:choose>
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
        <!--All DSpace Library and Archives migrated items with Relation elements have values that begin with "http://"-->
            <relatedItem type="otherFormat">
                <identifier>
                   <xsl:apply-templates/>
                </identifier>
            </relatedItem>
    </xsl:template>
    
    <xsl:template match="dcvalue[@element='rights'][@qualifier='none']">
        <accessCondition type="useAndReproduction" displayLabel='cc'>
            <xsl:apply-templates/>
        </accessCondition>
    </xsl:template>
    
    <xsl:template match="dcvalue[@element='rights'][@qualifier='uri']">
        <accessCondition type='useAndReproduction' displayLabel='ccURI'> 
            <xsl:apply-templates/>
        </accessCondition>
    </xsl:template>
    
    <!--Takes collection name from Source, maps to relatedItem>titleInfo>title-->
    <xsl:template match="dcvalue[@element='source']">
        <relatedItem type="host" displayLabel="Collection">
            <titleInfo>
                <title>
                    <xsl:apply-templates/>
                </title>
            </titleInfo>           
        </relatedItem>
    </xsl:template>    
    
    <!--If subject value is multiple terms concatenated with a comma or semicolon, split the terms into individual elements ("tokenize")-->
    <xsl:template match="dcvalue[@element='subject']">
        <xsl:variable name="term" select="."/>  
        <xsl:variable name="firstLetter" select="substring($term,1,1)"/>
        <subject>
            <xsl:choose>
                    <xsl:when test="$firstLetter = translate($firstLetter, 'ABCDEFGHIJKLMNOPQRSTUVWXYZ', 'abcdefghijklmnopqrstuvwxyz')">
                        <xsl:choose>
                            <xsl:when test="contains($term,',') or contains($term,';')">                             
                                <xsl:call-template name="tokenize">
                                    <xsl:with-param name="text" select="$term"/>   
                                </xsl:call-template>                                     
                            </xsl:when>
                            <xsl:otherwise>                       
                                <xsl:call-template name="tokenize">
                                    <xsl:with-param name="text" select="$term"/>   
                               </xsl:call-template>                                          
                            </xsl:otherwise>
                        </xsl:choose>              
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:call-template name="printSubject">
                            <xsl:with-param name="text" select="$term"/>
                        </xsl:call-template>
                    </xsl:otherwise>
            </xsl:choose>
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
    
    <xsl:template name="printSubject">
        <xsl:param name="text"/>
        <topic>
            <xsl:value-of select="$text"/>                 
        </topic>
    </xsl:template>
    
    <xsl:template match="dcvalue[@element='type']">
        <!--2.0: Variable test for any dc:type with value of collection for mods:typeOfResource -->
        <!-- Transforms DC type value to typeOfResource controlled vocabulary value--> 
        <xsl:param name="genreTerm" select="."/>        
        <xsl:variable name="collection">
            <xsl:if test="../dc:dcvalue[@element='type'][string(text()) = 'collection' or string(text()) = 'Collection']">true</xsl:if>
        </xsl:variable>
        <xsl:choose>
            <xsl:when test="contains(text(), 'Collection') or contains(text(), 'collection')">
                <typeOfResource authority="dct" authorityURI="http://purl.org/dc/terms" valueURI="http://purl.org/dc/dcmitype/Collection">
                    <xsl:text>Collection</xsl:text>
                </typeOfResource>
            </xsl:when>
            <xsl:otherwise>
                <!-- dc.type to mods.typeOfResource is based on LOC Dublin Core Metadata Element Set Mapping to MODS Version 3 mapping at  -->
                <xsl:choose>
                    <xsl:when test="string(text()) = 'Dataset' or string(text()) = 'dataset'">
                        <typeOfResource authority="coar" valueURI="http://purl.org/coar/resource_type/c_ddb1">
                            <xsl:if test="$collection='true'">
                                <xsl:attribute name="collection">
                                    <xsl:text>yes</xsl:text>
                                </xsl:attribute>
                            </xsl:if>	
                            <xsl:text>Dataset</xsl:text>
                        </typeOfResource>                      
                    </xsl:when>
                    <xsl:when test="string(text()) = 'Article' or string(text()) = 'article'">
                        <typeOfResource authority="aat" valueURI="http://vocab.getty.edu/aat/300048715">
                            <xsl:if test="$collection='true'">
                                <xsl:attribute name="collection">
                                    <xsl:text>yes</xsl:text>
                                </xsl:attribute>
                            </xsl:if>	
                            <xsl:text>Article</xsl:text>
                        </typeOfResource>                      
                    </xsl:when>
                    <xsl:when test="string(text()) = 'Book' or string(text()) = 'book'">
                        <typeOfResource authority="coar" valueURI="http://purl.org/coar/resource_type/c_2f33">
                            <xsl:if test="$collection='true'">
                                <xsl:attribute name="collection">
                                    <xsl:text>yes</xsl:text>
                                </xsl:attribute>
                            </xsl:if>	
                            <xsl:text>Book</xsl:text>
                        </typeOfResource>                       
                    </xsl:when>
                    <xsl:when test="string(text()) = 'Book chapter' or string(text()) = 'book chapter'">
                        <typeOfResource authority="coar" valueURI="http://purl.org/coar/resource_type/c_3248">
                            <xsl:if test="$collection='true'">
                                <xsl:attribute name="collection">
                                    <xsl:text>yes</xsl:text>
                                </xsl:attribute>
                            </xsl:if>	
                            <xsl:text>Book part</xsl:text>
                        </typeOfResource>
                    </xsl:when>
                    <xsl:when test="string(text()) = 'Deliverable' or string(text()) = 'deliverable'">
                        <typeOfResource authority="coar" valueURI="http://purl.org/coar/resource_type/c_18op">
                            <xsl:if test="$collection='true'">
                                <xsl:attribute name="collection">
                                    <xsl:text>yes</xsl:text>
                                </xsl:attribute>
                            </xsl:if>	
                            <xsl:text>Project deliverable</xsl:text>
                        </typeOfResource>
                    </xsl:when>
                    <xsl:when test="string(text()) = 'Dissertation' or string(text()) = 'dissertation'">
                        <typeOfResource authority="aat" valueURI="http://vocab.getty.edu/page/aat/300028029">
                            <xsl:if test="$collection='true'">
                                <xsl:attribute name="collection">
                                    <xsl:text>yes</xsl:text>
                                </xsl:attribute>
                            </xsl:if>	
                            <xsl:text>Dissertation</xsl:text>
                        </typeOfResource>
                    </xsl:when>
                    <xsl:when test="string(text()) = 'Image' or string(text()) = 'image'">
                        <typeOfResource authority="coar" valueURI="http://purl.org/coar/resource_type/c_ecc8">
                            <xsl:if test="$collection='true'">
                                <xsl:attribute name="collection">
                                    <xsl:text>yes</xsl:text>
                                </xsl:attribute>
                            </xsl:if>
                            <xsl:text>Still image</xsl:text>
                        </typeOfResource>
                    </xsl:when>
                    <xsl:when test="string(text()) = 'Software' or string(text()) = 'software'">
                        <typeOfResource authority="coar" valueURI="http://purl.org/coar/resource_type/c_5ce6">
                            <xsl:if test="$collection='true'">
                                <xsl:attribute name="collection">
                                    <xsl:text>yes</xsl:text>
                                </xsl:attribute>
                            </xsl:if>
                            <xsl:text>Software</xsl:text>
                        </typeOfResource>
                    </xsl:when>
                    
                    <xsl:when test="string(text()) = 'Image, Moving' or string(text()) = 'image, moving' or string(text()) = 'Video' or string(text()) = 'video'">
                        <typeOfResource authority="coar" valueURI="http://purl.org/coar/resource_type/c_8a7e">
                            <xsl:if test="$collection='true'">
                                <xsl:attribute name="collection">
                                    <xsl:text>yes</xsl:text>
                                </xsl:attribute>
                            </xsl:if>
                            <xsl:text>Moving image</xsl:text>
                        </typeOfResource>
                    </xsl:when>
                    
                    <xsl:when test="string(text()) = 'Image, 3-D' or string(text()) = 'image, 3-D'">
                        <typeOfResource authority="coar" valueURI="http://purl.org/coar/resource_type/c_ecc8">
                            <xsl:if test="$collection='true'">
                                <xsl:attribute name="collection">
                                    <xsl:text>yes</xsl:text>
                                </xsl:attribute>
                            </xsl:if>
                            <xsl:text>Still image</xsl:text>
                        </typeOfResource>
                    </xsl:when>
                    <xsl:when test="string(text()) = 'Master&amp;apos;s Project'">
                        <typeOfResource>
                            <xsl:if test="$collection='true'">
                                <xsl:attribute name="collection">
                                    <xsl:text>yes</xsl:text>
                                </xsl:attribute>
                            </xsl:if>
                            <xsl:text>Master's project</xsl:text>
                        </typeOfResource>        
                    </xsl:when>
                    
                    <xsl:when test="string(text()) = 'Patent' or string(text()) = 'patent'">
                        <typeOfResource authority="gmgpc" valueURI="http://id.loc.gov/vocabulary/graphicMaterials/tgm007520">
                            <xsl:if test="$collection='true'">
                                <xsl:attribute name="collection">
                                    <xsl:text>yes</xsl:text>
                                </xsl:attribute>
                            </xsl:if>
                            <xsl:text>Patent</xsl:text>
                        </typeOfResource>
                    </xsl:when>
                    <xsl:when test="string(text()) = 'Photographs' or string(text()) = 'photographs' or string(text()) = 'photograph' or string(text()) = 'Photograph'">
                        <typeOfResource authority="coar" valueURI="ttp://purl.org/coar/resource_type/c_ecc8">
                            <xsl:if test="$collection='true'">
                                <xsl:attribute name="collection">
                                    <xsl:text>yes</xsl:text>
                                </xsl:attribute>
                            </xsl:if>
                            <xsl:text>Still image</xsl:text>
                        </typeOfResource>
                        <!-- photograph as Type value in DC maps to Form in MODS -->
                        <physicalDescription>
                            <form authority="aat" valueURI="http://vocab.getty.edu/page/aat/300046300">Photographs</form>
                        </physicalDescription>
                    </xsl:when>
                    <xsl:when test="string(text()) = 'Plan or blueprint'">
                        <typeOfResource authority="lcgft" valueURI="http://id.loc.gov/authorities/genreForms/gf2017027217">
                            <xsl:if test="$collection='true'">
                                <xsl:attribute name="collection">
                                    <xsl:text>yes</xsl:text>
                                </xsl:attribute>
                            </xsl:if>
                            <xsl:text>Architectural drawing</xsl:text>
                        </typeOfResource>
                    </xsl:when>
                    <xsl:when test="string(text()) = 'StillImage' or string(text()) = 'stillimage' or string(text()) = 'Still Image' or string(text()) = 'still image' or string(text()) = 'stillImage' or string(text()) = 'Still image' ">
                        <typeOfResource authority="coar" valueURI="ttp://purl.org/coar/resource_type/c_ecc8">
                            <xsl:if test="$collection='true'">
                                <xsl:attribute name="collection">
                                    <xsl:text>yes</xsl:text>
                                </xsl:attribute>
                            </xsl:if>
                            <xsl:text>Still image</xsl:text>
                        </typeOfResource>
                    </xsl:when>
                    <xsl:when test="string(text()) = 'Text' or string(text()) = 'text'">
                        <typeOfResource authority="coar" valueURI="http://purl.org/coar/resource_type/c_18cf">
                            <xsl:if test="$collection='true'">
                                <xsl:attribute name="collection">
                                    <xsl:text>yes</xsl:text>
                                </xsl:attribute>
                            </xsl:if>
                            <xsl:text>Text</xsl:text>
                        </typeOfResource>
                    </xsl:when>
                    <xsl:when test="string(text()) = 'Thesis' or string(text()) = 'thesis'">
                        <typeOfResource authority="coar" valueURI="http://purl.org/coar/resource_type/c_46ec">
                            <xsl:if test="$collection='true'">
                                <xsl:attribute name="collection">
                                    <xsl:text>yes</xsl:text>
                                </xsl:attribute>
                            </xsl:if>
                            <xsl:text>Thesis</xsl:text>
                        </typeOfResource>
                    </xsl:when>
                    <xsl:when test="string(text()) = 'Poster' or string(text()) = 'poster'">
                        <typeOfResource authority="gmgpc" valueURI="http://id.loc.gov/vocabulary/graphicMaterials/tgm008104">
                            <xsl:if test="$collection='true'">
                                <xsl:attribute name="collection">
                                    <xsl:text>yes</xsl:text>
                                </xsl:attribute>
                            </xsl:if>
                            <xsl:text>Mixed material</xsl:text>
                        </typeOfResource>
                    </xsl:when>
                    <xsl:when test="string(text()) = 'Preprint' or string(text()) = 'preprint'">
                        <typeOfResource authority="aat" valueURI="http://vocab.getty.edu/aat/300048715">
                            <xsl:if test="$collection='true'">
                                <xsl:attribute name="collection">
                                    <xsl:text>yes</xsl:text>
                                </xsl:attribute>
                            </xsl:if>
                            <xsl:text>Article</xsl:text>
                        </typeOfResource>
                    </xsl:when>
                    <xsl:when test="string(text()) = 'Presentation' or string(text()) = 'presentation'">
                        <typeOfResource>
                            <xsl:if test="$collection='true'">
                                <xsl:attribute name="collection">
                                    <xsl:text>yes</xsl:text>
                                </xsl:attribute>
                            </xsl:if>
                            <xsl:text>Presentation</xsl:text>
                        </typeOfResource> 
                    </xsl:when>
                    
                    <xsl:when test="string(text()) = 'Project' or string(text()) = 'project'">
                        <typeOfResource authority="coar" valueURI="http://purl.org/coar/resource_type/c_18op">
                            <xsl:if test="$collection='true'">
                                <xsl:attribute name="collection">
                                    <xsl:text>yes</xsl:text>
                                </xsl:attribute>
                            </xsl:if>
                            <xsl:text>Project deliverable</xsl:text>
                        </typeOfResource>  
                    </xsl:when>
                    
                    <xsl:when test="string(text()) = 'Project Plan'">
                        <typeOfResource authority="coar" valueURI="http://purl.org/coar/resource_type/c_18op">
                            <xsl:if test="$collection='true'">
                                <xsl:attribute name="collection">
                                    <xsl:text>yes</xsl:text>
                                </xsl:attribute>
                            </xsl:if>
                            <xsl:text>Project deliverable</xsl:text>
                        </typeOfResource>
                    </xsl:when>
                    <xsl:when test="string(text()) = 'Recording, oral'">
                        <typeOfResource authority="coar" valueURI="http://purl.org/coar/resource_type/c_26e4">
                            <xsl:if test="$collection='true'">
                                <xsl:attribute name="collection">
                                    <xsl:text>yes</xsl:text>
                                </xsl:attribute>
                            </xsl:if>
                            <xsl:text>Interview</xsl:text>
                        </typeOfResource>
                    </xsl:when>                    
                    <xsl:when test="string(text()) = 'Technical Report' or 'technical report'">
                        <typeOfResource authority="coar" valueURI="http://purl.org/coar/resource_type/c_18gh">
                            <xsl:if test="$collection='true'">
                                <xsl:attribute name="collection">
                                    <xsl:text>yes</xsl:text>
                                </xsl:attribute>
                            </xsl:if>
                            <xsl:text>Technical report</xsl:text>
                        </typeOfResource>
                    </xsl:when>                   
                    <xsl:when test="string(text()) = 'Working Paper'">
                        <typeOfResource authority="coar" valueURI="http://purl.org/coar/resource_type/c_8042">
                            <xsl:if test="$collection='true'">
                                <xsl:attribute name="collection">
                                    <xsl:text>yes</xsl:text>
                                </xsl:attribute>
                            </xsl:if>
                            <xsl:text>Working paper</xsl:text>
                        </typeOfResource>
                    </xsl:when>                    
                    <xsl:otherwise>
                        <typeOfResource>                                                       
                            <xsl:value-of select="concat(translate(substring($genreTerm, 1, 1), 'abcdefghijklmnopqrstuvwxyz', 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'), substring($genreTerm, 2))"/>
                        </typeOfResource>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>                               
</xsl:stylesheet>