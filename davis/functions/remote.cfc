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
        <cfargument name="country" default="US">

        <cfswitch expression="#arguments.country#">
            <cfcase value="US">
                <cffile action="read" file="#expandpath('/root/assets/states_US.json')#"
                variable="mystates">
            </cfcase>
            <cfdefaultcase>
                <cfquery dbtype="odbc" datasource="#application.datasource#" name="states">
                    select distinct stateMixedCase, state from _zipcodes where countryISO = <cfqueryparam value="#country#">
                </cfquery>
                <cfset temp = arraynew(1)>
                <cfloop query="states">
                    <cfset temp_s = structnew()>
                    <cfset temp_s["abbreviation"] = state>
                    <cfset temp_s["name"] = stateMixedCase>
                    <cfset arrayappend(temp,temp_s)>
                </cfloop>
                <cfset mystates = serializeJSON(temp)>
            </cfdefaultcase>
        </cfswitch>

        <cfreturn mystates>
    </cffunction>


    <cffunction name="getCounties" access="remote" hint="returns a list of counties" returnformat="plain">
        <cfargument name="state">
        <cfargument name="country">

        <cfquery dbtype="odbc" datasource="#application.datasource#" name="data">
            select distinct countyMixedCase as county 
            from _zipcodes 
            where state = <cfqueryparam value="#arguments.state#">
            and countryIso = <cfqueryparam value="#arguments.country#">
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


    <cffunction name="AC_Contacts" access="remote" returnformat="plain" hint="autocomplete contacts">
        <cfargument name="term">
        <cfargument name="contactType">

        <cfset result = arraynew(1)>

        <cfif len(term) gt 2>
        <!--- Look first for keys --->
        <cfswitch expression="#arguments.contactType#">
            <cfcase value="isInsd">
                
                <cfquery dbtype="odbc" datasource="#application.datasource#" name="data">
                    select c.cfirstname, c.clastname, c.ccoName, c.cid, c.zipcode, c.cstreetNum, c.cPhoneMain, c.cEmail
                        ,z.cityMixedCase, z.countryISO, z.state, z.countyMixedCase
                    from _contacts c, _zipcodes z 
                    where c.isInsd = 1
                    and c.zipcode = z.zipcode
                    and c.cCountry = z.countryISO
                    <cfif isnumeric(arguments.term)>
                        and c.cid = <cfqueryparam value="#arguments.term#">
                    <cfelse>                        
                        and (c.cFirstName like <cfqueryparam value="#arguments.term#%">
                        or c.cLastName like <cfqueryparam value="#arguments.term#%">
                        or c.cCoName like <cfqueryparam value="#arguments.term#%">)
                     </cfif>
                </cfquery>

                <cfloop query="data">
                    <cfset temp_s = structnew()>
                    <cfif len(cCoName) gt 0>
                        <cfset temp_s["label"] = trim(cFirstName) & " " & trim(cLastName) & " (" & trim(ccoName) & ")">
                    <cfelse>
                        <cfset temp_s["label"] = trim(cFirstName) & " " & trim(cLastName)>
                    </cfif>
                    <cfset temp_s["address"] = trim(cStreetNum) & "," & trim(cityMixedCase) & "," & trim(state) & "," & trim(countyMixedCase) & "," & trim(CountryISO) & "," & trim(zipcode)>
                    <cfset temp_s["contact"] = trim(cPhoneMain) & "," & trim(cEmail) & " - ID:" & cid>
                    <cfset temp_s["value"] = cId>
                    <cfset arrayappend(result,temp_s)>
                </cfloop>

            </cfcase>
        </cfswitch>
        </cfif>

        <cfreturn serializeJSON(result)>

    </cffunction>

    <cffunction name="getCountries" access="remote" returnformat="plain" >
        <cffile action="read" file="#expandpath('/root/assets/countries.json')#" variable="C">
        <cfreturn C>

    </cffunction>


</cfcomponent>