<cfif isdefined("delete")>
    <cfset myDir = createObject("component","scripts").init("directory.json")>
    <cfset result = myDir.delContact(delete)>
    <cfoutput>#result#</cfoutput> 
</cfif>

<cfif isdefined("addnew")>
    <cfset myDir = createObject("component","scripts").init("directory.json")>
    <cfset result = myDir.insContact(name,email,phone)>    
    <cfoutput>#serializeJSON(result)#</cfoutput> 
</cfif>

<cfif isdefined("getid")>
    <cfset myDir = createObject("component","scripts").init("directory.json")>
    <cfset result = myDir.getFromId(getid)>
    <cfoutput>#serializeJSON(result)#</cfoutput> 
</cfif>

<cfif isdefined("id")>
    <cfset myDir = createObject("component","scripts").init("directory.json")>
    <cfset result = myDir.editContact(id,name,email,phone)>
    <cfoutput>#serializeJSON(result)#</cfoutput> 
</cfif>