<cfcomponent>
    <cffunction name="getContacts">
        <cfargument name="contactTypes" required="false" default="" type="string" hint="list of types">
        <cfargument name="cID" default="0" type="integer" required="false">

        <cfquery dbtype="odbc" datasource="#application.datasource#" name="data">
        select *, 0 as meta from _contacts c, _users u
        where c.cOwnerID = u.userID
            <cfif listfindnocase(arguments.contactTypes,'isMarina')>
                and c.isMarina = 1
            </cfif>                
            <cfif listfindnocase(arguments.contactTypes,'isLead')>
                and c.isLead = 1
            </cfif>                
            <cfif listfindnocase(arguments.contactTypes,'isOEM')>
                and c.isOEM = 1
            </cfif>                
            <cfif listfindnocase(arguments.contactTypes,'isMFG')>
                and c.isMFG = 1
            </cfif>                
            <cfif listfindnocase(arguments.contactTypes,'IsSalC')>
                and c.isSALC = 1
            </cfif>                
            <cfif listfindnocase(arguments.contactTypes,'isOMIM')>
                and c.isOMIM = 1
            </cfif> 
            <cfif arguments.cid gt 0>
                and c.cid = <cfqueryparam value="#arguments.cid#">
            </cfif>               
        order by c.cID desc     
        </cfquery> 

        <cfloop query="data">
            <cfquery dbtype="odbc" datasource="#application.datasource#" name="cuenta">
                select count(*) as total from _contacts_data where cid = <cfqueryparam value="#data.cid[currentRow]#">
            </cfquery>
            <cfset querysetcell(data,"meta",cuenta.total,data.currentRow)>
        </cfloop>


        <cfreturn data>  
    </cffunction>


    <cffunction name="newContact">
        <!--- min 1 contactype --->
        <cfif len(trim(arguments.contactTypes)) eq 0>
            <cfreturn -9> <!--- at least one contact type --->
        </cfif>

        <!--- config.validateZipcode --->
        <cfif application.setup.contacts_validateZipCode>
            <cfinvoke component="/root/functions/remote" method="getCityStateCountyfromZip" returnvariable="place"
                zipcode="#arguments.zipcode#">
            <!--- returns city, state, country so estimate allowable length to catch error --->
            <cfif len(trim(place)) lt 5 or len(trim(place)) gt 100>
                <cfreturn -10>
            </cfif>
        </cfif>

        <!--- config.validatePhones --->
        <cfif Application.setup.register_validatePhone>
            <cfif Not(isValid("telephone",arguments.cPhoneMain))>
                <cfreturn -11>
            </cfif>
        </cfif>

        <!--- config.nophoneDuplicates --->
        <cfif Application.setup.contacts_noPhoneDups>
            <cfinvoke method="getContactsbyPhone" phones="#arguments.cPhoneMain#,#arguments.cPhone800#" returnvariable="phones">
            <cfif phones.recordcount is not 0>
                <cfreturn -12>
            </cfif>
        </cfif>

        <!--- config.nomailDuplicates --->
        <cfif Application.setup.contacts_noEmailDups>
            <cfinvoke method="getContactsbyEmail" emails="#arguments.cEmail#" returnvariable="emails">
            <cfif emails.recordcount is not 0>
                <cfreturn -13>
            </cfif>
        </cfif>

        <!--- We are ready to insert --->
        <cftry>

            <cfquery dbtype="odbc" datasource="#application.datasource#" result="insert">
            insert into _contacts 
            (
                cCoName
                ,cfirstName
                ,clastName
                ,zipcode
                ,cStreetNum
                ,cPhoneMain
                ,cPhone800
                ,cEmail
                ,cWebsite
                ,refType
                ,isMarina 
                ,isLead 
                ,isOEM 
                ,isMFG 
                ,isOMIM 
                ,isSalC
                ,cOwnerId  
            )
            VALUES 
            (
                 <cfqueryparam value="#arguments.cCoName#">
                ,<cfqueryparam value="#arguments.cFirstName#">
                ,<cfqueryparam value="#arguments.cLastName#">
                ,<cfqueryparam value="#arguments.zipCode#">
                ,<cfqueryparam value="#arguments.cStreetNum#">
                ,<cfqueryparam value="#arguments.cPhoneMain#">
                ,<cfqueryparam value="#arguments.cPhone800#">
                ,<cfqueryparam value="#arguments.cEmail#">
                ,<cfqueryparam value="#arguments.cWebsite#">
                ,<cfqueryparam value="#arguments.refType#">
                ,<cfif listfindnocase(arguments.contactTypes,"isMarina")>1<cfelse>0</cfif>
                ,<cfif listfindnocase(arguments.contactTypes,"isLead")>1<cfelse>0</cfif>
                ,<cfif listfindnocase(arguments.contactTypes,"isOEM")>1<cfelse>0</cfif>
                ,<cfif listfindnocase(arguments.contactTypes,"isMFG")>1<cfelse>0</cfif>
                ,<cfif listfindnocase(arguments.contactTypes,"isOMIM")>1<cfelse>0</cfif>
                ,<cfif listfindnocase(arguments.contactTypes,"isSalC")>1<cfelse>0</cfif>
                ,<cfqueryparam value="#arguments.cOwnerId#">
            )
            </cfquery>
             <cfreturn insert["GENERATEDKEY"]>

            <cfcatch>
                <!--- Log to _errors table for future troubleshooting and return cfcatch error --->
                <cfset Application.helper.logCatchError("contacts.new",arguments,cfcatch)>
                <cfreturn -1001>
            </cfcatch>
        </cftry>
    </cffunction>


    <cffunction name="contactsEdit">
        <!--- min 1 contactype --->
        <cfif len(trim(arguments.contactTypes)) eq 0>
            <cfreturn -9> <!--- at least one contact type --->
        </cfif>

        <!--- config.validateZipcode --->
        <cfif application.setup.contacts_validateZipCode>
            <cfinvoke component="/root/functions/remote" method="getCityStateCountyfromZip" returnvariable="place"
                zipcode="#arguments.zipcode#">
            <!--- returns city, state, country so estimate allowable length to catch error --->
            <cfif len(trim(place)) lt 5 or len(trim(place)) gt 100>
                <cfreturn -10>
            </cfif>
        </cfif>

        <!--- config.validatePhones --->
        <cfif Application.setup.register_validatePhone>
            <cfif Not(isValid("telephone",arguments.cPhoneMain))>
                <cfreturn -11>
            </cfif>
        </cfif>

        <!--- config.nophoneDuplicates --->
        <cfif Application.setup.contacts_noPhoneDups>
            <cfinvoke method="getContactsbyPhone" phones="#arguments.cPhoneMain#,#arguments.cPhone800#" returnvariable="phones">
            <cfquery dbtype="query" name="filterOwn">
                select * from phones where cid <> #arguments.CID#
            </cfquery>
            <cfif filterOwn.recordcount is not 0>
                <cfreturn -12>
            </cfif>
        </cfif>

        <!--- config.nomailDuplicates --->
        <cfif Application.setup.contacts_noEmailDups>
            <cfinvoke method="getContactsbyEmail" emails="#arguments.cEmail#" returnvariable="emails">
            <cfquery dbtype="query" name="filterOwn">
                select * from emails where cid <> #arguments.CID#
            </cfquery>
            <cfif filterOwn.recordcount is not 0>
                <cfreturn -13>
            </cfif>
        </cfif>

        <!--- We are ready to update --->
        <cftry>

            <cfquery dbtype="odbc" datasource="#application.datasource#" result="insert">
            update _contacts
            set cCoName = <cfqueryparam value="#arguments.ccoName#">
                ,cfirstName =  <cfqueryparam value="#arguments.cfirstName#">
                ,clastName = <cfqueryparam value="#arguments.clastName#">
                ,zipcode = <cfqueryparam value="#arguments.zipcode#">
                ,cStreetNum = <cfqueryparam value="#arguments.cstreetNum#">
                ,cPhoneMain = <cfqueryparam value="#arguments.cphoneMain#">
                ,cphone800 = <cfqueryparam value="#arguments.cphone800#"> 
                ,cEmail = <cfqueryparam value="#arguments.cEmail#"> 
                ,cWebsite = <cfqueryparam value="#arguments.cWebsite#"> 
                ,refType = <cfqueryparam value="#arguments.refType#"> 
                ,isMarina = <cfif listfindnocase(arguments.contactTypes,"isMarina")>1<cfelse>0</cfif>
                ,isLead = <cfif listfindnocase(arguments.contactTypes,"isLead")>1<cfelse>0</cfif>
                ,isOEM = <cfif listfindnocase(arguments.contactTypes,"isOEM")>1<cfelse>0</cfif>
                ,isMFG = <cfif listfindnocase(arguments.contactTypes,"isMFG")>1<cfelse>0</cfif>
                ,isOMIM = <cfif listfindnocase(arguments.contactTypes,"isOMIM")>1<cfelse>0</cfif>
                ,isSalC =<cfif listfindnocase(arguments.contactTypes,"isSalC")>1<cfelse>0</cfif>
                ,cLastDate = #createODBCDatetime(now())#
            where cid = <cfqueryparam value="#arguments.cid#">
            </cfquery>

             <cfreturn arguments.cid>

            <cfcatch>
                <!--- Log to _errors table for future troubleshooting and return cfcatch error --->
                <cfset Application.helper.logCatchError("contacts.edit",arguments,cfcatch)>
                <cfreturn -1001>
            </cfcatch>
        </cftry>
    </cffunction>


    <cffunction name="getContactsbyPhone"> 
        <cfargument name="phones">

        <cfquery dbtype="odbc" datasource="#application.datasource#" name="data">
            select * from _contacts where cPhoneMain IN (<cfqueryparam value="#arguments.phones#" list="yes">) 
        </cfquery>
        <cfreturn data>

    </cffunction>

    <cffunction name="getContactsbyEmail"> 
        <cfargument name="emails">

        <cfquery dbtype="odbc" datasource="#application.datasource#" name="data">
            select * from _contacts where cEmail IN (<cfqueryparam value="#arguments.emails#" list="yes">) 
        </cfquery>
        <cfreturn data>

    </cffunction>


    <cffunction name="getContactsMeta">
        <cfargument name="cId">

        <cfquery dbtype="odbc" datasource="#application.datasource#" name="meta">
            select * from _contacts_data 
            where cid = <cfqueryparam value="#arguments.cid#">
            order by dataid desc
        </cfquery>

        <cfreturn meta>
    </cffunction>


    <cffunction name="metaManage">
        <cfargument name="cField">
        <cfargument name="cValue">
        <cfargument name="cId">
        <cfargument name="dataId">

        <!--- if DataID is 0 then it´s new --->
        <cfif arguments.dataID eq 0>
            <cfquery dbtype="odbc" datasource="#application.datasource#" result="insert">
                insert into _contacts_data 
                    (cId, cField, cValue)
                values 
                    (<cfqueryparam value="#arguments.cId#">,<cfqueryparam value="#arguments.cField#">,<cfqueryparam value="#arguments.cValue#">)
            </cfquery>            
            <cfreturn insert["GENERATEDKEY"]>
        <cfelse>
            <cfquery dbtype="odbc" datasource="#application.datasource#" name="update">
                update _contacts_data 
                set cField = <cfqueryparam value="#arguments.cField#">, cValue = <cfqueryparam value="#arguments.cValue#">
                where dataid = <cfqueryparam value="#arguments.dataId#">
            </cfquery>
            <cfreturn arguments.dataID>           
        </cfif>
    </cffunction>


</cfcomponent>