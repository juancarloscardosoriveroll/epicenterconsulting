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

    <cffunction name="getFaqs" hint="Returns all facts">
        <cfargument name="faqGroup">
        <cfquery dbtype="odbc" datasource="#application.datasource#" name="faq">
            select * from _faqs 
            where faqGroup = <cfqueryparam value="#arguments.faqGroup#">
        </cfquery>
        <cfreturn faq>
    </cffunction>

    <cffunction name="search" hint="returns structure with found data">
        <cfparam name="q">

        <cfset result = structnew()>

        <cfif len(q) gt 0>

            <!--- Contacts --->
            <cfif isnumeric(Q)>
                <cfquery dbtype="odbc" datasource="#application.datasource#" name="contacts" maxrows="1">
                    select cid, cfirstname, clastname, cconame
                    from _contacts
                    where cID = <cfqueryparam value="#q#"> 
                </cfquery>
                <cfset result["contacts"] = contacts>
            <cfelse>
                <cfquery dbtype="odbc" datasource="#application.datasource#" name="contacts" maxrows="10">
                    select cid, cfirstname, clastname, cconame 
                    from _contacts
                    where cFirstName like <cfqueryparam value="#q#%"> 
                        OR cCoName like <cfqueryparam value="#q#%">
                        OR cLastName like <cfqueryparam value="#q#%"> 
                order by cFirstName asc, cLastName asc, cCoName
                </cfquery>
                <cfset result["contacts"] = contacts>
            </cfif>

            <!--- Meta Data --->
            <cfquery dbtype="odbc" datasource="#application.datasource#" name="metadata" maxrows="10">
                select c.cid, cfirstname, clastname, cconame, cfield, cvalue 
                from _contacts_data d, _contacts c
                where c.cid = d.cid
                and cValue like <cfqueryparam value="%#q#%">
                order by cValue asc
            </cfquery>
            <cfset result["metadata"] = metadata>

            <!--- Catalogs --->
            <cfquery dbtype="odbc" datasource="#application.datasource#" name="catalogs" maxrows="10">
                select * from _catalogs
                where itemName like <cfqueryparam value="#q#%">
                or itemDesc like <cfqueryparam value="#q#%">
                order by itemname
            </cfquery>
            <cfset result["catalogs"] = catalogs>

            <!--- Users --->
            <cfquery dbtype="odbc" datasource="#application.datasource#" name="users" maxrows="10">
                select * from _users
                where userFirstName like <cfqueryparam value="#q#%"> 
                    OR userLastName like <cfqueryparam value="#q#%">
                order by userfirstname, userLastname
            </cfquery>
            <cfset result["users"] = users>
 
            <!--- Order (as insured) --->
            <cfif isnumeric(q)>
                <cfquery dbtype="odbc" datasource="#application.datasource#" name="orders_insd" maxrows="10">
                    select * 
                    from _orders o, _contacts c
                    where o.cid_isInsd = c.cid
                     and o.cid_isInsd = <cfqueryparam value="#q#"> 
                     order by orderID desc
                </cfquery>
                <cfset result["orders_insd"] = orders_insd>
            <cfelse>
                <cfquery dbtype="odbc" datasource="#application.datasource#" name="orders_insd" maxrows="10">
                    select * from _orders o, _contacts c
                    where o.cid_isInsd = c.cid
                     and (cFirstName like <cfqueryparam value="#q#%"> 
                        OR cCoName like <cfqueryparam value="#q#%">
                        OR cLastName like <cfqueryparam value="#q#%">)
                    order by orderid desc
                </cfquery>
                <cfset result["orders_insd"] = orders_insd>
            </cfif>

            <!--- Order (as referer) --->
            <cfif isnumeric(q)>
                <cfquery dbtype="odbc" datasource="#application.datasource#" name="orders_acct" maxrows="10">
                    select * from _orders o, _contacts c
                    where o.cid_isAcct = c.cid
                     and o.cid_isAcct = <cfqueryparam value="#q#"> 
                     order by orderid desc
                </cfquery>
                <cfset result["orders_acct"] = orders_acct>
            <cfelse>
                <cfquery dbtype="odbc" datasource="#application.datasource#" name="orders_acct" maxrows="10">
                    select * from _orders o, _contacts c
                    where o.cid_isAcct = c.cid
                     and (cFirstName like <cfqueryparam value="#q#%"> 
                        OR cCoName like <cfqueryparam value="#q#%">
                        OR cLastName like <cfqueryparam value="#q#%">)
                    order by orderid desc
                </cfquery>
                <cfset result["orders_acct"] = orders_acct>
            </cfif>


            <!--- Order (as surveyor) --->
            <cfif isnumeric(q)>
                <cfquery dbtype="odbc" datasource="#application.datasource#" name="orders_surveyor" maxrows="10">
                    select * from _orders o, _users u
                    where o.uid_surveyor = u.userid
                     and o.uid_surveyor = <cfqueryparam value="#q#"> 
                     order by orderid desc
                </cfquery>
                <cfset result["orders_surveyor"] = orders_acct>
            <cfelse>
                <cfquery dbtype="odbc" datasource="#application.datasource#" name="orders_surveyor" maxrows="10">
                    select * from _orders o, _users u
                    where o.uid_surveyor = u.userid
                     and (userFirstName like <cfqueryparam value="#q#%"> 
                        OR userLastName like <cfqueryparam value="#q#%">)
                    order by orderid desc
                </cfquery>
                <cfset result["orders_surveyor"] = orders_acct>
            </cfif>



        </cfif>
        
        <cfreturn result>
    </cffunction>

</cfcomponent>