<xsl:stylesheet version="1.0" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
	xmlns:mods="http://www.loc.gov/mods/v3" exclude-result-prefixes="mods"
	xmlns:dc="http://purl.org/dc/elements/1.1/"
	xmlns:srw_dc="info:srw/schema/1/dc-schema"
	xmlns:oai_dc="http://www.openarchives.org/OAI/2.0/oai_dc/"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

	<!-- Locally edited version of a Library of Congress XSLT for converting MODS records to DC OAI-->
	
	<!-- Available https://github.com/SedizioseVoci/XSLTs/blob/master/mods_to_dc_oai_version_2015-10-12.xsl-->
	
	<!--
This stylesheet transforms MODS version 3.2 records and collections of records to simple Dublin Core (DC) records,
based on the Library of Congress' MODS to simple DC mapping <http://www.loc.gov/standards/mods/mods-dcsimple.html>
The stylesheet will transform a collection of MODS 3.2 records into simple Dublin Core (DC)
as expressed by the SRU DC schema <http://www.loc.gov/standards/sru/dc-schema.xsd>
The stylesheet will transform a single MODS 3.2 record into simple Dublin Core (DC)
as expressed by the OAI DC schema <http://www.openarchives.org/OAI/2.0/oai_dc.xsd>
Because MODS is more granular than DC, transforming a given MODS element or subelement to a DC element frequently results in less precise tagging,
and local customizations of the stylesheet may be necessary to achieve desired results.
This stylesheet makes the following decisions in its interpretation of the MODS to simple DC mapping:
When the roleTerm value associated with a name is creator, then name maps to dc:creator
When there is no roleTerm value associated with name, or the roleTerm value associated with name is a value other than creator, then name maps to dc:contributor
Start and end dates are presented as span dates in dc:date and in dc:coverage
When the first subelement in a subject wrapper is topic, subject subelements are strung together in dc:subject with hyphens separating them
Some subject subelements, i.e., geographic, temporal, hierarchicalGeographic, and cartographics, are also parsed into dc:coverage
The subject subelement geographicCode is dropped in the transform
Revision 1.1	2007-05-18 <tmee@loc.gov>
		Added modsCollection conversion to DC SRU
		Updated introductory documentation
Version 1.0	2007-05-04 Tracy Meehleib <tmee@loc.gov>
-->
	
	<!--
		          Edited to ensure that genre terms in MODS are mapped to dc:format insted of dc:type.
		          Another edit suppresses all fields (e.g., notes) but the abstract from being shared with DPLA in dc:description.
		          A third edit was made to prevent subjects from being concatenated in the same dc:subject field for
		          MODS metadata created via Islandora forms.
		          
		          2015-08  Joseph Nicholson
		          
		          Edited to prevent partNumber from being added to title. Motorsports metadata already includes partNumber in title in order to display that element in title search results in Islandora.
		          
		          2015-10  Joseph Nicholson
		          
-->

	<xsl:output method="xml" indent="yes"/>
	
	<xsl:template match="/">
		<xsl:choose>
			<!-- WS: updated schema location -->
		<xsl:when test="//mods:modsCollection">			
			<srw_dc:dcCollection xsi:schemaLocation="info:srw/schema/1/dc-schema http://www.loc.gov/standards/sru/recordSchemas/dc-schema.xsd">
				<xsl:apply-templates/>
			<xsl:for-each select="mods:modsCollection/mods:mods">			
				<srw_dc:dc xsi:schemaLocation="info:srw/schema/1/dc-schema http://www.loc.gov/standards/sru/recordSchemas/dc-schema.xsd">
				<xsl:apply-templates/>
			</srw_dc:dc>
			</xsl:for-each>
			</srw_dc:dcCollection>
		</xsl:when>
		<xsl:otherwise>
			<xsl:for-each select="mods:mods">
			<oai_dc:dc xsi:schemaLocation="http://www.openarchives.org/OAI/2.0/oai_dc/ http://www.openarchives.org/OAI/2.0/oai_dc.xsd">
				<xsl:apply-templates/>
			</oai_dc:dc>
			</xsl:for-each>
		</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	
	<xsl:template match="mods:titleInfo">
		<dc:title>			
			<xsl:value-of select="mods:title"/>			
		</dc:title>	
	</xsl:template>
	
	<xsl:template match="mods:titleInfo/mods:title[@type='alternative']">
		<dc:title >
			<xsl:value-of select="."/>
		</dc:title>
	</xsl:template>

	<xsl:template match="mods:name[@type='corporate']">
		<dc:source>
			<xsl:value-of select="mods:namePart"/>
		</dc:source>
		<dc:source>
			<xsl:value-of select="mods:affiliation"/>
		</dc:source>
	</xsl:template>
	
	
	<xsl:template match="mods:name">
		<xsl:choose>
			<xsl:when test="mods:role/mods:roleTerm= 'creator'">
				<dc:creator>
					<xsl:value-of select="mods:namePart"/>
				</dc:creator>
			</xsl:when>
			<xsl:when test="mods:role/mods:roleTerm = 'contributor' or 'advisor' or 'editor' or 'other'">
				<dc:contributor>
					<xsl:value-of select="mods:namePart"/>
				</dc:contributor>
			</xsl:when>
		</xsl:choose>
	</xsl:template>
	

	<xsl:template match="mods:subject[mods:topic | mods:name | mods:occupation | mods:geographic | mods:hierarchicalGeographic | mods:cartographics | mods:temporal] ">
			<xsl:for-each select="mods:topic">
				<dc:subject>
				<xsl:value-of select="."/>
				</dc:subject>
			</xsl:for-each>
			<xsl:for-each select="mods:name">
				<dc:subject>
					<xsl:value-of select="."/>
				</dc:subject>
			</xsl:for-each>

		<xsl:for-each select="mods:geographic">
			<dc:coverage >
				<xsl:value-of select="."/>
			</dc:coverage>
		</xsl:for-each>

		<xsl:for-each select="mods:hierarchicalGeographic">
			<dc:coverage>
				<xsl:for-each select="mods:continent|mods:country|mods:provence|mods:region|mods:state|mods:territory|mods:county|mods:city|mods:island|mods:area">
					<xsl:value-of select="."/>
					<xsl:if test="position()!=last()">--</xsl:if>
				</xsl:for-each>
			</dc:coverage>
		</xsl:for-each>

		<xsl:for-each select="mods:cartographics/*">
			<dc:coverage>
				<xsl:value-of select="."/>
			</dc:coverage>
		</xsl:for-each>
	</xsl:template>
	
	<xsl:template match="mods:abstract">
		<dc:description>
			<xsl:value-of select="."/>
		</dc:description>
	</xsl:template>

	<xsl:template match="mods:originInfo">
		<xsl:apply-templates select="*[@point='start']"/>
		<xsl:for-each
			select="mods:dateIssued[@point!='start' and @point!='end'] |mods:dateCreated[@point!='start' and @point!='end'] | mods:dateCaptured[@point!='start' and @point!='end'] | mods:dateOther[@point!='start' and @point!='end']">
			<dc:date>
				<xsl:value-of select="."/>
			</dc:date>
		</xsl:for-each>
		<xsl:apply-templates select="*[not(@point)]"/> 
		
		<xsl:for-each select="mods:publisher">
			<dc:publisher>
				<xsl:value-of select="."/>
			</dc:publisher>
		</xsl:for-each>
	
	</xsl:template>
	
	<xsl:template match="mods:dateIssued | mods:dateCreated | mods:dateCaptured">
		<dc:date>
			<xsl:choose>
				<xsl:when test="@point='start'">
					<xsl:value-of select="."/>
					<xsl:text> - </xsl:text>
				</xsl:when>
				<xsl:when test="@point='end'">
					<xsl:value-of select="."/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="."/>
				</xsl:otherwise>
			</xsl:choose>
		</dc:date>
	</xsl:template> 
	
	<xsl:template match="mods:dateIssued">
		<dc:date>
			<xsl:value-of select="."/>
		</dc:date>
	</xsl:template>
	
	<xsl:template match="mods:dateCreated">
		<dc:date>
			<xsl:value-of select="."/>
		</dc:date>
	</xsl:template>
	
	
	
	<xsl:template match="mods:dateIssued[@point='start'] | mods:dateCreated[@point='start'] | mods:dateCaptured[@point='start'] | mods:dateOther[@point='start'] ">
		<xsl:variable name="dateName" select="local-name()"/>
		<dc:date>
			<xsl:value-of select="."/>-<xsl:value-of select="../*[local-name()=$dateName][@point='end']"/>
		</dc:date>
	</xsl:template>
	
	
	<xsl:template match="mods:genre">
				<dc:type>
					<xsl:value-of select="."/>
				</dc:type>
<!--				<xsl:apply-templates select="mods:typeOfResource"/>  -->
	</xsl:template>

	<xsl:template match="mods:typeOfResource">	
		<xsl:choose>
			<xsl:when test="contains(text(), 'Collection') or contains(text(), 'collection')">
				<dc:type>collection</dc:type>
			</xsl:when>		
			<xsl:otherwise>
				<!-- dc.type to mods.typeOfResource is based on LOC Dublin Core Metadata Element Set Mapping to MODS Version 3 mapping at  -->
				<xsl:choose>
					<xsl:when test="string(text()) = 'Dataset' or string(text()) = 'dataset'">
						<dc:type>dataset</dc:type>
					</xsl:when>
					<xsl:when test="string(text()) = 'Software' or string(text()) = 'software'">
						<dc:type>service</dc:type>
					</xsl:when>
					<xsl:when test="string(text()) = 'Software' or string(text()) = 'software'">
						<dc:type>software</dc:type>
					</xsl:when>
					<xsl:when test="string(text()) = 'cartographic material' or string(text()) = 'Cartographic material'">
						<dc:type>image</dc:type>
					</xsl:when>
					<xsl:when test="string(text()) = 'multimedia' or string(text()) = 'Multimedia'">
						<dc:type>interactive resource</dc:type>
					</xsl:when>
					<xsl:when test="string(text()) = 'moving image' or string(text()) = 'Moving image'">
						<dc:type>moving image</dc:type>
					</xsl:when>
					<xsl:when test="string(text()) = 'three dimensional object' or string(text()) = 'Three dimensional object'">
						<dc:type>physical object</dc:type>
					</xsl:when>
					<xsl:when test="string(text()) = 'still image' or string(text()) = 'Still image'">
						<dc:type>still image</dc:type>
					</xsl:when>
					<xsl:when test="starts-with(.,'sound recording' or string(text()) = 'Sound recording')">
						<dc:type>sound</dc:type>
					</xsl:when>
					<xsl:when test="string(text()) = 'text' or string(text()) = 'Text'">
						<dc:type>text</dc:type>
					</xsl:when>
					<xsl:when test="string(text()) = 'notated music' or string(text()) = 'Notated music'">
						<dc:type>text</dc:type>
					</xsl:when>
					<xsl:otherwise>
						<dc:type>
							<xsl:value-of select="."/>
						</dc:type>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:otherwise>			
		</xsl:choose>
	</xsl:template>
	
	
	<xsl:template match="mods:physicalDescription">
		<xsl:for-each select="mods:extent | mods:internetMediaType | mods:form">
			<dc:format>
				<xsl:value-of select="."/>
			</dc:format>
		</xsl:for-each>
	</xsl:template>
<!--
	<xsl:template match="mods:mimeType">
		<dc:format>
			<xsl:value-of select="."/>
		</dc:format>
	</xsl:template>
-->
	<xsl:template match="mods:identifier">
		<dc:identifier>
			<xsl:variable name="type" select="translate(@type,'ABCDEFGHIJKLMNOPQRSTUVWXYZ','abcdefghijklmnopqrstuvwxyz')"/>
				<xsl:choose>
				<!-- GM: removed identifier type attribute from output for non-ISBN identifiers-->
					<xsl:when test="contains(.,':')">
						<xsl:value-of select="."/>
					</xsl:when>
					<xsl:when test="contains ('isbn issn uri doi lccn uri', $type)">
						<xsl:value-of select="$type"/>: <xsl:value-of select="."/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="."/>
					</xsl:otherwise>
				</xsl:choose>
		</dc:identifier>
	</xsl:template>

	<xsl:template match="mods:relatedItem/mods:location">
		<xsl:for-each select="mods:url">
			<dc:relation>	
				<xsl:value-of select="."/>
			</dc:relation>
		</xsl:for-each>
	</xsl:template>

	<xsl:template match="mods:language">
		<dc:language>
			<xsl:value-of select="child::*"/>
		</dc:language>
	</xsl:template>

<!-- GM: removed coordination between subfields -->
		
		
		<xsl:template match="mods:relatedItem[mods:titleInfo | mods:name | mods:identifier | mods:location]">
			<xsl:choose>
				<xsl:when test="@type='host'">
					<xsl:for-each
						select="mods:titleInfo[mods:title | mods:identifier | mods:location/mods:url]">
							<dc:source><xsl:value-of select="."/></dc:source>
					</xsl:for-each>
				
				</xsl:when>
				<xsl:otherwise>
					<xsl:for-each
						select="mods:titleInfo[mods:title | mods:identifier | mods:location/mods:url]">
						<xsl:if test="normalize-space(.)!= ''">
							<dc:relation>
							<xsl:value-of select="."/>
							</dc:relation>
						</xsl:if>
					</xsl:for-each>
				
				</xsl:otherwise>
			</xsl:choose>
		</xsl:template>
	


	<xsl:template match="mods:accessCondition">
		<dc:rights>
			<xsl:value-of select="."/>
		</dc:rights>
	</xsl:template>

<!--  Not using name template because not parsing names into subelements for now 
		<xsl:template name="name">
		<xsl:variable name="name">
			<xsl:for-each select="mods:namePart[not(@type)]">
				<xsl:value-of select="."/>
			</xsl:for-each>
			<xsl:value-of select="mods:namePart[@type='family']"/>
			<xsl:if test="mods:namePart[@type='given']">
				<xsl:text>, </xsl:text>
				<xsl:value-of select="mods:namePart[@type='given']"/>
			</xsl:if>
			<xsl:if test="mods:namePart[@type='date']">
				<xsl:text>, </xsl:text>
				<xsl:value-of select="mods:namePart[@type='date']"/>
				<xsl:text/>
			</xsl:if>
			<xsl:if test="mods:displayForm">
				<xsl:text> (</xsl:text>
				<xsl:value-of select="mods:displayForm"/>
				<xsl:text>) </xsl:text>
			</xsl:if>
		</xsl:variable>
		<xsl:value-of select="normalize-space($name)"/>
	</xsl:template>   -->

	<!-- suppress all else:-->
	<xsl:template match="*"/>		

</xsl:stylesheet>