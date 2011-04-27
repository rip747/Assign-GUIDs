<!---
	Property Enhancements

 --->

<cfcomponent output="false" mixin="model">

	<cffunction name="init">
		<cfset this.version = "1.1">
		<cfreturn this>
	</cffunction>

	<cffunction name="assignGuid" returntype="void" output="false">
		<cfargument name="name" type="string" required="true" hint="Comma delim list of properties that should be assigned a guid">
		<cfset arguments.name = $listClean(arguments.name)>
		<cfif !len(arguments.name)>
			<cfreturn>
		</cfif>
		<!--- assign the value of the guid argument --->
		<cfset variables.wheels.class._assignGuid = arguments.name>
		<!--- setup the callback --->
		<cfset _setAssignGUIDCallback()>
	</cffunction>

	<cffunction name="_AssignGUIDs" returntype="void" output="false">
		<cfset var loc = {}>
		<!--- loop through all mappings and see which ones we need to assign a guid to --->
		<cfloop list="#variables.wheels.class._assignGuid#" index="loc.mapping">
			<cfif !StructKeyExists(this, loc.mapping) || !IsValid("guid", this[loc.mapping])>
				<cfset this[loc.mapping] = UCase(Insert("-", CreateUUID(), 23))>
			</cfif>
		</cfloop>
	</cffunction>

	<cffunction name="_setAssignGUIDCallback" returntype="void" output="false">
		<cfset ArrayPrepend(variables.wheels.class.callbacks.beforeValidationOnCreate, "_AssignGUIDs")>
	</cffunction>

</cfcomponent>