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

<xsl:template name="content-header">
	<xsl:param name="title" />
	<xsl:param name="subtitle" />
	<div id="content-header">
		<h1><xsl:value-of select="$title"/><xsl:if test="$subtitle != ''"><span><xsl:value-of select="$subtitle"/></span></xsl:if></h1>
		<ul class="social clearfix">
			<li class="plusone"><g:plusone xmlns:g="urn:g"></g:plusone></li>
			<li class="fblike"><fb:like send="true" layout="standard" width="400" show_faces="false" font="arial" xmlns:fb="urn:fb"></fb:like></li>
		</ul>
	</div>
</xsl:template>

</xsl:stylesheet>