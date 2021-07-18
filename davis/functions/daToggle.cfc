<cfcomponent>
    <cffunction name="usersactive">
        <cfargument name="field">
        <cfargument name="id">

        <cfquery dbtype="odbc" datasource="#application.datasource#" name="original">
            select userActive from _users where userid = <cfqueryparam value="#arguments.id#">
        </cfquery>

        <cfquery dbtype="odbc" datasource="#application.datasource#" name="flip">
            update _users set userActive = userActive^1 where userid = <cfqueryparam value="#arguments.id#">
        </cfquery>

        <cfif original.userActive>
            <!--- Return Opposite value --->
            <cfreturn "<div class='alert alert-danger' role='alert'>#Application.labels['useractive_no']#</div>">
        <cfelse>
            <cfreturn "<div class='alert alert-success' role='alert'>#Application.labels['useractive_yes']#</div>">
        </cfif>

    </cffunction>

    <cffunction name="catalogsactive">
        <cfargument name="field">
        <cfargument name="id">

        <cfquery dbtype="odbc" datasource="#application.datasource#" name="original">
            select catActive from _catalogs where itemId = <cfqueryparam value="#arguments.id#">
        </cfquery>

        <cfquery dbtype="odbc" datasource="#application.datasource#" name="flip">
            update _catalogs set catActive = catActive^1 where itemId = <cfqueryparam value="#arguments.id#">
        </cfquery>    
  
        <cfif original.catActive>      
            <!--- Return Opposite value --->
            <cfreturn "<div class='alert alert-danger' role='alert'>#Application.labels['catactive_no']#</div>">
        <cfelse> 
            <cfreturn "<div class='alert alert-success' role='alert'>#Application.labels['catactive_yes']#</div>">
        </cfif>            
     
    </cffunction>  
</cfcomponent>