<cfset form["compName"] = "aaaaaa">
<cfset form["street"] = "bbbbb">
<cfset form["zipcode"] = "12345">
<cfset form["contactFn"] = "cccccc">
<cfset form["contactLn"] = "dddddd">
<cfset form["phone"] = "eeeee">
<cfset form["phone800"] = "fffff">
<cfset form["phoneFax"] = "gggggg">
<cfset form["notes"] = "hhhhh">
<cfset form["artNo"] = "iiiii">
<cfset form["catType"] = "general">
<cfset form["catItem"] = "BASE ARTICLE #createUUID()#">

<cfinvoke component="/root/functions/catalogs" method="itemnew" returnvariable="resultCode"
formFields="#form#" catOwner="0">

<cfdump var="#resultCode#">

<cfif isNumeric(resultCode) and resultCode eq '-1001'>
    <cfquery dbtype="odbc" datasource="#application.datasource#" name="ultimo">
        select top 1 catchMessage from _errors order by catchid desc
    </cfquery>
    <cfset myError = deserializeJSON(ultimo.catchMessage)>
    <cfdump var="#myError#">
</cfif>
