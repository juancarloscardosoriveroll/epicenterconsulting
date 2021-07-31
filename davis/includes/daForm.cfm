<!--- 
This page is a General handler to receive JS Form Posts via AJAX/ASYNC and switch to corresponding component 
It is important that calling forms are id "daForm" so that content can be serialized and submitted, 
action field must always call this form (it is a smooth way fo fix JS/Path problems) 
and it must append URLfield: "daCase" so to route properly. 
For reusability returned data will always be a JSON structure (look at defaultcase)
with regards to view you can use "redirect,reload or stay" in redirect use ";" to send URL as 2nd param.
--->
<cfparam name="daCase" default="">

<!--- DEFAULT SETTINGS --->
<cfset resultCode = -1000>
<cfset Result = structnew()>
<cfset Result["success"] = false>
<cfset Result["view"] = "stay;self">
<cfset Result["data"] = structnew()>
<cfset Result["message"] = "Not implemented">

<cfswitch expression="#trim(daCase)#">
    <cfcase value="register">
        <cfif Not(isdefined("session.userid"))>
            <cfset resultCode = -1002>  <!--- Needs to Login --->
        <cfelseif Not(Application.helper.hasPermit(session.userid,"users.register"))>
            <cfset resultCode = -1003> <!--- Doesn´t have Permission --->
        <cfelse>
            <!--- Run Component to Create New Account --->
            <cfinvoke component="/root/functions/users" method="createUser" returnvariable="resultCode"
                useremail="#form.userEmail#"
                userPass="#form.userPass#"
                userFirstName="#form.userFirstName#"
                userLastName="#form.userLastName#"
                userPhone="#form.userPhone#">
        </cfif>

        <!--- Good Result (Registry Success) --->
        <cfif resultCode GT 0>
            <cfset Result["success"] = true>
            <cfset Result["message"] = Application.labels["register_success"]>
            <cfset Result["view"] = "redirect;" & Application.urlPath & "/?view=userList&userid=" & resultCode>
            <cfset form["userId"] = resultCode> <!--- add this to form to customize msg --->
        </cfif>
    </cfcase>

    <cfcase value="login">
        <!--- Run Component to Change Password --->
        <cfinvoke component="/root/functions/users" method="login" returnvariable="resultCode"
                userPass="#form.userPass#" 
                userEmail="#form.userEmail#" >

        <!--- Good Result (update Success) --->
        <cfif resultCode GT 0>
            <cfset Result["success"] = true>
            <cfset Result["message"] = Application.labels["login_welcome"]>
            <cfset Result["view"] = "redirect;" & Application.urlPath & "/?view=dashboard&accessToken=#resultCode#">
        </cfif>

    </cfcase>

    <cfcase value="userPermits">
        <cfif Not(isdefined("session.userid"))>
            <cfset resultCode = -1002> <!--- Needs to Login --->
        <cfelseif Not(Application.helper.hasPermit(session.userid,"users.permits"))>
            <cfset resultCode = -1003> <!--- Doesn´t have Permission --->
        <cfelseif session.userid eq form.userid>
            <cfset resultCode = -1004> <!--- Cannot modify his own Permissions --->
        <cfelse>
            <!--- Run Component to Set Permits --->
            <cfparam name="form.permitName" default=""> <!--- if null must exist to delete --->
            <cfinvoke component="/root/functions/users" method="setPermits" returnvariable="resultCode"
                  permitNames="#form.permitName#" 
                  userid="#form.userId#" >
        </cfif>

        <!--- Good Result (update Success) --->
        <cfif resultCode GT 0>
            <cfset Result["success"] = true>
            <cfset Result["message"] = Application.labels["useredit_permits_success"]>
        </cfif>
    </cfcase>

    <cfcase value="userPassword">
        <cfif Not(isdefined("session.userid"))>
            <cfset resultCode = -1002> <!--- Needs to Login --->
        <cfelseif (session.userid neq form.userid) AND (Not(Application.helper.hasPermit(session.userid,"users.password")))>
            <cfset resultCode = -1003> <!--- Doesn´t have Permission --->
        <cfelse>
            <!--- Run Component to Change Password --->
            <cfinvoke component="/root/functions/users" method="setPassword" returnvariable="resultCode"
                  userPass="#form.userPass#" 
                  userid="#form.userId#" >
        </cfif>

        <!--- Good Result (update Success) --->
        <cfif resultCode GT 0>
            <cfset Result["success"] = true>
            <cfset Result["message"] = Application.labels["useredit_password_success"]>
        </cfif>
    </cfcase>

    <cfcase value="userEdit">
        <cfif Not(isdefined("session.userid"))>
            <cfset resultCode = -1002> <!--- Needs to Login --->
        <cfelseif (session.userid neq form.userid) AND (Not(Application.helper.hasPermit(session.userid,"users.edit")))>
            <cfset resultCode = -1003> <!--- Doesn´t have Permission --->
        <cfelse>
            <!--- Run Component to Change Password --->
            <cfinvoke component="/root/functions/users" method="userEdit" returnvariable="resultCode"
                    useremail="#form.userEmail#"
                    userFirstName="#form.userFirstName#"
                    userLastName="#form.userLastName#"
                    userPhone="#form.userPhone#"
                    userid="#form.userId#" >
        </cfif>

        <!--- Good Result (update Success) --->
        <cfif resultCode GT 0>
            <cfset Result["success"] = true>
            <cfset Result["message"] = Application.labels["useredit_success"]>
        </cfif>

    </cfcase>

    <cfcase value="newContact">
        <cfif Not(isdefined("session.userid"))>
            <cfset resultCode = -1002> <!--- Needs to Login --->
        <cfelseif Not(Application.helper.hasPermit(session.userid,"contacts.new"))>
            <cfset resultCode = -1003> <!--- Doesn´t have Permission --->
        <cfelse>
            <!--- Run Component to Change Password --->
            <cfparam name="form.contactTypes" default="">
            <cfinvoke component="/root/functions/contacts" method="newcontact" returnvariable="resultCode"
                    cCoName="#form.cCoName#"
                    cFirstName="#form.cFirstName#"
                    cLastName="#form.cLastName#"
                    cPhoneMain="#form.cPhoneMain#"
                    cEmail="#form.cEmail#"
                    cStreetNum="#form.cStreetNum#"
                    zipcode="#form.zipcode#"
                    contactTypes="#form.contactTypes#"
                    cownerid="#session.userID#"
                    ccountry="#form.ccountry#">  
        </cfif>

        <!--- Good Result (update Success) --->
        <cfif resultCode GT 0>
            <!--- Get recently created contact to determine if redirect to contactkey is needed --->
            <cfinvoke component="/root/functions/contacts" method="getcontacts" returnvariable="mycontact" cid="#resultCode#">
            <cfif form.newOrder eq 1>
                <cfset Result["view"] = "redirect;" & Application.urlPath & "/?view=neworder&cid=" & resultCode>
            </cfif>
            <cfif mycontact.reqKeys gt 0> 
                <cfset Result["view"] = "redirect;" & Application.urlPath & "/?view=contactkeys&newOrder=" & form.newOrder & "&cid=" & resultCode>
            </cfif>
            <cfset Result["success"] = true>
            <cfset Result["message"] = Application.labels["newcontact_success"]>
        </cfif>
    </cfcase>


    <cfcase value="contactEdit">
        <cfif Not(isdefined("session.userid"))>
            <cfset resultCode = -1002> <!--- Needs to Login --->
        <cfelseif (session.userid neq form.cownerid) AND (Not(Application.helper.hasPermit(session.userid,"contacts.edit")))>
            <cfset resultCode = -1003> <!--- Doesn´t have Permission --->
        <cfelse>
            <!--- Run Component to Change Password --->
            <cfparam name="form.contactTypes" default="">
            <cfinvoke component="/root/functions/contacts" method="contactsedit" returnvariable="resultCode"
                    cCoName="#form.cCoName#"
                    cFirstName="#form.cFirstName#"
                    cLastName="#form.cLastName#"
                    cPhoneMain="#form.cPhoneMain#"
                    cEmail="#form.cEmail#"
                    cStreetNum="#form.cStreetNum#"
                    zipcode="#form.zipcode#"
                    contactTypes="#form.contactTypes#"
                    cId="#form.cId#"
                    ccountry="#form.ccountry#"> 
        </cfif>

        <!--- Good Result (update Success) --->
        <cfif resultCode GT 0>
            <cfset Result["success"] = true>
            <cfset Result["message"] = Application.labels["contactedit_success"]>
        </cfif>


    </cfcase>



    <cfcase value="itemNew">
        <cfif Not(isdefined("session.userid"))>
            <cfset resultCode = -1002>  <!--- Needs to Login --->
        <cfelseif Not(Application.helper.hasPermit(session.userid,"catalogs.itemnew"))>
            <cfset resultCode = -1003> <!--- Doesn´t have Permission --->
        <cfelse>
            <!--- Run Component to Create New Account --->
            <cfinvoke component="/root/functions/catalogs" method="itemnew" returnvariable="resultCode"
                itemName="#form.itemName#" 
                itemDesc="#form.itemDesc#" 
                catType="#form.catType#"
                ownerid="#session.userID#">
        </cfif>

        <cfif resultCode GT 0>
            <cfset Result["success"] = true>
            <cfset Result["message"] = Application.labels["itemnew_success"]>
            <cfset Result["view"] = "redirect;" & Application.urlPath & "/?view=catalogs&cattype=" & form.cattype>
            <cfset form["catId"] = resultCode> <!--- add this to form to customize msg --->
        <cfelse>
            <cfset form["itemName"] = listfirst(form.itemName,' ')> <!--- to improve error msg --->            
        </cfif>

    </cfcase>

    <cfcase value="itemEdit">
        <cfif Not(isdefined("session.userid"))>
            <cfset resultCode = -1002>  <!--- Needs to Login --->
        <cfelseif (session.userid neq form.ownerid) AND (Not(Application.helper.hasPermit(session.userid,"catalogs.itemedit")))>
            <cfset resultCode = -1003> <!--- Doesn´t have Permission --->
        <cfelse>
            <!--- Run Component to Create New Account --->
            <cfinvoke component="/root/functions/catalogs" method="itemEdit" returnvariable="resultCode"
                itemName="#form.itemName#" 
                itemDesc="#form.itemDesc#" 
                itemId="#form.itemId#"
                catType="#form.catType#">
        </cfif>

        <cfif resultCode GT 0>
            <cfset Result["success"] = true>
            <cfset Result["message"] = Application.labels["itemedit_success"]>
            <cfset Result["view"] = "redirect;" & Application.urlPath & "/?view=catalogs&cattype=" & form.cattype>
            <cfset form["catId"] = resultCode> <!--- add this to form to customize msg --->
        </cfif>
    </cfcase>

    <cfcase value="contactMeta">
        <cfif Not(isdefined("session.userid"))>
            <cfset resultCode = -1002>  <!--- Needs to Login --->
        <cfelseif (session.userid neq form.cownerid) AND (Not(Application.helper.hasPermit(session.userid,"contacts.edit")))>
            <cfset resultCode = -1003> <!--- Doesn´t have Permission --->
        <cfelse>
            <!--- Run Component to Create New Account --->
            <cfinvoke component="/root/functions/contacts" method="metamanage" returnvariable="resultCode"
                cForm="#form#" 
                cID="#form.cID#">
        </cfif>

        <cfif resultCode GT 0>
            <cfset Result["success"] = true>
            <cfset Result["message"] = Application.labels["contactmeta_success"]>
            <cfset Result["view"] = "reload;self">
        </cfif>
    </cfcase>


    <cfcase value="daToggle">
        <!--- this Case is the "HUB" for all ON/OFF requests from url --->
        <cfset methodName = replacenocase(daPermit,'.','','ALL')>

        <cfif Not(isdefined("session.userid"))>
            <cfset resultCode = -1002> <!--- Needs to Login --->
        <cfelseif Not(Application.helper.hasPermit(session.userid,daPermit))>
            <cfset resultCode = -1003> <!--- Doesn´t have Permission --->
        <cfelse>
            <!--- Run Component to Change Password --->
            <cfinvoke component="/root/functions/daToggle" method="#methodName#" returnvariable="resultCode"
                    id="#url.Id#">

            <!--- RETURNS based on function, try to Use resultCode as callback value --->
            <cfswitch expression="#methodName#">
                <cfcase value="usersactive,catalogsactive,contactsactive">
                    <cfset Result["success"] = true>
                    <cfset Result["view"] = "stay;self">
                    <cfset Result["message"] = Application.labels['general_success']>
                    <cfset Result["data"] = structnew()>
                    <cfset Result.data["callback"] = resultCode>
                </cfcase>
                <cfcase value="contactsmetadelete">
                    <cfset Result["success"] = true>
                    <cfset Result["view"] = "reload;self">
                    <cfset Result["message"] = Application.labels['general_success']>
                    <cfset Result["data"] = structnew()>
                </cfcase>
            </cfswitch>

        </cfif>


    </cfcase>



</cfswitch>

<!------------------------------------ RETURN ------------------------------------->
<cfif Not(result.success)>
    <!--- Replace with corresponding ErrorMessage --->
    <cfset Result["message"] = evaluate('Application.errors.E_#abs(resultCode)#')>
</cfif>
<cfif resultCode eq -1002>
    <!--- If Needs to login then redirect --->
    <cfset Result["view"] = "redirect;" & Application.urlPath & "/?view=login">
</cfif>

<!--- Wow factor, replace all string pointers with value of Variables --->
<cfset Result["message"] = Application.helper.replaceVars(result.message,form)>
<cfoutput>#serializeJSON(Result)#</cfoutput>