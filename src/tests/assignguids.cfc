<cfcomponent extends="wheelsMapping.Test">

	<cffunction name="setup">
		<cfset loc.c = "beforeValidationOnCreate">
		<cfset loc.m = "_AssignGUIDs">
	</cffunction>

	<cffunction name="test_callback_is_registered">
		<cfset loc.user = model("user").new()>
		<cfset loc.a = loc.user.$callbacks(loc.c)>
		<cfset loc.b = loc.a.indexOf(loc.m)>
		<cfset assert('loc.b eq 0')>
	</cffunction>

	<cffunction name="test_default_to_guid">
		<cfset loc.user = model("user").create()>
		<cfset loc.e = loc.user.properties()>
		<cfset assert('structkeyexists(loc.e, "id")')>
		<cfset assert('isvalid("guid", loc.user.id)')>
	</cffunction>

	<cffunction name="test_if_guid_value_should_not_change">
		<cfset loc.value = UCase(Insert("-", CreateUUID(), 23))>
		<cfset loc.p = {}>
		<cfset loc.p.id = loc.value>
		<cfset loc.user = model("user").create(loc.p)>
		<cfset loc.e = loc.user.properties()>
		<cfset assert('structkeyexists(loc.e, "id")')>
		<cfset assert('isvalid("guid", loc.user.id)')>
		<cfset assert('loc.value eq loc.user.id')>
	</cffunction>

	<cffunction name="test_if_not_guid_value_should_change">
		<cfset loc.value = "24567">
		<cfset loc.p = {}>
		<cfset loc.p.id = loc.value>
		<cfset loc.user = model("user").create(loc.p)>
		<cfset loc.e = loc.user.properties()>
		<cfset assert('structkeyexists(loc.e, "id")')>
		<cfset assert('isvalid("guid", loc.user.id)')>
	</cffunction>

</cfcomponent>