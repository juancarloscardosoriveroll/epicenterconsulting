<cfcomponent>
    <cffunction name="init">
        <cfargument name="filename" type="string">
        <cfset this["filename"] = arguments.filename>
        <cftry>
            <!--- Read source file --->
            <cffile action="read" file="#expandpath(this.filename)#" variable="myDir">
            <cfset temp = deserializeJSON(myDir)>
 
            <!--- Return basic data --->
            <cfset this["data"] = temp>
            <Cfreturn this>
            <Cfcatch><cfreturn cfcatch></Cfcatch>
        </cftry>
    </cffunction>

    <cffunction name="dataAsQuery">
        <Cfargument name="sortfield" type="string" required="false" default="name">
        <cftry>
            <cfset myData = querynew("id,name,email,phone","varchar,varchar,varchar,varchar")>
            <Cfloop from="1" to="#arraylen(this.data)#" index="C">
                <cfset queryaddrow(myData)>
                <cfset querysetcell(myData,"id",this.data[C].id)>
                <cfset querysetcell(myData,"name",this.data[C].name)>
                <cfset querysetcell(myData,"email",this.data[C].email)>
                <cfset querysetcell(myData,"phone",this.data[C].phone)>
            </Cfloop>
            <cfquery dbtype="query" name="sorted">
                select * from myData order by #sortField#
            </cfquery>
            <Cfreturn sorted>
            <cfcatch><cfreturn cfcatch></cfcatch>
        </cftry>
    </cffunction>

    <cffunction name="delContact">
        <cfargument name="id">
        <cftry>
            <cfloop from="1" to="#arraylen(this.data)#" index="C">
                <cfif this.data[C].id eq arguments.id>
                    <cfset arraydeleteat(this.data,C)>
                    <cffile action="write" file="#expandpath(this.filename)#" output="#serializeJSON(this.data)#"> 
                    <cfexit method="loop">
                </cfif>
            </cfloop>
            <cfreturn true>
            <cfcatch><cfreturn false></cfcatch>
        </cftry>
    </cffunction>

    <cffunction name="insContact">
        <cfargument name="name">
        <cfargument name="email">
        <cfargument name="phone">

        <cftry>
            <cfset result = structnew()>
            <cfset result["success"] = false>

            <cfif len(trim(name)) lt 5>
                <cfset result["message"] = "Please provide a full name">
                <cfreturn result>
            </cfif>

            <cfif not(isvalid("telephone",phone))>
                <cfset result["message"] = "Please provide a valid phone">
                <cfreturn result>
            </cfif>

            <cfif not(isvalid("email",email))>
                <cfset result["message"] = "Please provide a valid email">
                <cfreturn result>
            </cfif>

            <cfloop from="1" to="#arraylen(this.data)#" index="C">
                <cfif this.data[C].email eq email>
                    <cfset result["message"] = "Duplicate Email">
                    <cfreturn result>
                </cfif>
            </cfloop>

            <cfset temp = structnew()>
            <cfset temp["name"] = name>
            <cfset temp["phone"] = phone>
            <cfset temp["email"] = email>
            <cfset temp["id"] = createuuid()>
            <cfset arrayappend(this.data,temp)>
            <cffile action="write" file="#expandpath(this.filename)#" output="#serializeJSON(this.data)#"> 

            <cfset result["success"] = true>
            <cfset result["message"] = "New record created">

            <Cfcatch>
                <cfset result["success"] = false>
                <cfset result["message"] = cfcatch.message>
            </Cfcatch>
        </cftry>

       <cfreturn result>
    </cffunction>

    <cffunction name="getFromId">
        <cfargument name="id">

        <cftry>
            <cfloop from="1" to="#arraylen(this.data)#" index="C">
                <cfif this.data[C].id eq id>
                    <cfreturn this.data[C]>
                </cfif>
            </cfloop>

            <Cfreturn structnew()>
            <cfcatch>
                <Cfreturn structnew()>
            </cfcatch>
        </cftry>
       
    </cffunction>


    <cffunction name="editContact">
        <cfargument name="id">
        <cfargument name="name">
        <cfargument name="email">
        <cfargument name="phone">

        <cftry>
            <cfset result = structnew()>
            <cfset result["success"] = false>
            <cfset result["message"] = "No record found">

            <cfif len(trim(name)) lt 5>
                <cfset result["message"] = "Please provide a full name">
                <cfreturn result>
            </cfif>

            <cfif not(isvalid("telephone",phone))>
                <cfset result["message"] = "Please provide a valid phone">
                <cfreturn result>
            </cfif>

            <cfif not(isvalid("email",email))>
                <cfset result["message"] = "Please provide a valid email">
                <cfreturn result>
            </cfif>

            
            <cfloop from="1" to="#arraylen(this.data)#" index="C">
                <cfif this.data[C].id eq id>
                    <cfset arraydeleteat(this.data,C)>
                    <Cfset temp = structnew()>
                    <cfset temp["name"] = name>
                    <cfset temp["phone"] = phone>
                    <cfset temp["email"] = email>
                    <cfset temp["id"] = id>
                    <Cfset arrayappend(this.data,temp)>
                    <cffile action="write" file="#expandpath(this.filename)#" output="#serializeJSON(this.data)#"> 
                    <cfset result["success"] = true>
                    <cfset result["message"] = "Record updated">
                </cfif>
            </cfloop>

            <cfreturn result>
            
            <Cfcatch>
                <cfset result["success"] = false>
                <cfset result["message"] = cfcatch.message>
            </Cfcatch>
        </cftry>

       <cfreturn result>


    </cffunction>

</cfcomponent>