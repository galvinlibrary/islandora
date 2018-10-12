<?xml version="1.0" encoding="UTF-8"?>	
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
    xmlns:dc="http://purl.org/dc/elements/1.1/" 
    xmlns:sru_dc="info:srw/schema/1/dc-schema" 
    xmlns:oai_dc="http://www.openarchives.org/OAI/2.0/oai_dc/" 
    xmlns:xlink="http://www.w3.org/1999/xlink" xmlns="http://www.loc.gov/mods/v3" 
    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" exclude-result-prefixes="sru_dc oai_dc dc" 
    version="2.0">
    
    <xsl:output method="xml" indent="yes" encoding="UTF-8"/>
    
    <xsl:template match="dublin_core">
        <mods version="3.4" xmlns="http://www.loc.gov/mods/v3" 
            xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" 
            xsi:schemaLocation="http://www.loc.gov/mods/v3 http://www.loc.gov/standards/mods/v3/mods-3-4.xsd">
            <xsl:call-template name="dcMain"/>                
            <physicalDescription>
                <digitalOrigin>born digital</digitalOrigin>
                <internetMediaType>application/pdf</internetMediaType>           
            </physicalDescription>
            <accessCondition type='useAndReproduction' displayLabel='rightsstatements.org'>In Copyright</accessCondition>
            <accessCondition type='useAndReproduction' displayLabel='rightsstatements.orgURI'>http://rightsstatements.org/page/InC/1.0/</accessCondition>
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
        <xsl:apply-templates select="dcvalue[@element='date'][@qualifier='copyright']"/>
        <xsl:apply-templates select="dcvalue[@element='date'][@qualifier='issued']"/>
        <xsl:apply-templates select="dcvalue[@element='embargo'][@qualifier='terms']"/>
        <xsl:apply-templates select="dcvalue[@element='format'][@qualifier='original']"/>
        <xsl:apply-templates select="dcvalue[@element='identifier'][@qualifier='isbn']"/>
        <xsl:apply-templates select="dcvalue[@element='identifier'][@qualifier='issn']"/>
        <xsl:apply-templates select="dcvalue[@element='identifier'][@qualifier='pn']"/>
        <xsl:apply-templates select="dcvalue[@element='identifier'][@qualifier='uri']"/>
        <xsl:apply-templates select="dcvalue[@element='identifier'][@qualifier='other']"/>
        <xsl:apply-templates select="dcvalue[@element='identifier'][@qualifier='none']"/>
        <xsl:apply-templates select="dcvalue[@element='identifier'][@qualifier='citation']"/>
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
                    <xsl:call-template name="capitalize">
                        <xsl:with-param name="text" select="." />
                    </xsl:call-template>	                  
            </namePart>          
        </name>
    </xsl:template>

    <xsl:template name="capitalize">
        <xsl:param name="text"/>
        <xsl:param name="delimiter" select="' '"/>
        
        <xsl:variable name="upper-case" select="'ABCDEFGHIJKLMNOPQRSTUVWXYZ'"/>
        <xsl:variable name="lower-case" select="'abcdefghijklmnopqrstuvwxyz'"/>
        
        <xsl:variable name="word" select="substring-before(concat($text, $delimiter), $delimiter)" />
        <xsl:if test="$word">
            <xsl:value-of select="translate(substring($word, 1, 1), $lower-case, $upper-case)"/>    
            <xsl:value-of select="translate(substring($word, 2), $upper-case, $lower-case)"/>
        </xsl:if>
        <xsl:if test="contains($text, $delimiter)">
            <xsl:value-of select="$delimiter"/>
            <!-- recursive call -->
            <xsl:call-template name="capitalize">
                <xsl:with-param name="text" select="substring-after($text, $delimiter)"/>
            </xsl:call-template>
        </xsl:if>
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
    
    <xsl:template match="dcvalue[@element='date'][@qualifier='none']">
        <originInfo>
            <xsl:call-template name ="splitDates">
                <xsl:with-param name="dates" select="."/>
            </xsl:call-template>
        </originInfo>
    </xsl:template>
        
    <xsl:template name="splitDates">
        <xsl:param name="dates"/>
        <xsl:param name="dash" select="'-'"/>
        <xsl:choose>
            <xsl:when test="translate(., '123456789', '000000000') = '0000-0000'">
                <dateCreated encoding='iso8601' point='start'>
                    <xsl:value-of select="substring-before($dates, $dash)"/>
                </dateCreated>
                <dateCreated encoding='iso8601' point='end'>
                    <xsl:value-of select="substring-after($dates, $dash)" />
                </dateCreated>
            </xsl:when>
            <xsl:otherwise>
                <dateCreated>
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
        <!-- coded born digital since most migrated material is from IR -->      
        
  
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
    
    <!-- identifier/citation from DSpace contains DOIs so mapping to relatedItem/identifier (see other mapping below) -->
    <xsl:template match="dcvalue[@element='identifier'][@qualifier='citation']">
        <relatedItem type="otherFormat">
            <identifier>
                <xsl:apply-templates/>
            </identifier>
        </relatedItem>
    </xsl:template>
   
    <xsl:template match="dcvalue[@element='identifier'][@qualifier='isbn']">
        <identifier>                              
            <xsl:attribute name="type"> 
                <xsl:text>isbn</xsl:text>  
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
        <!--Most values in this DSpace elements are DOIs of other versions. Also some repeated patent numbers. Not all web links.
        Changed from relatedItem/location/url on 2018-09-11 -->
        <relatedItem>
            <identifier type="otherFormat">
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
    <xsl:template match="dcvalue[@element='source']">
        <relatedItem type="host" displayLabel="Collection">
            <titleInfo>
                <title>
                    <xsl:apply-templates/>
                </title>
            </titleInfo>           
        </relatedItem>
    </xsl:template>    
    
    <xsl:template match="dcvalue[@element='subject']">
        <xsl:variable name="term" select="."/>  
        <xsl:variable name="firstLetter" select="substring($term,1,1)"/>
        <subject>
            <xsl:choose>
  
                   <xsl:when test="contains($term,',') or contains($term,';')">                             
                         <xsl:call-template name="tokenize">
                               <xsl:with-param name="text" select="$term"/>   
                         </xsl:call-template>                                     
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
        <xsl:param name="comma" select="', '"/>  
        <xsl:param name="semicolon" select="'; '"/>
        <xsl:choose>                      
            <xsl:when test="contains($text, $comma)">      
                    <topic>
                        <xsl:value-of select="substring-before($text, $comma)"/>
                    </topic>      
                    <!--recursive call -->
                    <xsl:call-template name="tokenize">
                        <xsl:with-param name="text" select="substring-after($text, $comma)" />
                    </xsl:call-template>   
            </xsl:when>
            <xsl:when test="contains($text, $semicolon)">  
                <topic>
                    <xsl:value-of select="substring-before($text, $semicolon)"/>
                </topic>      
                <!--recursive call -->
                <xsl:call-template name="tokenize">
                    <xsl:with-param name="text" select="substring-after($text, $semicolon)" />
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
        <!-- Transforms DC type value to MODS typeOfResource controlled vocabulary value-->
        <!-- And and creates new genre element with original DC type value-->
        <!---Islandora SOLR index on genre value--> 
        <xsl:param name="genreTerm" select="."/>        
        <xsl:variable name="collection">
            <xsl:if test="../dc:dcvalue[@element='type'][string(text()) = 'collection' or string(text()) = 'Collection']">true</xsl:if>
        </xsl:variable>
        <xsl:choose>
            <xsl:when test="contains(text(), 'Collection') or contains(text(), 'collection')">
                <genre authority="dct" authorityURI="http://purl.org/dc/terms" valueURI="http://purl.org/dc/dcmitype/Collection">
                    <xsl:text>Collection</xsl:text>
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
                        <genre authority="coar" valueURI="http://purl.org/coar/resource_type/c_ddb1">
                            <xsl:text>Dataset</xsl:text>
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
                        <genre authority="aat" valueURI="http://vocab.getty.edu/aat/300048715">
                            <xsl:text>Article</xsl:text>
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
                        <genre authority="coar" valueURI="http://purl.org/coar/resource_type/c_2f33">
                            <xsl:text>Book</xsl:text>
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
                        <genre authority="coar" valueURI="http://purl.org/coar/resource_type/c_3248">
                            <xsl:text>Book part</xsl:text>
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
                        <genre authority="coar" valueURI="http://purl.org/coar/resource_type/c_18op">
                            <xsl:text>Project deliverable</xsl:text>
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
                        <genre authority="aat" valueURI="http://vocab.getty.edu/page/aat/300028029">
                            <xsl:text>dissertation</xsl:text>
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
                        <genre authority="coar" valueURI="http://purl.org/coar/resource_type/c_ecc8">
                            <xsl:text>Still image</xsl:text>
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
                        <genre authority="coar" valueURI="http://purl.org/coar/resource_type/c_5ce6">
                            <xsl:text>Software</xsl:text>
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
                        <genre authority="coar" valueURI="http://purl.org/coar/resource_type/c_8a7e">
                            <xsl:text>Moving image</xsl:text>
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
                        <genre authority="gmgpc" valueURI="http://id.loc.gov/vocabulary/graphicMaterials/tgm007159.html">
                            <xsl:text>Object</xsl:text>
                        </genre>
                    </xsl:when>
                    <xsl:when test="string(text()) = 'Master&amp;apos;s Project'">
                        <typeOfResource>
                            <xsl:if test="$collection='true'">
                                <xsl:attribute name="collection">
                                    <xsl:text>yes</xsl:text>
                                </xsl:attribute>
                            </xsl:if>
                            <xsl:text>mixed material</xsl:text>
                        </typeOfResource>
                        <genre>
                            <xsl:text>Master's project</xsl:text>
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
                        <genre authority="gmgpc" valueURI="http://id.loc.gov/vocabulary/graphicMaterials/tgm007520">
                            <xsl:text>Patent</xsl:text>
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
                        <genre authority="gmgpc" valueURI="http://id.loc.gov/vocabulary/graphicMaterials/tgm007721">
                            <xsl:text>Photograph</xsl:text>
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
                        <genre>
                            <xsl:value-of select="."/>
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
                        <genre authority="coar" valueURI="ttp://purl.org/coar/resource_type/c_ecc8">
                            <xsl:text>Still image</xsl:text>
                        </genre>
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
                        <genre authority="dct" valueURI="http://purl.org/dc/dcmitype/Text">
                            <xsl:text>Text</xsl:text>
                        </genre>
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
                        <genre authority="coar" valueURI="http://purl.org/coar/resource_type/c_46ec">
                            <xsl:text>Thesis</xsl:text>
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
                        <genre authority="gmgpc" valueURI="http://id.loc.gov/vocabulary/graphicMaterials/tgm008104">
                            <xsl:text>Poster</xsl:text>
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
                        <genre authority="aat" valueURI="http://vocab.getty.edu/aat/300048715">
                            <xsl:text>Article</xsl:text>
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
                        <genre authority="coar" valueURI="http://purl.org/coar/resource_type/c_18op">
                            <xsl:text>Project deliverable</xsl:text>
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
                        <genre authority="coar" valueURI="http://purl.org/coar/resource_type/c_18op">
                            <xsl:text>Project deliverable</xsl:text>
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
                        <genre authority="coar" valueURI="http://purl.org/coar/resource_type/c_18cc">
                            <xsl:text>Sound</xsl:text>
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
                        <genre authority="coar" valueURI="http://purl.org/coar/resource_type/c_18gh">
                            <xsl:text>Technical report</xsl:text>
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
                        <genre authority="coar" valueURI="http://purl.org/coar/resource_type/c_8042">
                            <xsl:text>Working paper</xsl:text>
                        </genre>
                    </xsl:when>
                    <xsl:otherwise>
                            <genre>                                                       
                                <xsl:value-of select="concat(translate(substring($genreTerm, 1, 1), 'abcdefghijklmnopqrstuvwxyz', 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'), substring($genreTerm, 2))"/>
                            </genre>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>       
</xsl:stylesheet>