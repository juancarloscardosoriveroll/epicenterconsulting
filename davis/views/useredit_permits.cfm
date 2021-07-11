<cfoutput>
<h4 class="card-title">Set Permits "<b>#Usr.userfirstname# #Usr.userlastname#</b>" (id: #Usr.userid#)</h4>
<p class="card-title-desc">Define the views and permits this User can execute</p>

<form class="custom-validation daForm" id="daForm3" action="#Application.urlPath#/includes/daForm.cfm?daCase=userPermits">
    <input type="hidden" name="userid" value="#url.userid#">
    <div class="table-responsive mb-3">
        <table class="table table-borderless mb-0"> 

            <thead>
                <tr>
                    <th>Permit</th>
                    <th>Description</th> 
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
                                <input class="form-check-input" type="checkbox" name="permitName" value="#thisPermit.permitName#" id="flexSwitchCheckChecked" <cfif listfindnocase(Permits,thisPermit.permitName)> checked </cfif>>
                                <label class="form-check-label ms-1" for="flexSwitchCheckChecked"></label>
                            </div>
                        </td>
                    </tr>
                </cfloop>
            </tbody>
        </table>
    </div>
    <div>
        <button type="submit" class="btn btn-primary waves-effect waves-light me-1">
            #Application.labels["register_submit"]#
        </button>
        <button type="reset" class="btn btn-secondary waves-effect">
            #Application.labels["register_reset"]#
        </button>
    </div>

</form>
</cfoutput>