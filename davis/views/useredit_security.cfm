<!--- Variable to customize UX and disable if needed --->
<cfset disableBtn = true>
<cfif Application.helper.hasPermit(session.userid,"users.password") OR (session.userid EQ url.userid)>
    <cfset disableBtn = false>
</cfif>


<cfoutput>
<h4 class="card-title">#Application.labels["useredit_security_header"]# "<b>#Usr.userfirstname# #Usr.userlastname#</b>" (id: #Usr.userid#)</h4>
<p class="card-title-desc">#Application.labels["useredit_security_intro"]#</p>

<form class="custom-validation daForm" id="daForm2" action="#Application.urlPath#/includes/daForm.cfm?daCase=userPassword">
    <input type="hidden" name="userId" value="#url.userid#">

    <div class="mb-3">
        <label class="form-label">#Application.labels["useredit_security_password"]#</label>
        <div>
            <input name="userPass" id="userPass"  type="text" class="form-control" <cfif disableBtn> disabled </cfif>
                required placeholder="#Application.labels['useredit_security_password_help']#" value="" />
        </div>
    </div>
    <cfif disableBtn>
        <!--- No Permit --->        
        <div class="card-footer">
            <div class="alert alert-danger" role="alert">#application.errors['E_1003']# </div>
        </div>
    <cfelse>
        <!--- Submit Buttons --->
        <div>
            <div>
                <button type="submit" class="btn btn-primary waves-effect waves-light me-1">
                    #Application.labels["useredit_security_submit"]#
                </button>
                <button type="reset" class="btn btn-secondary waves-effect">
                    #Application.labels["useredit_security_reset"]#
                </button>
            </div>
        </div>
    </cfif>
</form>
</cfoutput>
        