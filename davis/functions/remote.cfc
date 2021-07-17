<cfcomponent>
    <cffunction name="getCityStateCountyfromZip" access="remote" hint="used for jquery autocomplete" returnformat="plain">
        <cfargument name="zipcode">

        <cfquery dbtype="odbc" datasource="#application.datasource#" name="data" maxrows="1">
            select zipcode, cityMixedCase as city, state, countyMixedCase as county 
            from _zipcodes
            where zipcode = <cfqueryparam value="#arguments.zipcode#">
        </cfquery>

        <cfreturn data.city & ", " & data.county & ", " & data.state>
    </cffunction>



    <cffunction name="getStates" access="remote" hint="returns a list of states" returnformat="plain">

        <cfquery dbtype="odbc" datasource="#application.datasource#" name="data">
            select distinct state from _zipcodes order by state asc
        </cfquery>
        <cfset result = arraynew(1)>
        <cfloop query="data">
            <cfset temp = structnew()>
            <cfset temp["value"] = state>
            <cfset temp["name"] = state>
            <cfset arrayappend(result,temp)>
        </cfloop>

        <cfreturn serializeJSON(result)>
    </cffunction>


    <cffunction name="getCounties" access="remote" hint="returns a list of counties" returnformat="plain">
        <cfargument name="state">

        <cfquery dbtype="odbc" datasource="#application.datasource#" name="data">
            select distinct countyMixedCase as county 
            from _zipcodes 
            where state = <cfqueryparam value="#arguments.state#">
            order by county asc
        </cfquery>
        <cfset result = arraynew(1)>
        <cfloop query="data">
            <cfset temp = structnew()>
            <cfset temp["value"] = county>
            <cfset temp["name"] = county>
            <cfset arrayappend(result,temp)>
        </cfloop>

        <cfreturn serializeJSON(result)>
    </cffunction>


    <cffunction name="getCities" access="remote" hint="returns a list of counties" returnformat="plain">
        <cfargument name="county">
        <cfargument name="state">

        <cfquery dbtype="odbc" datasource="#application.datasource#" name="data">
            select distinct cityMixedCase as city, zipcode 
            from _zipcodes 
            where county = <cfqueryparam value="#arguments.county#">
            and state = <cfqueryparam value="#arguments.state#">
            order by city asc
        </cfquery>
        <cfset result = arraynew(1)>
        <cfloop query="data">
            <cfset temp = structnew()>
            <cfset temp["value"] = zipcode>
            <cfset temp["name"] = zipcode & " - " & city >
            <cfset arrayappend(result,temp)>
        </cfloop>

        <cfreturn serializeJSON(result)>
    </cffunction>


</cfcomponent>