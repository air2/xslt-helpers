<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE xsl:stylesheet [ <!ENTITY nbsp "&#x00A0;"> <!ENTITY amp "&#038;"> <!ENTITY euro "&#8364;"> <!ENTITY lt "&#60;"> <!ENTITY gt "&#62;"> ]>
<xsl:stylesheet 
	version="1.0" 
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
	xmlns:msxsl="urn:schemas-microsoft-com:xslt"
	xmlns:msxml="urn:schemas-microsoft-com:xslt"
	xmlns:fb="http://www.facebook.com/2008/fbml"
	xmlns:randomTools="http://www.umbraco.org/randomTools"
	xmlns:umbraco.library="urn:umbraco.library" xmlns:Exslt.ExsltCommon="urn:Exslt.ExsltCommon" xmlns:Exslt.ExsltDatesAndTimes="urn:Exslt.ExsltDatesAndTimes" xmlns:Exslt.ExsltMath="urn:Exslt.ExsltMath" xmlns:Exslt.ExsltRegularExpressions="urn:Exslt.ExsltRegularExpressions" xmlns:Exslt.ExsltStrings="urn:Exslt.ExsltStrings" xmlns:Exslt.ExsltSets="urn:Exslt.ExsltSets"
	xmlns:exsl="http://exslt.org/common" extension-element-prefixes="exsl"
	exclude-result-prefixes="msxml umbraco.library Exslt.ExsltCommon Exslt.ExsltDatesAndTimes Exslt.ExsltMath Exslt.ExsltRegularExpressions Exslt.ExsltStrings ">

<xsl:output method="xml" omit-xml-declaration="yes"/>
	
	<xsl:template match="text" name="block">
	    <xsl:param name="pString" select="."/>
	    <xsl:if test="$pString != ''">
	        <xsl:choose>
	            <xsl:when test="starts-with($pString,'#')">
	                <xsl:call-template name="header">
	                    <xsl:with-param name="pString" select="substring($pString,2)"/>
	                </xsl:call-template>
	            </xsl:when>
	            <xsl:when test="starts-with($pString,'&#xA;')">
	                <xsl:call-template name="list">
	                    <xsl:with-param name="pString" select="substring($pString,2)"/>
	                </xsl:call-template>
	            </xsl:when>
	            <xsl:otherwise>
	                <xsl:call-template name="paragraph">
	                    <xsl:with-param name="pString" select="$pString"/>
	                </xsl:call-template>
	            </xsl:otherwise>
	        </xsl:choose>
	    </xsl:if>
	</xsl:template>
	
	<xsl:template name="header">
	    <xsl:param name="pString"/>
	    <xsl:variable name="vInside" select="substring-before($pString,'#&#xA;')"/>
	    <xsl:choose>
	        <xsl:when test="$vInside != ''">
	            <h4>
	                <xsl:call-template name="inline">
	                    <xsl:with-param name="pString" select="$vInside"/>
	                </xsl:call-template>
	            </h4>
	            <xsl:call-template name="block">
	                <xsl:with-param name="pString" select="substring-after($pString,'#&#xA;')"/>
	            </xsl:call-template>
	        </xsl:when>
	        <xsl:otherwise>
	            <xsl:call-template name="paragraph">
	                <xsl:with-param name="pString" select="concat('#',$pString)"/>
	            </xsl:call-template>
	        </xsl:otherwise>
	    </xsl:choose>
	</xsl:template>
	
	<xsl:template name="list">
	    <xsl:param name="pString"/>
	    <xsl:variable name="vCheckList" select="starts-with($pString,'- ')"/>
	    <xsl:choose>
	        <xsl:when test="$vCheckList">
	            <ul>
	                <xsl:call-template name="listItem">
	                    <xsl:with-param name="pString" select="$pString"/>
	                </xsl:call-template>
	            </ul>
	            <xsl:call-template name="block">
	                <xsl:with-param name="pString">
	                    <xsl:call-template name="afterlist">
	                        <xsl:with-param name="pString" select="$pString"/>
	                    </xsl:call-template>
	                </xsl:with-param>
	            </xsl:call-template>
	        </xsl:when>
	        <xsl:otherwise>
	            <xsl:call-template name="block">
	                <xsl:with-param name="pString" select="$pString"/>
	            </xsl:call-template>
	        </xsl:otherwise>
	    </xsl:choose>
	</xsl:template>
	
	<xsl:template name="paragraph">
	    <xsl:param name="pString"/>
	    <xsl:choose>
	        <xsl:when test="contains($pString,'&#xA;')">
	            <p>
	                <xsl:call-template name="inline">
	                    <xsl:with-param name="pString" select="substring-before($pString,'&#xA;')"/>
	                </xsl:call-template>
	            </p>
	        </xsl:when>
	        <xsl:otherwise>
	            <p>
	                <xsl:call-template name="inline">
	                    <xsl:with-param name="pString" select="$pString"/>
	                </xsl:call-template>
	            </p>
	        </xsl:otherwise>
	    </xsl:choose>
	    <xsl:call-template name="block">
	        <xsl:with-param name="pString" select="substring-after($pString,'&#xA;')"/>
	    </xsl:call-template>
	</xsl:template>
	
	<xsl:template name="afterlist">
	    <xsl:param name="pString"/>
	    <xsl:choose>
	        <xsl:when test="starts-with($pString,'- ')">
	            <xsl:call-template name="afterlist">
	                <xsl:with-param name="pString"
	                select="substring-after($pString,'&#xA;')"/>
	            </xsl:call-template>
	        </xsl:when>
	        <xsl:otherwise>
	            <xsl:value-of select="$pString"/>
	        </xsl:otherwise>
	    </xsl:choose>
	</xsl:template>
	
	<xsl:template name="listItem">
	    <xsl:param name="pString"/>
	    <xsl:if test="starts-with($pString,'- ')">
	    	<xsl:choose>
	    	    <xsl:when test="contains($pString,'&#xA;')">
	    	        <li>
	    	            <xsl:call-template name="inline">
	    	                <xsl:with-param name="pString" select="substring-before(substring($pString,3),'&#xA;')"/>
	    	            </xsl:call-template>
	    	        </li>
	    	    </xsl:when>
	    	    <xsl:otherwise>
	    	        <li>
	    	            <xsl:call-template name="inline">
	    	                <xsl:with-param name="pString" select="substring($pString,3)"/>
	    	            </xsl:call-template>
	    	        </li>
	    	    </xsl:otherwise>
	    	</xsl:choose>
	        <xsl:call-template name="listItem">
	            <xsl:with-param name="pString" select="substring-after($pString,'&#xA;')"/>
	        </xsl:call-template>
	    </xsl:if>
	</xsl:template>
	
	<xsl:template name="inline">
	    <xsl:param name="pString" select="."/>
	    <xsl:if test="$pString != ''">
	        <xsl:choose>
	            <xsl:when test="starts-with($pString,'__')">
	                <xsl:call-template name="strong">
	                    <xsl:with-param name="pString" select="substring($pString,3)"/>
	                </xsl:call-template>
	            </xsl:when>
	            <xsl:when test="starts-with($pString,'*')">
	                <xsl:call-template name="span">
	                    <xsl:with-param name="pString" select="substring($pString,2)"/>
	                </xsl:call-template>
	            </xsl:when>
	            <xsl:when test="starts-with($pString,'&quot;')">
	                <xsl:call-template name="link">
	                    <xsl:with-param name="pString" select="substring($pString,2)"/>
	                </xsl:call-template>
	            </xsl:when>
	            <xsl:otherwise>
	                <xsl:value-of select="substring($pString,1,1)"/>
	                <xsl:call-template name="inline">
	                    <xsl:with-param name="pString" select="substring($pString,2)"/>
	                </xsl:call-template>
	            </xsl:otherwise>
	        </xsl:choose>
	    </xsl:if>
	</xsl:template>
	
	<xsl:template name="strong">
	    <xsl:param name="pString"/>
	    <xsl:variable name="vInside" select="substring-before($pString,'__')"/>
	    <xsl:choose>
	        <xsl:when test="$vInside != ''">
	            <strong>
	                <xsl:value-of select="$vInside"/>
	            </strong>
	            <xsl:call-template name="inline">
	                <xsl:with-param name="pString"
	                select="substring-after($pString,'__')"/>
	            </xsl:call-template>
	        </xsl:when>
	        <xsl:otherwise>
	            <xsl:value-of select="'__'"/>
	            <xsl:call-template name="inline">
	                <xsl:with-param name="pString" select="$pString"/>
	            </xsl:call-template>
	        </xsl:otherwise>
	    </xsl:choose>
	</xsl:template>
	
	<xsl:template name="span">
	    <xsl:param name="pString"/>
	    <xsl:variable name="vInside" select="substring-before($pString,'*')"/>
	    <xsl:choose>
	        <xsl:when test="$vInside != ''">
	            <span>
	                <xsl:value-of select="$vInside"/>
	            </span>
	            <xsl:call-template name="inline">
	                <xsl:with-param name="pString"
	                select="substring-after($pString,'*')"/>
	            </xsl:call-template>
	        </xsl:when>
	        <xsl:otherwise>
	            <xsl:value-of select="'*'"/>
	            <xsl:call-template name="inline">
	                <xsl:with-param name="pString" select="$pString"/>
	            </xsl:call-template>
	        </xsl:otherwise>
	    </xsl:choose>
	</xsl:template>
	
	<xsl:template name="link">
	    <xsl:param name="pString"/>
	    <xsl:variable name="vInside" 
	           select="substring-before($pString,'&quot;')"/>
	    <xsl:choose>
	        <xsl:when test="$vInside != ''">
	            <xsl:call-template name="href">
	                <xsl:with-param name="pString"
	                select="substring-after($pString,'&quot;')"/>
	                <xsl:with-param name="pInside" select="$vInside"/>
	            </xsl:call-template>
	        </xsl:when>
	        <xsl:otherwise>
	            <xsl:value-of select="'&quot;'"/>
	            <xsl:call-template name="inline">
	                <xsl:with-param name="pString" select="$pString"/>
	            </xsl:call-template>
	        </xsl:otherwise>
	    </xsl:choose>
	</xsl:template>
	
	<xsl:template name="href">
	    <xsl:param name="pString"/>
	    <xsl:param name="pInside"/>
	    <xsl:variable name="vHref"
	    select="substring-before(substring($pString,2),']')"/>
	    <xsl:choose>
	        <xsl:when test="starts-with($pString,'[') and $vHref != ''">
	            <a href="{$vHref}">
	                <xsl:value-of select="$pInside"/>
	            </a>
	            <xsl:call-template name="inline">
	                <xsl:with-param name="pString"
	                select="substring-after($pString,']')"/>
	            </xsl:call-template>
	        </xsl:when>
	        <xsl:otherwise>
	            <xsl:value-of select="concat('&quot;',$pInside,'&quot;')"/>
	            <xsl:call-template name="inline">
	                <xsl:with-param name="pString" select="$pString"/>
	            </xsl:call-template>
	        </xsl:otherwise>
	    </xsl:choose>
	</xsl:template>
</xsl:stylesheet>