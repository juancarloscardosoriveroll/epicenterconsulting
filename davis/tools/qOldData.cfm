<cfparam name="q" default="">

<h1>Enter value:</h1>
<form action="qOldData.cfm" method="post">
    <input type="text" name="q" value="<cfoutput>#q#</cfoutput>">
    <input type="submit">
</form>

<cfset sources = arraynew(1)>

<cfset temp = structnew()>
<cfset temp["table"] = "Surveyor">
<cfset temp["fields"] = arraynew(1)>
<cfset temp2 = structnew()>
<cfset temp2["name"] = "surveyor">
<cfset temp2["type"] = "nvarchar">
<cfset arrayappend(temp.fields,temp2)> 
<cfset arrayappend(sources,temp)>

<cfset temp = structnew()>
<cfset temp["table"] = "Source">
<cfset temp["fields"] = arraynew(1)>
<cfset temp2 = structnew()>
<cfset temp2["name"] = "source">
<cfset temp2["type"] = "nvarchar">
<cfset arrayappend(temp.fields,temp2)> 
<cfset arrayappend(sources,temp)>

<cfset temp = structnew()>
<cfset temp["table"] = "SL">
<cfset temp["fields"] = arraynew(1)>
<cfset temp2 = structnew()>
<cfset temp2["name"] = "COMPNAME">
<cfset temp2["type"] = "nvarchar">
<cfset arrayappend(temp.fields,temp2)> 
<cfset temp2 = structnew()>
<cfset temp2["name"] = "CONTFN">
<cfset temp2["type"] = "nvarchar">
<cfset arrayappend(temp.fields,temp2)> 
<cfset arrayappend(sources,temp)>


<cfset temp = structnew()>
<cfset temp["table"] = "refOEM">
<cfset temp["fields"] = arraynew(1)>
<cfset temp2 = structnew()>
<cfset temp2["name"] = "COMPNAME">
<cfset temp2["type"] = "nvarchar">
<cfset arrayappend(temp.fields,temp2)> 
<cfset temp2 = structnew()>
<cfset temp2["name"] = "CONTACTFN">
<cfset temp2["type"] = "nvarchar">
<cfset arrayappend(temp.fields,temp2)> 
<cfset arrayappend(sources,temp)>

<cfset temp = structnew()>
<cfset temp["table"] = "refMFG">
<cfset temp["fields"] = arraynew(1)>
<cfset temp2 = structnew()>
<cfset temp2["name"] = "COMPNAME">
<cfset temp2["type"] = "nvarchar">
<cfset arrayappend(temp.fields,temp2)> 
<cfset temp2 = structnew()>
<cfset temp2["name"] = "CGMFGID">
<cfset temp2["type"] = "nvarchar">
<cfset arrayappend(temp.fields,temp2)> 
<cfset temp2 = structnew()>
<cfset temp2["name"] = "CONTFN">
<cfset temp2["type"] = "nvarchar">
<cfset arrayappend(temp.fields,temp2)> 
<cfset arrayappend(sources,temp)>

<cfset temp = structnew()>
<cfset temp["table"] = "References">
<cfset temp["fields"] = arraynew(1)>
<cfset temp2 = structnew()>
<cfset temp2["name"] = "COMPNAME">
<cfset temp2["type"] = "nvarchar">
<cfset arrayappend(temp.fields,temp2)> 
<cfset temp2 = structnew()>
<cfset temp2["name"] = "CONTFN">
<cfset temp2["type"] = "nvarchar">
<cfset arrayappend(temp.fields,temp2)> 
<cfset arrayappend(sources,temp)>


<cfset temp = structnew()>
<cfset temp["table"] = "Ref_Dataold">
<cfset temp["fields"] = arraynew(1)>
<cfset temp2 = structnew()>
<cfset temp2["name"] = "Ref_No">
<cfset temp2["type"] = "nvarchar">
<cfset arrayappend(temp.fields,temp2)> 
<cfset temp2 = structnew()>
<cfset temp2["name"] = "AcctCode">
<cfset temp2["type"] = "nvarchar">
<cfset arrayappend(temp.fields,temp2)> 
<cfset temp2 = structnew()>
<cfset temp2["name"] = "Surveyor">
<cfset temp2["type"] = "nvarchar">
<cfset arrayappend(temp.fields,temp2)> 
<cfset temp2 = structnew()>
<cfset temp2["name"] = "Source">
<cfset temp2["type"] = "nvarchar">
<cfset arrayappend(temp.fields,temp2)> 
<cfset temp2 = structnew()>
<cfset temp2["name"] = "Insured_FN">
<cfset temp2["type"] = "nvarchar">
<cfset arrayappend(temp.fields,temp2)> 
<cfset arrayappend(sources,temp)>


<cfif len(q) gt 0>
    <cfloop from="1" to="#arraylen(sources)#" index="thisSource">
        <cfset mySource = sources[thisSource]>
        <cfquery dbtype="odbc" datasource="#application.datasource#" name="D">
            select top 10 *  
            from [#mySource.table#]
            where 
                <cfloop from="1" to="#arraylen(mySource.fields)#" index="thisField">
                    <cfset myField = mySource.fields[thisField]>
                    <cfif thisField gt 1> OR </cfif>
                    #myField.name# LIKE <cfqueryparam value="%#q#%">
                </cfloop>
        </cfquery>
        <cfdump var="#D#" label="#mySource.table#">
        <hr size="1">
    </cfloop>

</cfif>
