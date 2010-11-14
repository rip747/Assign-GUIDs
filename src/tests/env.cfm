<!--- reload default settings --->
<cfinclude template="/wheelsMapping/events/onapplicationstart/settings.cfm">

<!--- ride off of wheelstesting bed --->
<cfset application.wheels.modelPath = "/plugins/assignguids/tests/_assets/models">
<cfset application.wheels.modelComponentPath = "plugins.assignguids.tests._assets.models">
<cfset application.wheels.dataSourceName = "wheelstestdb">