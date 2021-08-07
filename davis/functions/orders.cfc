<cfcomponent>
    <cffunction name="ordernew">    
        <cfargument name="cid_isinsd">
        <cfargument name="cid_isacct">
        <cfargument name="uid_surveyor">
        <cfargument name="cat_sourcetype">
        <cfargument name="cat_claimtype">
        <cfargument name="cid_isoffice">

        <cftry>
        <cfquery dbtype="odbc" datasource="#application.datasource#" result="insert">
        insert into _orders 
        (
             cid_isinsd
            ,cid_isacct 
            ,uid_surveyor 
            ,cat_sourcetype 
            ,cat_claimtype
            ,cid_isoffice
            ,ownerId
        )
        values 
        (
             <cfqueryparam value="#arguments.cid_isinsd#">
            ,<cfqueryparam value="#arguments.cid_isacct#">
            ,<cfqueryparam value="#arguments.uid_surveyor#">
            ,<cfqueryparam value="#arguments.cat_sourcetype#">
            ,<cfqueryparam value="#arguments.cat_claimtype#">
            ,<cfqueryparam value="#arguments.cid_isoffice#">
            ,<cfqueryparam value="#arguments.ownerId#">
        )
        </cfquery>

        <cfreturn insert["GENERATEDKEY"]>

        <cfcatch>
            <!--- Log to _errors table for future troubleshooting and return cfcatch error --->
            <cfset Application.helper.logCatchError("orders.ordernew",arguments,cfcatch)>
            <cfreturn -1001>
        </cfcatch>
    </cftry>

    </cffunction>

    <cffunction name="orderEdit">
        <cfargument name="cid_isacct">
        <cfargument name="uid_surveyor">
        <cfargument name="cat_sourcetype">
        <cfargument name="cat_claimtype">
        <cfargument name="cid_isoffice">
        <cfargument name="orderid">

        <cftry>

            <cfquery dbtype="odbc" datasource="#application.datasource#" name="update">
                update _orders
                set  cid_isacct = <cfqueryparam value="#arguments.cid_isacct#">
                    ,uid_surveyor = <cfqueryparam value="#arguments.uid_surveyor#">
                    ,cat_sourcetype = <cfqueryparam value="#arguments.cat_sourcetype#">
                    ,cat_claimtype = <cfqueryparam value="#arguments.cat_claimtype#">
                    ,cid_isoffice = <cfqueryparam value="#arguments.cid_isoffice#">
                where orderid = <cfqueryparam value="#arguments.orderid#">
            </cfquery>

            <cfreturn arguments.orderid>

            <cfcatch>
                <!--- Log to _errors table for future troubleshooting and return cfcatch error --->
                <cfset Application.helper.logCatchError("orders.ordernew",arguments,cfcatch)>
                <cfreturn -1001>
            </cfcatch>
        </cftry>

    </cffunction>


    <cffunction name="getOrders">
        <cfargument name="orderid" required="false" default="0">

        <cfquery dbtype="odbc" datasource="#application.datasource#" name="data">
            select * from _orders
            where orderDate > #createdate(1900,1,1)#
            <cfif arguments.orderID gt 0>
                and orderId = <cfqueryparam value="#arguments.orderID#">
            </cfif>
        </cfquery>

        <cfset result = querynew("orderid,orderDate,cid_isInsd,cid_isAcct,uid_surveyor,cat_claimType,cid_isOffice,cat_sourceType,
            isInsd_cFirstName,isAcct_cFirstName,surveyor_cFirstName,claim_name,office_cFirstName",
                                "integer,date,integer,integer,integer,integer,integer,integer,
            varchar,varchar,varchar,varchar,varchar")>

        <cfloop query="data">
            <cfset queryaddrow(result)>
            <cfset querysetcell(result,"orderid",data.orderid)>
            <cfset querysetcell(result,"orderDate",orderDate)>
            <cfset querysetcell(result,"cat_SourceType",cat_sourceType)>

            <cfset insd = Application.contacts.getContacts(cid=cid_isInsd)>
            <cfset querysetcell(result,"cid_isInsd",cid_isInsd)>
            <cfset querysetcell(result,"isInsd_cFirstName",insd.cFirstName)>

            <cfset isAcct = Application.contacts.getContacts(cid=cid_isAcct)>
            <cfset querysetcell(result,"cid_isAcct",cid_isAcct)>
            <cfset querysetcell(result,"isAcct_cFirstName",isAcct.cFirstName)>

            <cfset surveyor = Application.users.getUsers(userid=uid_surveyor)>
            <cfset querysetcell(result,"uid_surveyor",uid_surveyor)>
            <cfset querysetcell(result,"surveyor_cFirstName",surveyor.userFirstName)>

            <cfset claim = Application.catalogs.getItems(catType="claimTypes",itemid=cat_claimType)>
            <cfset querysetcell(result,"cat_claimType",cat_claimType)>
            <cfset querysetcell(result,"claim_name",claim.itemName)>

            <cfset office = Application.contacts.getContacts(cid=cid_isOffice)>
            <cfset querysetcell(result,"cid_isOffice",cid_isOffice)>
            <cfset querysetcell(result,"office_cFirstName",office.cFirstName)>
        </cfloop>

        <cfreturn result>
    </cffunction>

    <cffunction name="getOrderNotes">
        <cfargument name="orderNote_type">
        <cfargument name="orderid">

        <cfquery dbtype="odbc" datasource="#application.datasource#" name="data" maxrows="1">
            select top 1 orderNote_value from _orders_notes
            where orderid = <cfqueryparam value="#arguments.orderid#">
            and orderNote_type = <cfqueryparam value="#arguments.ordernote_type#">
        </cfquery>

        <cfif data.recordcount eq 0>
            <cfreturn "">
        <cfelse>
            <cfreturn data.orderNote_value>
        </cfif>
    </cffunction>

    <cffunction name="saveOrderNotes">
        <cfargument name="orderNote_value">
        <cfargument name="orderNote_type">
        <cfargument name="orderid">

        <cftry>

            <cfquery dbtype="odbc" datasource="#application.datasource#" name="check">
                select noteId
                from _orders_notes 
                where orderid = <cfqueryparam value="#arguments.orderid#">
                and orderNote_type = <cfqueryparam value="#arguments.ordernote_type#">
            </cfquery>

            <cfif check.recordcount eq 0>
                <cfquery dbtype="odbc" datasource="#application.datasource#" name="insert">
                    insert into _orders_notes (orderid, orderNote_type, orderNote_value)
                    values (
                        <cfqueryparam value="#arguments.orderid#">
                        ,<cfqueryparam value="#arguments.ordernote_type#">
                        ,<cfqueryparam value="#arguments.ordernote_value#">)
                </cfquery>
            <cfelse>
                <cfquery dbtype="odbc" datasource="#application.datasource#" name="update">
                    update _orders_notes 
                    set orderNote_value = <cfqueryparam value="#arguments.ordernote_value#">
                    where noteid = #check.noteId#
                </cfquery>
            </cfif>

            <cfreturn true>
            <cfcatch>
                <!--- Log to _errors table for future troubleshooting and return cfcatch error --->
                <cfset Application.helper.logCatchError("orders.orderedit",arguments,cfcatch)>
                <cfreturn -1001>
            </cfcatch>
        </cftry>


    </cffunction>


</cfcomponent>