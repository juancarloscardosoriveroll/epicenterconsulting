<cfcomponent>
    <cffunction name="getItems" hint="returns items from catalogs for index/link">
        <cfargument name="catType" required="true">
        <cfargument name="catOwner" required="false" default="0">

        <cfquery dbtype="odbc" datasource="#application.datasource#" name="rows">
            select * from _catalogs
            where catType = <cfqueryparam value="#arguments.catType#">
        </cfquery>

        <cfreturn rows>

    </cffunction>

    <cffunction name="getData" hint="returns associated item data from catalogs_data">
        <cfargument name="catId" required="true">
        <cfargument name="dataFields" required="false" type="array" default="#arraynew(1)#" hint="optional filter fields as array">
        <cfargument name="dataValue" required="false" type="string" default="" hint="optional Search string">

        <!--- Get Associated Data --->
        <cfquery dbtype="odbc" datasource="#application.datasource#" name="rows">
            select * from _catalogs_data 
            where catId = <cfqueryparam value="#arguments.catid#">
                <cfif arraylen(arguments.dataFields) gt 0>
                    AND (
                    <cfloop from="1" to="#arraylen(arguments.dataFields)#" index="X">
                        <cfset thisField = arguments.dataFields[X]>
                        dataField = <cfqueryparam value="#thisField#">
                        <cfif X lt arraylen(arguments.dataFields)> OR </cfif>
                    </cfloop>)
                </cfif>
                <cfif len(trim(arguments.dataValue)) gt 0>
                    AND dataValue LIKE <cfqueryparam value="%#arguments.dataValue#%">
                </cfif>
            order by dataField
        </cfquery>

        <!--- convert to Struct for easier Indexing --->
        <cfset result = structnew()>
        <cfloop query="rows">
            <cfset result["#dataField#"] = trim(dataValue)>
        </cfloop>

        <!--- return result --->
        <cfreturn result>
    </cffunction>


    <cffunction name="itemnew" hint="inserts a new item">
        <cfargument name="formFields" required="true" type="struct" hint="form structure">

        <!--- check dups --->

        <!--- validate data types --->

        <cftry>

        <cfquery dbtype="odbc" datasource="#application.datasource#" result="insert">
            insert into _catalogs
                (
                     catType 
                    ,catItem 
                    ,catOwner
                )
            values
                (   
                    <cfqueryparam value="#arguments.formFields.catType#">
                   ,<cfqueryparam value="#arguments.formFields.catItem#">
                   ,<cfqueryparam value="#arguments.catOwner#">
                )

        </cfquery>
        <cfset newID = insert["GENERATEDKEY"]>

        <!--- Insert Complimentary Info based on Field Layout --->
        <cfloop from="1" to="#arraylen(application.setup.catalogs)#" index="CAT">
            <cfset THISCAT = application.setup.catalogs[CAT]>
            <cfif THISCAT.catType.id eq arguments.formfields.catType>
                <cfloop from="1" to="#arraylen(THISCAT.addFields)#" index="AF">
                    <cfset THISFIELD = THISCAT.addFields[AF]>
                    
                    <cfset thisFieldValue = evaluate('arguments.formfields.' & thisField.fieldname)>
                    <cfif len(trim(thisFieldValue)) gt 0>

                        <!--- INSERT VALID FIELD --->
                        <cfquery dbtype="odbc" datasource="#application.datasource#" name="data">
                            insert into _catalogs_data (
                                catId 
                                ,dataField 
                                ,dataValue)
                            values (
                                <cfqueryparam value="#newId#">
                                ,<cfqueryparam value="#ThisField.fieldname#">
                                ,<cfqueryparam value="#ThisFieldValue#">)
                        </cfquery>

                    </cfif>

                </cfloop>
            </cfif>
        </cfloop>

        <!--- Return Main Key --->
        <cfreturn newId>
        
        <cfcatch>
            <!--- Log to _errors table for future troubleshooting and return cfcatch error --->
            <cfset Application.helper.logCatchError("users.itemnew",arguments,cfcatch)>
            <cfreturn -1001>
        </cfcatch>
        </cftry>

    </cffunction>
</cfcomponent>