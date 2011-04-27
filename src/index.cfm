<h1>Assign GUIDs</h1>

<p>Adds a new method to your model called "assignGuid" which takes a list of properties to generate GUIDs for during an insert.</p>
<p>Very useful when you have a GUID column in a sql server database.</p>

<h3>Example</h3>

<pre>
&lt;cfcomponent extends="Model"&gt;
	&lt;cffunction name="init"&gt;
		&lt;!--- generate a guid for the primary key of the model ---&gt;
		&lt;cfset assignGuid("id")&gt;
	&lt;/cffunction&gt;
&lt;/cfcomponent&gt;

&lt;cfcomponent extends="Model"&gt;
	&lt;cffunction name="init"&gt;
		&lt;!--- pass a list if you have two or more columns that need guids ---&gt;
		&lt;cfset assignGuid("column1,column2")&gt;
	&lt;/cffunction&gt;
&lt;/cfcomponent&gt;
</pre>

<p><a href="<cfoutput>#cgi.http_referer#</cfoutput>"><<< Go Back</a></p>