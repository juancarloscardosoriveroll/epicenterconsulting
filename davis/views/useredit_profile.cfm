<cfoutput>
<h4 class="card-title">#Application.labels["register_header"]#</h4>
<p class="card-title-desc">#Application.labels["register_intro"]#</p>

<form class="custom-validation daForm" id="daForm1" action="#Application.urlPath#/includes/daForm.cfm?daCase=userEdit">
    <div class="mb-3">
        <label class="form-label">#Application.labels["register_firstname_label"]#</label>
        <div>
            <input name="userFirstName" id="userFirstName"  type="text" class="form-control"
                required placeholder="#Application.labels['register_firstname_help']#" value="#trim(Usr.userfirstname)#" />
        </div>
    </div>
    
    <div class="mb-3">
        <label class="form-label">#Application.labels["register_lastname_label"]#</label>
        <div>
            <input name="userLastName" id="userLastName" type="text" class="form-control"
                required placeholder="#Application.labels['register_lastname_help']#" value="#trim(Usr.userLastname)#"  />
        </div>
    </div>

    <div class="mb-3">
        <label class="form-label">#Application.labels["register_email_label"]#</label>
        <div>
            <input name="userEmail" id="userEmail" type="email" class="form-control" required parsley-type="email"
                placeholder="#Application.labels['register_email_help']#"  value="#trim(Usr.userEmail)#"  />
        </div>
    </div>

    <div class="mb-3">
        <label class="form-label">#Application.labels["register_phone_label"]#</label>
        <div>
            <input name="userPhone" id="userPhone" data-parsley-type="number" type="text" class="form-control" required
                placeholder="#Application.labels['register_phone_help']#"  value="#trim(Usr.userPhone)#"  />
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