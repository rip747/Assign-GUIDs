<h1>Assign GUIDs</h1>

<p>A very simple plugin that adds a "guid" argument to the propery() model method.</p>
<p>When set to "true", a beforeValidationOnCreate callback named "_AssignGUIDs" will be registered, which assigns a guid value to the property before the record is inserted into the database.</p>
<p>Very useful when you have a GUID column in a sql server database.</p>

<h3>Example</h3>

<pre>
&lt;cfcomponent extends="Model"&gt;
	&lt;cffunction name="init"&gt;
		&lt;!--- the primary key of the model ---&gt;
		&lt;cfset property(name="id", guid="true")&gt;
		&lt;!--- some random guid column on the table also ---&gt;
		&lt;cfset property(name="passwordSalt", guid="true")&gt;
	&lt;/cffunction&gt;
&lt;/cfcomponent&gt;
</pre>

<p><a href="<cfoutput>#cgi.http_referer#</cfoutput>"><<< Go Back</a></p>