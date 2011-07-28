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

<xsl:template name="string-to-slug">
	<xsl:param name="text" select="''" />
	<xsl:variable name="dodgyChars" select="' ,.#_-!?*:;=+'" />
	<xsl:variable name="replacementChar" select="'------------'" />
	<xsl:variable name="lowercased"><xsl:call-template name="string-to-lowercase"><xsl:with-param name="text" select="$text" /></xsl:call-template></xsl:variable>
	<xsl:variable name="escaped"><xsl:value-of select="translate( $lowercased, $dodgyChars, $replacementChar )" /></xsl:variable>
	<xsl:variable name="ampRemoved"><xsl:value-of select="umbraco.library:Replace( $escaped, '&amp;', 'and' )" /></xsl:variable>
	<xsl:variable name="cleaned"><xsl:value-of select="umbraco.library:Replace( $ampRemoved, '--', '-' )" /></xsl:variable>
	<xsl:variable name="cleaned2"><xsl:value-of select="umbraco.library:Replace( $cleaned, '--', '-' )" /></xsl:variable>
	<xsl:value-of select="umbraco.library:UrlEncode($cleaned2)" />
</xsl:template>


</xsl:stylesheet>