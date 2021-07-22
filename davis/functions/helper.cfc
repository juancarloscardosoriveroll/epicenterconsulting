<cfcomponent>
    <cffunction name="getLangFile" hint="Loads Language File and returns a simple Struct" returntype="struct" access="public">
        <cffile action="read" file="#expandpath('/root/includes/labels.json')#" variable="labels">
        <cfreturn deserializeJSON(labels)>        
    </cffunction>

    <cffunction name="getErrorFile" hint="Loads ErrorLang File and returns a simple Struct" returntype="struct" access="public">
        <cffile action="read" file="#expandpath('/root/includes/errors.json')#" variable="errors">
        <cfreturn deserializeJSON(errors)>        
    </cffunction>

    <cffunction name="getSetupFile" hint="Loads Settings File and returns a simple Struct" returntype="struct" access="public">
        <cffile action="read" file="#expandpath('/root/includes/settings.json')#" variable="setup">
        <cfreturn deserializeJSON(setup)>        
    </cffunction>

    <cffunction name="hasPermit" hint="Returns true or false based on asset and method" returntype="boolean" access="public">
        <cfargument name="userId" type="numeric">
        <cfargument name="permitName" type="string" hint="Name of registered asset">
        
        <cfquery dbtype="odbc" datasource="#application.datasource#" name="result"> 
            select count(permitId) as total from _users_permits 
            where userid = <cfqueryparam value="#arguments.userid#">
              and rtrim(permitName) = <cfqueryparam value="#arguments.permitName#">
        </cfquery>
        <cfif result.total gt 0> <cfreturn true> 
        <cfelse>  <cfreturn false> </cfif>
    </cffunction>

    <cffunction name="replaceVars" hint="replaces vars in a String for custom labels and errors using prefix %">
        <cfargument name="message" type="string">
        <cfargument name="varstruct" type="struct">
        <cfset myMessage = arguments.message>
        <cfloop collection="#arguments.varStruct#" item="arg">
            <cfset myMessage = replacenocase(myMessage,"%" & arg,evaluate('arguments.varStruct.#arg#'),'ALL')>
        </cfloop>
        <cfreturn myMessage>
    </cffunction>

    <cffunction name="logCatchError" hint="Logs all Catch Errors for Debugging" returntype="boolean" access="public">
        <cfargument name="catchService">
        <cfargument name="catchArguments">
        <cfargument name="catchMessage">
        <cftry>
            <cfquery dbtype="odbc" datasource="#application.datasource#" name="log">
                insert into _errors (
                     catchService
                    ,catchArguments
                    ,catchMessage)
                values (
                     <cfqueryparam value="#arguments.catchService#">
                    ,<cfqueryparam value="#serializeJSON(arguments.catchArguments)#">
                    ,<cfqueryparam value="#serializeJSON(arguments.catchMessage)#">)
            </cfquery>
            <cfreturn true>
            <cfcatch><cfreturn false></cfcatch>
        </cftry>
    </cffunction>

    <cffunction name="checkToken" hint="Checks that a user token is valid for access">
        <cfargument name="accessToken">

        <cfquery dbtype="odbc" datasource="#application.datasource#" name="check">
            select userid from _users where accessToken = <cfqueryparam value="#accessToken#">
        </cfquery>
        <cfif check.recordcount eq 1>
            <cfreturn check.userid>
        <cfelse>
            <cfreturn 0>
        </cfif>
    </cffunction>

    <cffunction name="getProfile" hint="Returns the basic user profile">
        <cfargument name="userid">

        <cfquery dbtype="odbc" datasource="#application.datasource#" name="profile">
            select userfirstname, userlastname, useremail, userPhone 
            from _users
            where userid = <cfqueryparam value="#arguments.userid#">
        </cfquery>

        <cfreturn profile>
    </cffunction>


</cfcomponent>