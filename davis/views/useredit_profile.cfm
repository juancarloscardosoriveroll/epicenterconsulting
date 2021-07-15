<!--- Variable to customize UX and disable if needed --->
<cfset disableBtn = true>
<cfif Application.helper.hasPermit(session.userid,"users.edit") OR (session.userid EQ url.userid)>
    <cfset disableBtn = false>
</cfif>


<cfoutput>
<h4 class="card-title">#Application.labels["useredit_header"]# "<b>#Usr.userfirstname# #Usr.userlastname#</b>" (id: #Usr.userid#)</h4>
<p class="card-title-desc">#Application.labels["useredit_intro"]#</p>

<form class="custom-validation daForm" id="daForm1" action="#Application.urlPath#/includes/daForm.cfm?daCase=userEdit">
    <input type="hidden" name="userId" value="#url.userid#">
    <div class="mb-3">
        <label class="form-label">#Application.labels["useredit_firstname_label"]#</label>
        <div>
            <input name="userFirstName" id="userFirstName"  type="text" class="form-control" <cfif disableBtn> disabled </cfif>
                required placeholder="#Application.labels['useredit_firstname_help']#" value="#trim(Usr.userfirstname)#" />
        </div>
    </div>
    
    <div class="mb-3">
        <label class="form-label">#Application.labels["useredit_lastname_label"]#</label>
        <div>
            <input name="userLastName" id="userLastName" type="text" class="form-control" <cfif disableBtn> disabled </cfif>
                required placeholder="#Application.labels['useredit_lastname_help']#" value="#trim(Usr.userLastname)#"  />
        </div>
    </div>

    <div class="mb-3">
        <label class="form-label">#Application.labels["useredit_email_label"]#</label>
        <div>
            <input name="userEmail" id="userEmail" type="email" class="form-control" required parsley-type="email" <cfif disableBtn> disabled </cfif>
                placeholder="#Application.labels['useredit_email_help']#"  value="#trim(Usr.userEmail)#"  />
        </div>
    </div>

    <div class="mb-3">
        <label class="form-label">#Application.labels["useredit_phone_label"]#</label>
        <div>
            <input name="userPhone" id="userPhone" data-parsley-type="number" type="text" class="form-control" required <cfif disableBtn> disabled </cfif>
                placeholder="#Application.labels['useredit_phone_help']#"  value="#trim(Usr.userPhone)#"  />
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
                    #Application.labels["useredit_submit"]#
                </button>
                <button type="reset" class="btn btn-secondary waves-effect">
                    #Application.labels["useredit_reset"]#
                </button>
            </div>
        </div>
    </cfif>
</form>
</cfoutput>