<cfoutput>
<h4 class="card-title">Change Password</h4>
<p class="card-title-desc">Enter a new Password to change it</p>

<form class="custom-validation daForm" id="daForm2" action="#Application.urlPath#/includes/daForm.cfm?daCase=userPassword">
    <div class="mb-3">
        <label class="form-label">#Application.labels["register_firstname_label"]#</label>
        <div>
            <input name="userPassword" id="userFirstName"  type="text" class="form-control"
                required placeholder="#Application.labels['register_firstname_help']#" value="" />
        </div>
    </div>

    <div>
        <div>
            <button type="submit" class="btn btn-primary waves-effect waves-light me-1">
                #Application.labels["register_submit"]#
            </button>
            <button type="reset" class="btn btn-secondary waves-effect">
                #Application.labels["register_reset"]#
            </button>
        </div>
    </div>
</form>
</cfoutput>
        