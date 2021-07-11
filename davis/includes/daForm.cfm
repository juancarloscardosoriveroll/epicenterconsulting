<!--- 
This page is a General handler to receive JS Form Posts via AJAX/ASYNC and switch to corresponding component 
It is important that calling forms are id "daForm" so that content can be serialized and submitted, 
action field must always call this form (it is a smooth way fo fix JS/Path problems) 
and it must append URLfield: "daCase" so to route properly. 
For reusability returned data will always be a JSON structure (look at defaultcase)
with regards to view you can use "redirect,reload or stay" in redirect use ";" to send URL as 2nd param.
--->
<cfparam name="url.daCase" default="">

<!--- DEFAULT SETTINGS --->
<cfset resultCode = -1000>
<cfset Result = structnew()>
<cfset Result["success"] = false>
<cfset Result["view"] = "stay;self">
<cfset Result["data"] = structnew()>
<cfset Result["message"] = "Not implemented">

<cfswitch expression="#url.daCase#">


    <cfcase value="register">
        <cfif Not(isdefined("session.userid"))>
            <cfset resultCode = -1002>  <!--- Needs to Login --->
        <cfelseif Not(Application.helper.hasPermit(session.userid,"users.register.write"))>
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


    <cfcase value="userPermits">
        <cfif Not(isdefined("session.userid"))>
            <cfset resultCode = -1002> <!--- Needs to Login --->
        <cfelseif Not(Application.helper.hasPermit(session.userid,"users.userPermits.write"))>
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
        <cfset Result["message"] = "userPassword OK">
    </cfcase>
    <cfcase value="userEdit">
        <cfset Result["message"] = "userEdit OK">
    </cfcase>

</cfswitch>

<!------------------------------------ RETURN ------------------------------------->
<cfif Not(result.success)>
    <!--- Replace with corresponding ErrorMessage --->
    <cfset Result["message"] = evaluate('Application.errors.E_#abs(resultCode)#')>
</cfif>
<!--- Wow factor, replace all string pointers with value of Variables --->
<cfset Result["message"] = Application.helper.replaceVars(result.message,form)>
<cfoutput>#serializeJSON(Result)#</cfoutput>