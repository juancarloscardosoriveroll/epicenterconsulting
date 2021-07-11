<cfcomponent>
    <cffunction name="createUser" returntype="numeric" access="public" hint="creates user in _users table">
        <cfargument name="userEmail" type="string" required="true">
        <cfargument name="userPass" type="string" required="true">
        <cfargument name="userFirstName" type="string" required="true">
        <cfargument name="userLastName" type="string" required="true">
        <cfargument name="userPhone" type="string" required="false">

        <!--- Check that Email is valid --->
        <cfif Not(isValid("email",arguments.userEmail))>
            <cfreturn -1>
        </cfif>

        <!---- Check that phone is valid (if provided) ---->
        <cfif Application.setup.register_validatePhone>
            <cfif isdefined("arguments.userPhone") 
                AND Not(isValid("telephone",arguments.userPhone))>
                <cfreturn -2>
            </cfif>
        </cfif>

        <!--- Check that first & lastnames have a value --->
        <cfif len(trim(arguments.userFirstName)) lt 3 OR len(trim(arguments.userLastName)) lt 3>
            <cfreturn -3>
        </cfif>

        <!--- Check that password have a value --->
        <cfif len(trim(arguments.userPass)) eq 0>
            <cfreturn -4>
        </cfif>

        <cftry>
            <!---- Check that there are no duplicates ---->
            <cfquery dbtype="odbc" datasource="#Application.datasource#" name="check">
                select count(*) as total 
                from _users 
                where userEmail = <cfqueryparam value="#arguments.userEmail#">
            </cfquery>
            <cfif check.total neq 0>
                <cfreturn -5>
            </cfif>

            <!--- Ready to create --->
            <cfquery dbtype="odbc" datasource="#Application.datasource#" result="insert">
                insert into _users (
                    userEmail
                    ,userPass
                    ,userFirstName
                    ,userLastName
                    ,userPhone
                    )
                values 
                    (
                    <cfqueryparam value="#Arguments.userEmail#">
                    ,<cfqueryparam value="#Hash(Arguments.userEmail,'SHA')#">
                    ,<cfqueryparam value="#Arguments.userFirstName#">
                    ,<cfqueryparam value="#Arguments.userLastName#">
                    ,<cfqueryparam value="#arguments.userPhone#">
                    )
            </cfquery>

            <cfreturn insert["GENERATEDKEY"]>
            <cfcatch>
                <!--- Log to _errors table for future troubleshooting and return cfcatch error --->
                <cfset Application.helper.logCatchError("users.createUser",arguments,cfcatch)>
                <cfreturn -1001>
            </cfcatch>
        </cftry>

    </cffunction>

    <cffunction name="getUsers" returntype="query" access="public" hint="returns all users or a specific one">
        <cfargument name="userID" required="false" default="0">

        <cfquery dbtype="odbc" datasource="#application.datasource#" name="data">
            select * from _users 
                <cfif arguments.userid neq 0>
                    where userid = <cfqueryparam value="#arguments.userid#">
                </cfif>
            order by userfirstname, userlastname 
        </cfquery>      

        <cfreturn data>
    </cffunction>

    <cffunction name="getPermits" returntype="string" access="public" hint="return Permits">
        <cfargument name="userID" required="true">
        
        <cfquery dbtype="odbc" datasource="#application.datasource#" name="permits">
            select rtrim(permitName) as PN from _permits
            where userid = <cfqueryparam value="#arguments.userid#">
        </cfquery>

        <cfreturn valuelist(permits.PN)>
    </cffunction>
    
    <cffunction name="setPermits" returntype="numeric" access="public" hint="deletes all and sets array of permits">
        <cfargument name="userId" required="true">
        <cfargument name="permitNames" required="true" type="string" hint="list of permits">

        <cftry>
            <cfquery dbtype="odbc" datasource="#application.datasource#" name="borra">
                delete from _permits where userid = <cfqueryparam value="#arguments.userid#">
            </cfquery>

            <cfloop list="#arguments.permitNames#" index="PN">
                <cfquery dbtype="odbc" datasource="#application.datasource#" name="inserta">
                    insert into _permits (userId,permitName)
                    values (<cfqueryparam value="#arguments.userId#">,<cfqueryparam value="#PN#">)
                </cfquery>
            </cfloop>

            <cfreturn 1>

            <cfcatch>
                <!--- Log to _errors table for future troubleshooting and return cfcatch error --->
                <cfset Application.helper.logCatchError("users.setPermits",arguments,cfcatch)>
                <cfreturn -1001>
            </cfcatch>
        </cftry>

    </cffunction>
</cfcomponent>