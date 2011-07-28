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

<xsl:template name="crlfToLi">
		<xsl:param name="value"/>
		<xsl:if test="contains($value,'&#xA;')">
			<li><xsl:value-of select="translate(substring-before($value,'&#xA;'),'-','')"/></li>
			<xsl:call-template name="crlfToLi">
				<xsl:with-param name="value" select="translate(substring-after($value,'&#xA;'),'-','')"/>
			</xsl:call-template>
		</xsl:if>
		<xsl:if test="not(contains($value,'&#xA;')) and $value != ''">
			<li><xsl:value-of select="translate($value,'-','')"/></li>
		</xsl:if>
</xsl:template>

</xsl:stylesheet>