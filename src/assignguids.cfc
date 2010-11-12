<cfcomponent output="false" mixin="model">

	<cffunction name="init">
		<cfset this.version = "1.1">
		<cfreturn this>
	</cffunction>

	<!--- Display the right content of the flash message with a wrapper "<div></div>" tag --->
	<cffunction name="property">
		<cfargument name="name" type="string" required="true" hint="The name that you want to use for the column or SQL function result in the CFML code.">
		<cfargument name="column" type="string" required="false" default="" hint="The name of the column in the database table to map the property to.">
		<cfargument name="sql" type="string" required="false" default="" hint="A SQL expression to use to calculate the property value.">
		<cfargument name="label" type="string" required="false" default="" hint="A custom label for this property to be referenced in the interface and error messages.">
		<cfargument name="defaultValue" type="string" required="false" hint="A default value for this property.">
		<cfargument name="guid" type="boolean" required="false" default="false" hint="should we assign a guid to this property on create">
		<cfset var loc = {}>
		<cfset var coreMethod = core.property>

		<!--- call core property --->
		<cfset coreMethod(argumentCollection=arguments)>
		<cfset variables.wheels.class.mapping[arguments.name].guid = arguments.guid>

		<!--- check to see if the _AssignGUIDs callback is registered --->
		<cfset loc.hasCallback = false>
		<cfset loc.callbacks = $callbacks("beforeCreate")>

		<cfloop array="#loc.callbacks#" index="loc.i">
			<cfif loc.i EQ "_AssignGUIDs">
				<cfset loc.hasCallback = true>
				<cfbreak>
			</cfif>
		</cfloop>

		<!--- if not register it --->
		<cfif !loc.hasCallback>
			<!---
			have to make sure that it's registered as the first callback in case
			other callback use the property
			 --->
			<cfset ArrayPrepend(variables.wheels.class.callbacks["beforeValidationOnCreate"], "_AssignGUIDs")>
		</cfif>
	</cffunction>

	<cffunction name="_AssignGUIDs" returntype="void" output="false">
		<cfset var loc = {}>

		<!--- loop through all mappings and see which ones we need to assign a guid to --->
		<cfloop collection="#variables.wheels.class.mapping#" item="loc.mapping">
			<cfif StructKeyExists(variables.wheels.class.mapping[loc.mapping], "guid") && variables.wheels.class.mapping[loc.mapping].guid && !IsValid("guid", this[loc.mapping])>
				<cfset this[loc.mapping] = UCase(Insert("-", CreateUUID(), 23))>
			</cfif>
		</cfloop>
	</cffunction>

</cfcomponent>