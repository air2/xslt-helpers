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

<xsl:template name="project-list">
	<li class="panel">
		<div class="image">
			<img src="http://media.usit.ie/shared/media/products/thumbs/{@code}.jpg" alt="{title}" height="120" width="190" />
			<xsl:if test="@new = 1">
				<span class="new">new</span>
			</xsl:if>
		</div>
		<h3><xsl:value-of select="country"/> from &euro;<xsl:value-of select="price"/> <strong><xsl:value-of select="title"/></strong></h3>
		<a href="{umbraco.library:NiceUrl($currentPage/@id)}/{name/@slug}" class="button">More info...</a>
	</li>	
</xsl:template>

<xsl:template name="project-single">
	<div id="content-header">
		<h1><xsl:value-of select="title"/> <span><xsl:value-of select="$currentPage/@nodeName"/> in <xsl:value-of select="country"/> from &euro;<xsl:value-of select="price"/></span></h1>
		<div class="header-image"><img src="https://usit-assets.s3.amazonaws.com/volunteer/{@code}.jpg" alt="{title}"/></div>
		<ul class="social clearfix">
			<li class="plusone"><g:plusone xmlns:g="urn:g"></g:plusone></li>
			<li class="fblike"><fb:like send="true" layout="standard" width="400" show_faces="false" font="arial" xmlns:fb="urn:fb"></fb:like></li>
		</ul>
	</div>
	
	<dl id="overview" class="clearfix">
		<xsl:if test="country != ''">
			<dt>Location</dt>
			<dd><xsl:value-of select="country"/><xsl:if test="location != ''">, <xsl:value-of select="location"/></xsl:if></dd>
		</xsl:if>
		<xsl:if test="duration != ''">
			<dt>Duration</dt>
			<dd><xsl:value-of select="duration"/></dd>
		</xsl:if>
		<xsl:if test="price != ''">
			<dt>Price</dt>
			<dd>fr &euro;<xsl:value-of select="price"/></dd>
			<xsl:for-each select="priceMoreInfo/data">
				<dd><xsl:value-of select="." /></dd>
			</xsl:for-each>
		</xsl:if>
		<xsl:if test="accommodation != ''">
			<dt>Accommodation</dt>
			<dd><xsl:value-of select="accommodation"/></dd>
		</xsl:if>
		<xsl:if test="meals != ''">
			<dt>Meals</dt>
			<dd><xsl:value-of select="meals"/></dd>
		</xsl:if>
		<xsl:if test="arrival != ''">
			<dt>Arrival</dt>
			<dd><xsl:value-of select="arrival"/></dd>
		</xsl:if>
		<xsl:if test="dates != ''">
			<dt>Dates</dt>
			<dd><xsl:value-of select="dates"/></dd>
		</xsl:if>
		<xsl:if test="infopack != ''">
			<dt>Info Pack</dt>
			<dd><xsl:value-of select="infopack"/></dd>
		</xsl:if>
	</dl>

	<div class="tabs section">
		<ul class="tabs-nav clearfix">
			<li><a href="#general-info">General Info</a></li>
			<xsl:if test="tasks != ''"><li><a href="#tasks">Details of tasks</a></li></xsl:if>
			<xsl:if test="days != ''"><li><a href="#days">Life of a Volunteer</a></li></xsl:if>
			<xsl:if test="location-long != ''"><li><a href="#location">Location</a></li></xsl:if>
		</ul>
		<div id="general-info" class="panel">
			<h4>Requirements</h4>
			<p><xsl:value-of select="requirements" disable-output-escaping="yes" /></p>
			<h4>Maximum duration</h4>
			<p><xsl:value-of select="duration-max" disable-output-escaping="yes" /></p>
			<h4>What is included?</h4>
			<ul>
				<xsl:for-each select="included/data">
					<li><xsl:value-of select="." /></li>
				</xsl:for-each>
			</ul>
			<h4>What is not included?</h4>
			<ul>
				<xsl:for-each select="excluded/data">
					<li><xsl:value-of select="." /></li>
				</xsl:for-each>
			</ul>
		</div>
		<xsl:if test="tasks != ''"><div id="tasks" class="panel"><xsl:value-of select="tasks" disable-output-escaping="yes" /></div></xsl:if>
		<xsl:if test="days != ''"><div id="days" class="panel"><xsl:value-of select="days" disable-output-escaping="yes" /></div></xsl:if>
		<xsl:if test="location-long != ''"><div id="location" class="panel"><img src="http://maps.google.com/maps/api/staticmap?center={location}&amp;zoom=4&amp;size=590x150&amp;maptype=terrain&amp;markers=size:big|color:0xd57d0c|label:Here|{location}&amp;sensor=false&amp;format=png" /><xsl:value-of select="location-long" disable-output-escaping="yes" /></div></xsl:if>
	</div>
	
	<xsl:if test="string(data [@alias='info'])">
		<div id="info">
			<h2 class="project_replace" id="info"><span>Volunteer Information</span></h2>
			<ul>
				<xsl:value-of disable-output-escaping="yes" select="data[@alias='info']"/>
			</ul>
		</div>
	</xsl:if>
</xsl:template>

</xsl:stylesheet>