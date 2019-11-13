<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs"
    version="2.0">
    
    <xsl:strip-space elements="*"/>
    <xsl:output indent="yes"/>
    
    <xsl:template match="records">
       <xsl:for-each-group select="*" group-starting-with="record">
           <new_doc>
               <xsl:copy-of select="current-group()"/>
           </new_doc>
       </xsl:for-each-group>
        
    </xsl:template>
    
</xsl:stylesheet>
