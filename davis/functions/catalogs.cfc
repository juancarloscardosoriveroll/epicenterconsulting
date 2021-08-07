<cfcomponent>
    <cffunction name="getItems" hint="returns items from catalogs for index/link">
        <cfargument name="catType" required="true">
        <cfargument name="itemId" required="false" default="0">
        <cfargument name="catActive" required="false" default="ALL" hint="ALL,1,0">

        <cfquery dbtype="odbc" datasource="#application.datasource#" name="rows">
            select c.itemid, c.itemname, c.itemdesc, c.catactive, c.ownerid, c.cattype, c.catdate, 
                    u.userfirstname, u.userlastname 
            from _catalogs c, _users u
            where catType = <cfqueryparam value="#arguments.catType#">
            <cfif arguments.itemID gt 0>
                and itemId = <cfqueryparam value="#arguments.itemId#">
            </cfif>
            <cfif arguments.catActive neq 'ALL'>
                and catActive = <cfqueryparam value="#arguments.catActive#">
            </cfif>
            and ownerid = u.userid
        </cfquery>

        <cfreturn rows>

    </cffunction>

    <cffunction name="itemedit" hint="updates an existing item">
        <cfargument name="itemName" required="true" type="string" hint="Name">
        <cfargument name="itemDesc" required="true" type="string" hint="Description">
        <cfargument name="itemId"   required="true" type="string" hint="Key for edit">
        <cfargument name="cattype" required="true" type="string" hint="catType">

        <cftry>
            <!--- check dups --->
            <cfset firstWord = listfirst(arguments.itemName,' ')>
            <cfset ValidateDup = true>

            <!--- Dup exception words --->
            <cfif listfindnocase(arraytolist(Application.setup.duplicate_skip_words),firstWord)>
                <cfset ValidateDup = false>
            </cfif>

            <cfif ValidateDup>
                <cfquery dbtype="odbc" datasource="#application.datasource#" name="checkDup">
                    select count(*) as total
                    from _catalogs 
                    where itemName LIKE <cfqueryparam value="%#firstWord#%">
                    and cattype = <cfqueryparam value="#arguments.cattype#">
                    and itemid <> <cfqueryparam value="#arguments.itemid#">
                </cfquery>

                <!--- validate data types --->
                <cfif checkDup.total gt 0>
                    <cfreturn -8>
                </cfif>
            </cfif>

            <cfquery dbtype="odbc" datasource="#application.datasource#" result="update">
                update _catalogs
                set  catType = <cfqueryparam value="#arguments.catType#">
                    ,itemName = <cfqueryparam value="#arguments.itemName#">
                    ,itemDesc = <cfqueryparam value="#arguments.itemDesc#">
                where itemID = <cfqueryparam value="#arguments.itemid#">
            </cfquery>

            <!--- Return Main Key --->
            <cfreturn arguments.itemId>
            
            <cfcatch>
                <!--- Log to _errors table for future troubleshooting and return cfcatch error --->
                <cfset Application.helper.logCatchError("users.itemedit",arguments,cfcatch)>
                <cfreturn -1001>
            </cfcatch>
        </cftry>
    </cffunction>


    <cffunction name="itemnew" hint="inserts a new item">
        <cfargument name="itemName" required="true" type="string" hint="Name">
        <cfargument name="itemDesc" required="false" type="string" hint="Description">
        <cfargument name="cattype" required="true" type="string" hint="catType">
        <cfargument name="ownerId" required="yes"   type="numeric" hint="user submitting">

        <cftry>
            <!--- check dups --->
            <cfset firstWord = listfirst(arguments.itemName,' ')>
            <cfset ValidateDup = true>

            <!--- Dup exception words --->
            <cfif listfindnocase(arraytolist(Application.setup.duplicate_skip_words),firstWord)>
                <cfset ValidateDup = false>
            </cfif>

            <cfif ValidateDup>
                <cfquery dbtype="odbc" datasource="#application.datasource#" name="checkDup">
                    select count(*) as total
                    from _catalogs 
                    where itemName LIKE <cfqueryparam value="%#firstWord#%">
                    and cattype = <cfqueryparam value="#arguments.cattype#">
                </cfquery>

                <!--- validate data types --->
                <cfif checkDup.total gt 0>
                    <cfreturn -8>
                </cfif>
            </cfif>

            <cfquery dbtype="odbc" datasource="#application.datasource#" result="insert">
                insert into _catalogs
                    (
                    catType 
                    ,itemName
                    ,itemDesc 
                    ,ownerId
                    )
                values
                    (   
                     <cfqueryparam value="#arguments.catType#">
                    ,<cfqueryparam value="#arguments.itemName#">
                    ,<cfqueryparam value="#arguments.itemDesc#">
                    ,<cfqueryparam value="#arguments.ownerId#">
                    )
            </cfquery>
            <cfset newID = insert["GENERATEDKEY"]>

            <!--- Return Main Key --->
            <cfreturn newId>
            
            <cfcatch>
                <!--- Log to _errors table for future troubleshooting and return cfcatch error --->
                <cfset Application.helper.logCatchError("users.itemnew",arguments,cfcatch)>
                <cfreturn -1001>
            </cfcatch>
        </cftry>

    </cffunction>

    <cffunction name="getStats" hint="returns a structure with stats fot itemtypes">

        <!--- Initialize Container --->
        <cfset result = structnew()>
        <cfloop from="1" to="#arraylen(Application.setup.catalogs)#" index="CT">
            <cfset cat = Application.setup.catalogs[CT]>
            <cfset result["#CAT.id#"] = 0>
        </cfloop>

        <!--- Count --->
        <cfquery dbtype="odbc" datasource="#application.datasource#" name="data">
            select count(*) as total, catType 
            From _catalogs 
            group by catType
        </cfquery>
        <cfloop query="data">
            <cfset result[catType] = total>
        </cfloop>

        <cfreturn result>

    </cffunction>
</cfcomponent>