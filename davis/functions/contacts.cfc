<cfcomponent>
    <cffunction name="getContacts">
        <cfargument name="contactTypes" required="false" default="" type="string" hint="list of types">
        <cfargument name="cID" default="0" type="integer" required="false">
        <cfargument name="cIsValid" default="BOTH" required="false" hint="1,0,BOTH">

        <cfquery dbtype="odbc" datasource="#application.datasource#" name="data">
        select c.*, u.userFirstName, 0 as meta, 0 as keys, 0 as reqkeys, '' as allkeys 
        from _contacts c, _users u
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
            <cfif listfindnocase(arguments.contactTypes,'isAcct')>
                and c.isAcct = 1
            </cfif> 
            <cfif listfindnocase(arguments.contactTypes,'isInsd')>
                and c.isInsd = 1
            </cfif> 
            <cfif listfindnocase(arguments.contactTypes,'isOffice')>
                and c.isOffice = 1
            </cfif> 

            <cfif arguments.cid gt 0>
                and c.cid = <cfqueryparam value="#arguments.cid#">
            </cfif>    
            <cfif arguments.cIsValid neq 'BOTH'>
                and c.cisValid = <cfqueryparam value="#arguments.cIsValid#">                
            </cfif>           
        order by c.cID desc     
        </cfquery> 

        <!--- Meta Data --->
        <cfloop query="data">
            <cfquery dbtype="odbc" datasource="#application.datasource#" name="cuenta">
                select count(*) as total from _contacts_data where cid = <cfqueryparam value="#data.cid[currentRow]#">
            </cfquery>
            <cfset querysetcell(data,"meta",cuenta.total,data.currentRow)>
        </cfloop>

        <!--- Number of Keys --->
        <cfloop query="data">
            <cfset reqK = 0>
            <cfset KList = "">
            <cfloop from="1" to="#arraylen(Application.setup.rkeycontacts)#" index="K">
                <cfset cKey =  Application.setup.rkeycontacts[K]>
                <cfif isLead AND cKey.type eq 'isLead'><cfset reqK = reqK+1></cfif> 
                <cfif isMarina AND cKey.type eq 'isMarina'><cfset reqK = reqK+1></cfif> 
                <cfif isOEM AND cKey.type eq 'isOEM'><cfset reqK = reqK+1></cfif> 
                <cfif isMFG AND cKey.type eq 'isMFG'><cfset reqK = reqK+1></cfif> 
                <cfif isOMIM AND cKey.type eq 'isOMIM'><cfset reqK = reqK+1></cfif> 
                <cfif isSalC AND cKey.type eq 'isSalC'><cfset reqK = reqK+1></cfif> 
                <cfif isAcct AND cKey.type eq 'isAcct'><cfset reqK = reqK+1></cfif> 
                <cfif isInsd AND cKey.type eq 'isInsd'><cfset reqK = reqK+1></cfif> 
                <cfif isOffice AND cKey.type eq 'isOffice'><cfset reqK = reqK+1></cfif> 
            </cfloop>
            <cfif isLead><cfset KList = listappend(Klist,'islead')></cfif>
            <cfif isMarina><cfset KList = listappend(Klist,'isMarina')></cfif>
            <cfif isOEM><cfset KList = listappend(Klist,'isOEM')></cfif>
            <cfif isMFG><cfset KList = listappend(Klist,'isMFG')></cfif>
            <cfif isOMIM><cfset KList = listappend(Klist,'isOMIM')></cfif>
            <cfif isSalC><cfset KList = listappend(Klist,'isSalC')></cfif>
            <cfif isAcct><cfset KList = listappend(Klist,'isAcct')></cfif>
            <cfif isInsd><cfset KList = listappend(Klist,'isInsd')></cfif>
            <cfif isOffice><cfset KList = listappend(Klist,'isOffice')></cfif>
            
            <cfset querysetcell(data,"reqKeys",reqK,data.currentRow)>
            <cfset querysetcell(data,"allkeys",kList,data.currentRow)>
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
            <cfinvoke method="getContactsbyPhone" phones="#arguments.cPhoneMain#" returnvariable="phones">
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

        <!--- NO DUPLICATES --->
        <cfif len(trim(arguments.cCustomKey)) gt 0>
            <cfquery dbtype="odbc" datasource="#application.datasource#" name="checkKey">
                select * from _contacts 
                where cCustomKey = <cfqueryparam value="#arguments.cCustomKey#">
            </cfquery>
            <cfif checkKey.recordcount neq 0>
                <cfreturn -14>
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
                ,cEmail
                ,cCountry
                ,isMarina 
                ,isLead 
                ,isOEM 
                ,isMFG 
                ,isOMIM 
                ,isSalC
                ,isAcct 
                ,isInsd
                ,isOffice
                ,cOwnerId  
                ,cCustomKey
            )
            VALUES 
            (
                 <cfqueryparam value="#arguments.cCoName#">
                ,<cfqueryparam value="#arguments.cFirstName#">
                ,<cfqueryparam value="#arguments.cLastName#">
                ,<cfqueryparam value="#arguments.zipCode#">
                ,<cfqueryparam value="#arguments.cStreetNum#">
                ,<cfqueryparam value="#arguments.cPhoneMain#">
                ,<cfqueryparam value="#arguments.cEmail#">
                ,<cfqueryparam value="#arguments.cCountry#">
                ,<cfif listfindnocase(arguments.contactTypes,"isMarina")>1<cfelse>0</cfif>
                ,<cfif listfindnocase(arguments.contactTypes,"isLead")>1<cfelse>0</cfif>
                ,<cfif listfindnocase(arguments.contactTypes,"isOEM")>1<cfelse>0</cfif>
                ,<cfif listfindnocase(arguments.contactTypes,"isMFG")>1<cfelse>0</cfif>
                ,<cfif listfindnocase(arguments.contactTypes,"isOMIM")>1<cfelse>0</cfif>
                ,<cfif listfindnocase(arguments.contactTypes,"isSalC")>1<cfelse>0</cfif>
                ,<cfif listfindnocase(arguments.contactTypes,"isAcct")>1<cfelse>0</cfif>
                ,<cfif listfindnocase(arguments.contactTypes,"isInsd")>1<cfelse>0</cfif>
                ,<cfif listfindnocase(arguments.contactTypes,"isOffice")>1<cfelse>0</cfif>
                ,<cfqueryparam value="#arguments.cOwnerId#">
                ,<cfqueryparam value="#arguments.cCustomKey#">
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
            <cfinvoke method="getContactsbyPhone" phones="#arguments.cPhoneMain#" returnvariable="phones">
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

        <!--- NO DUPLICATES --->
        <cfif len(trim(arguments.cCustomKey)) gt 0>
            <cfquery dbtype="odbc" datasource="#application.datasource#" name="checkKey">
                select * from _contacts 
                where cCustomKey = <cfqueryparam value="#arguments.cCustomKey#">
                and cid <> #arguments.CID#
            </cfquery>
            <cfif checkKey.recordcount neq 0>
                <cfreturn -14>
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
                ,cEmail = <cfqueryparam value="#arguments.cEmail#"> 
                ,cCountry = <cfqueryparam value="#arguments.cCountry#"> 
                ,isMarina = <cfif listfindnocase(arguments.contactTypes,"isMarina")>1<cfelse>0</cfif>
                ,isLead = <cfif listfindnocase(arguments.contactTypes,"isLead")>1<cfelse>0</cfif>
                ,isOEM = <cfif listfindnocase(arguments.contactTypes,"isOEM")>1<cfelse>0</cfif>
                ,isMFG = <cfif listfindnocase(arguments.contactTypes,"isMFG")>1<cfelse>0</cfif>
                ,isOMIM = <cfif listfindnocase(arguments.contactTypes,"isOMIM")>1<cfelse>0</cfif>
                ,isSalC =<cfif listfindnocase(arguments.contactTypes,"isSalC")>1<cfelse>0</cfif>
                ,isAcct =<cfif listfindnocase(arguments.contactTypes,"isAcct")>1<cfelse>0</cfif>
                ,isInsd =<cfif listfindnocase(arguments.contactTypes,"isInsd")>1<cfelse>0</cfif>
                ,isOffice =<cfif listfindnocase(arguments.contactTypes,"isOffice")>1<cfelse>0</cfif>
                ,cCustomKey = <cfqueryparam value="#arguments.cCustomKey#">
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

        <!--- return as Struct --->
        <cfset result = structnew()>
        <cfloop query="meta">
            <cfset result["#cField#"] = cValue>
        </cfloop>

        <cfreturn result>
    </cffunction>

    <cffunction name="getContactsFromMeta">
        <cfargument name="contactType">
        <cfargument name="filterKeys" required="false" default="">

        <cfset result = arraynew(1)>

        <!--- get keyID --->
        <cfloop from="1" to="#arraylen(application.setup.rkeycontacts)#" index="TC">
            <cfif (application.setup.rkeycontacts[TC].type eq arguments.contactType) and 
                  (application.setup.rkeycontacts[TC].isPrimary)>
                <cfset metaKey = application.setup.rkeycontacts[TC].fieldName>

                <cfquery dbtype="odbc" datasource="#application.datasource#" name="refs">
                    select * from _contacts_data d, _contacts c, _catalogs t
                    where c.cid = d.cid 
                    and d.cValue = t.itemid 
                    and d.cField = <cfqueryparam value="#metaKey#">
                    and c.cisValid = 1
                    order by itemName asc, cfirstName asc, cCoName asc
                </cfquery>
                
                <cfoutput query="refs">
                    <cfset AddRow = true>
                    <cfif len(arguments.filterKeys) gt 0>
                        <cfif Not(listfindnocase(arguments.filterKeys,trim(itemName)))>
                            <cfset AddRow = false>
                        </cfif>
                    </cfif>
                    <cfif AddRow>
                        <cfset temp_s = structnew()>
                        <cfset temp_s["cid"] = cid> 
                        <cfset temp_s["itemName"] = "">
                        <cfif isdefined("itemName")>
                            <cfset temp_s["itemName"] = itemName> 
                        </cfif>
                        <cfset temp_s["cCoName"] = trim(cCoName)>
                        <cfset temp_s["cFirstName"] = trim(cFirstName)>
                        <cfset temp_s["cEmail"] = trim(cEmail)>
                        <cfset temp_s["cPhoneMain"] = trim(cPhoneMain)>
                        <cfset temp_s["zipcode"] = trim(zipcode)>
                        <cfset temp_s["cCustomKey"] = trim(cCustomKey)> 
                        <cfset arrayappend(result,temp_s)>
                    </cfif>
                </cfoutput>


            </cfif>
        </cfloop>

        <cfreturn result>

    </cffunction>


    <cffunction name="metaManage">
        <cfargument name="cForm">
        <cfargument name="cId">

        <cfquery dbtype="odbc" datasource="#application.datasource#" name="check">
            delete from _contacts_data
            where cid = <cfqueryparam value="#arguments.cid#">
        </cfquery>

        <cfloop collection="#cForm#" item="K">

            <cfset thisValue = evaluate('arguments.cForm.' & K)>
            <cfif len(trim(thisValue)) gt 0 and Not(listfindnocase('fieldnames,cid,cownerId',K))>

                <cfset insert = true>
                <cfloop from="1" to="#arraylen(application.setup.metacontacts)#" index="TC">
                    <cfset thisField = application.setup.metacontacts[TC]>
                    <cfif thisField.fieldName EQ K AND thisField.default eq thisValue>
                        <cfset insert = false>
                    </cfif>
                </cfloop>

                <cfif insert>
                    <cfquery dbtype="odbc" datasource="#application.datasource#" name="insert">
                        insert into _contacts_data (cField,cvalue,cid) 
                        values (
                            <cfqueryparam value="#K#">
                            ,<cfqueryparam value="#thisValue#">
                            ,<cfqueryparam value="#arguments.cid#">)
                    </cfquery>
                </cfif>

            </cfif>
        </cfloop>

        <cfreturn 1>
    </cffunction>

    <cffunction name="getStats">

        <cfset Result = structnew()>
        <cfset fields = "isMarina,isLead,isOEM,isMFG,isOMIM,isSalC,isAcct,isInsd,isOffice">
        <cfloop list="#fields#" index="F">
            <cfquery dbtype="odbc" datasource="#application.datasource#" name="count">
                select count(*) as total
                from _contacts 
                where #F# = 1
            </cfquery>
            <cfset Result["#F#"] = count.total>
        </cfloop>

        <cfreturn Result>
    </cffunction>

</cfcomponent>