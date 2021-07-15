<!--- Variable to customize UX and disable if needed --->
<cfset disableBtn = true>
<cfif Application.helper.hasPermit(session.userid,"users.permits")>
    <cfset disableBtn = false>
</cfif>

<cfoutput>
<h4 class="card-title">#Application.labels["useredit_permits_header"]# "<b>#Usr.userfirstname# #Usr.userlastname#</b>" (id: #Usr.userid#)</h4>
<p class="card-title-desc">#Application.labels["useredit_permits_intro"]#</p>

<form class="custom-validation daForm" id="daForm3" action="#Application.urlPath#/includes/daForm.cfm?daCase=userPermits">
    <input type="hidden" name="userid" value="#url.userid#">
    <div class="table-responsive mb-3">
        <table class="table table-borderless mb-0"> 

            <thead>
                <tr>
                    <th>#Application.labels["useredit_permits_permit"]#</th>
                    <th>#Application.labels["useredit_permits_description"]#</th> 
                    <th>&nbsp;</th>
                </tr>
            </thead>
            <tbody>
                <cfloop from="1" to="#arraylen(Application.permits)#" index="Permit">
                    <cfset thisPermit = Application.permits[permit]>
                    <tr>
                        <td>#thisPermit.permitName#</td>
                        <td>#thisPermit.describe#</td>
                        <td>
                            <div class="form-check form-switch">     
                                <input class="form-check-input" type="checkbox" name="permitName" value="#thisPermit.permitName#" id="flexSwitchCheckChecked" <cfif listfindnocase(Permits,thisPermit.permitName)> checked </cfif> <cfif disableBtn> disabled </cfif>>
                                <label class="form-check-label ms-1" for="flexSwitchCheckChecked"></label>
                            </div>
                        </td>
                    </tr>
                </cfloop>
            </tbody>
        </table>
    </div>
    <cfif disableBtn>
        <!--- No Permit --->        
        <div class="card-footer">
            <div class="alert alert-danger" role="alert">#application.errors['E_1003']# </div>
        </div>
    <cfelse>
        <!--- Submit Buttons --->
        <div>
            <button type="submit" class="btn btn-primary waves-effect waves-light me-1">
                #Application.labels["useredit_permits_submit"]#
            </button>
            <button type="reset" class="btn btn-secondary waves-effect">
                #Application.labels["useredit_permits_reset"]#
            </button>
        </div>
    </cfif>
</form>
</cfoutput>