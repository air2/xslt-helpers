<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE xsl:stylesheet [ <!ENTITY nbsp "&#x00A0;"> <!ENTITY amp "&#038;"> <!ENTITY euro "&#8364;"> ]>
<xsl:stylesheet 
	version="1.0" 
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
	xmlns:msxml="urn:schemas-microsoft-com:xslt"
	xmlns:umbraco.library="urn:umbraco.library" xmlns:Exslt.ExsltCommon="urn:Exslt.ExsltCommon" xmlns:Exslt.ExsltDatesAndTimes="urn:Exslt.ExsltDatesAndTimes" xmlns:Exslt.ExsltMath="urn:Exslt.ExsltMath" xmlns:Exslt.ExsltRegularExpressions="urn:Exslt.ExsltRegularExpressions" xmlns:Exslt.ExsltStrings="urn:Exslt.ExsltStrings" xmlns:Exslt.ExsltSets="urn:Exslt.ExsltSets"
	xmlns:exsl="http://exslt.org/common" extension-element-prefixes="exsl"
	exclude-result-prefixes="msxml umbraco.library Exslt.ExsltCommon Exslt.ExsltDatesAndTimes Exslt.ExsltMath Exslt.ExsltRegularExpressions Exslt.ExsltStrings Exslt.ExsltSets">


<xsl:output method="xml" omit-xml-declaration="yes"/>
<xsl:include href="string-to-lowercase.xslt" />


<xsl:template name="crlfToComma">
		<xsl:param name="value"/>
		<xsl:choose>
		<xsl:when test="contains($value,'&#xA;')">
			<xsl:call-template name="string-to-lowercase">
				<xsl:with-param name="text" select="translate(substring-before($value,'&#xA;'),'-','')"/>
			</xsl:call-template>
			<xsl:if test="contains(translate(substring-after($value,'&#xA;'),'-',''),'&#xA;')">, </xsl:if>
			
			<xsl:call-template name="crlfToComma">
				<xsl:with-param name="value" select="translate(substring-after($value,'&#xA;'),'-','')"/>
			</xsl:call-template>
		</xsl:when>
		<xsl:otherwise>!d</xsl:otherwise>
		</xsl:choose>
</xsl:template>

</xsl:stylesheet>