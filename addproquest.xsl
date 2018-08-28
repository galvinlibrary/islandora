<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:xlink="http://www.w3.org/1999/xlink"
    version="2.0">
    
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
                <xsl:element name="dcvalue">
                    <xsl:attribute name="element">description</xsl:attribute>
                    <xsl:attribute name="qualifier">none</xsl:attribute>
                    <xsl:attribute name="language">en_US</xsl:attribute>
                    <xsl:value-of select="."/>
                </xsl:element>
            </xsl:for-each>
            
        <xsl:for-each select="document('proquest.xml')/DISS_submission/DISS_description/DISS_categorization/DISS_keyword">
            <xsl:variable name="term" select="."/>  
            <xsl:variable name="firstLetter" select="substring($term,1,1)"/>
       <!--    <dcvalue element="subject" qualifier="none" language="en_US">   -->
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
            <!--  </dcvalue>   -->
        </xsl:for-each>
        </dublin_core>
    </xsl:template>
            
      <xsl:template name="tokenize">
                <xsl:param name="text"/> 
                <xsl:param name="comma" select="', '"/>  
                <xsl:param name="semicolon" select="'; '"/>
                <xsl:choose>                      
                    <xsl:when test="contains($text, $comma)">      
                        <dcvalue element="subject" qualifier="none" language="en_US">
                            <xsl:value-of select="substring-before($text, $comma)"/>
                        </dcvalue> 
                        <!--recursive call -->
                        <xsl:call-template name="tokenize">
                            <xsl:with-param name="text" select="substring-after($text, $comma)" />
                        </xsl:call-template>   
                    </xsl:when>
                    <xsl:when test="contains($text, $semicolon)">  
                        <dcvalue element="subject" qualifier="none" language="en_US">
                            <xsl:value-of select="substring-before($text, $semicolon)"/>
                        </dcvalue>  
                        <!--recursive call -->
                        <xsl:call-template name="tokenize">
                            <xsl:with-param name="text" select="substring-after($text, $semicolon)" />
                        </xsl:call-template>   
                 </xsl:when>
                <xsl:otherwise>
                    <dcvalue element="subject" qualifier="none" language="en_US">
                       <xsl:value-of select="$text"/>
                    </dcvalue>
               </xsl:otherwise>    
         </xsl:choose>    
     </xsl:template>        
    
    <xsl:template name="printSubject">
        <xsl:param name="text"/>
        <topic>
            <xsl:value-of select="$text"/>                 
        </topic>
    </xsl:template>

</xsl:stylesheet>