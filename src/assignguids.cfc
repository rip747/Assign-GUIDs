<!---
	Property Enhancements

 --->

<cfcomponent output="false" mixin="model">

	<cffunction name="init">
		<cfset this.version = "1.1">
		<cfreturn this>
	</cffunction>

	<cffunction name="property">
		<cfargument name="name" type="string" required="true" hint="The name that you want to use for the column or SQL function result in the CFML code.">
		<cfargument name="column" type="string" required="false" default="" hint="The name of the column in the database table to map the property to.">
		<cfargument name="sql" type="string" required="false" default="" hint="A SQL expression to use to calculate the property value.">
		<cfargument name="label" type="string" required="false" default="" hint="A custom label for this property to be referenced in the interface and error messages.">
		<cfargument name="defaultValue" type="string" required="false" hint="A default value for this property.">
		<cfargument name="guid" type="boolean" required="false" default="false" hint="should we assign a guid to this property on create">
		<cfset var loc = {}>
		<!---
			core method we're overloading.
			NOTE: ACF will throw an named argument error if you try to do
			core.properties(argumentCollection=arguments)

			this little hack gets around it. thanks Andy!
		  --->
		<cfset var coreMethod = core.property>

		<!--- call core property --->
		<cfset coreMethod(argumentCollection=arguments)>
		<!--- assign the value of the guid argument --->
		<cfset variables.wheels.class.mapping[arguments.name].guid = arguments.guid>

		<!--- check to see if the _AssignGUIDs callback is registered --->
		<cfset _setAssignGUIDCallback(variables.wheels.class.mapping[arguments.name])>
	</cffunction>

	<cffunction name="_AssignGUIDs" returntype="void" output="false">
		<cfset var loc = {}>
		<!--- loop through all mappings and see which ones we need to assign a guid to --->
		<cfloop collection="#variables.wheels.class.mapping#" item="loc.mapping">
			<cfif StructKeyExists(variables.wheels.class.mapping[loc.mapping], "guid") && variables.wheels.class.mapping[loc.mapping].guid && (!StructKeyExists(this, loc.mapping) || !IsValid("guid", this[loc.mapping]))>
				<cfset this[loc.mapping] = UCase(Insert("-", CreateUUID(), 23))>
			</cfif>
		</cfloop>
	</cffunction>

	<cffunction name="_setAssignGUIDCallback" returntype="void" output="false">
		<cfargument name="mapping" type="struct" required="true">
		<cfset var loc = {}>

		<!--- exit if they don't set the property to use the plugin --->
		<cfif !StructKeyExists(arguments.mapping, "guid") || !arguments.mapping.guid>
			<cfreturn>
		</cfif>

		<!--- callback we're registering to --->
		<cfset loc.toCallback = "beforeValidationOnCreate">
		<!--- name of the method to register --->
		<cfset loc.methodName = "_AssignGUIDs">
		<!--- check to see if the callback is registered --->
		<cfset loc.position = _CallbackRegisteredAt(loc.toCallback, loc.methodName)>
		<!--- if the callback isn't at the first position, delete it --->
		<cfif loc.position gt 1>
			<cfset ArrayDeleteAt(variables.wheels.class.callbacks[loc.toCallback], loc.position)>
		</cfif>
		<!--- make sure the callback is at the first position --->
		<cfif loc.position neq 1>
			<cfset ArrayPrepend(variables.wheels.class.callbacks[loc.toCallback], loc.methodName)>
		</cfif>

	</cffunction>

	<cffunction name="_CallbackRegisteredAt" returntype="numeric" output="false">
		<cfargument name="stack" type="string" required="true">
		<cfargument name="callback" type="string" required="true">
		<cfset var loc = {}>

		<!--- get the callback stack --->
		<cfset loc.callback = $callbacks(arguments.stack)>
		<!--- get the size of the stack --->
		<cfset loc.a = ArrayLen(loc.callback)>
		<!--- loop through and see if what position the callback is at --->
		<cfloop from="1" to="#loc.a#" index="loc.i">
			<cfif loc.callback[loc.i] EQ arguments.callback>
				<cfreturn loc.i>
				<cfbreak>
			</cfif>
		</cfloop>
		<!--- callback isn't registered :( --->
		<cfreturn 0>
	</cffunction>

</cfcomponent>