<cfcomponent extends="wheelsMapping.Model">

	<cffunction name="init">
		<!--- for testing we'll set the user id to a guid --->
		<cfset property(name="id", guid="true")>
	</cffunction>

</cfcomponent>