<cfoutput>
<div class="row justify-content-center">
    <div class="col-md-8 col-lg-6 col-xl-5">
        <div class="card overflow-hidden">
            <div class="card-body pt-5">
                <div class="p-2">
                    <form class="custom-validation daForm" id="daForm3" action="#Application.urlPath#/includes/daForm.cfm?daCase=login">

                        <div class="mb-3">
                            <label class="form-label">#Application.labels["register_email_label"]#</label>
                            <div>
                                <input name="userEmail" id="userEmail" type="email" class="form-control" required parsley-type="email"
                                    placeholder="#Application.labels['register_email_help']#" />
                            </div>
                        </div>
    
                        <div class="mb-3">
                            <label class="form-label">#Application.labels["register_password_label"]#</label>
                            <div>
                                <input name="userPass" id="userPass" type="password" class="form-control"
                                    required placeholder="#Application.labels['register_password_help']#" />
                            </div>
                        </div>
    
                        <div class="mt-3">
                            <button class="btn btn-primary w-100 waves-effect waves-light" type="submit">Log
                                In</button>
                        </div>

                        <!---
                        <div class="mt-4 text-center">
                            <a href="pages-recoverpw.html" class="text-muted"><i
                                    class="mdi mdi-lock me-1"></i> Forgot your password?</a>
                        </div>
                        --->
                    </form>
                </div>

            </div>
        </div>

    </div>
</div>
</cfoutput>
