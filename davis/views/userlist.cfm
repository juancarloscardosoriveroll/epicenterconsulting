<cfinvoke component="/root/functions/users" method="getUsers" returnvariable="Users" />
<cfoutput>
<div class="row">
    <div class="col-12">
        <div class="card">
            <div class="card-head mt-5">
                <div class="d-print-none">
                    <div class="float-end">
                        <a href="#application.urlPath#/?view=register" class="btn btn-primary w-md waves-effect waves-light">
                            <i class="fa fa-user-plus"> #Application.labels['userlist_addnewuser']# </i>
                        </a>
                        &nbsp;
                    </div>
                </div>
            </div>

            <div class="card-body">

                <h4 class="card-title">#Application.labels['userlist_header']#</h4>
                <p class="card-title-desc">#Application.labels['userlist_intro']#</p>

                <table id="datatable" class="table table-bordered dt-responsive nowrap"
                    style="border-collapse: collapse; border-spacing: 0; width: 100%;">
                    <thead>
                        <tr>
                            <th>Id</th>
                            <th>#Application.labels['general_firstname']#</th>
                            <th>#Application.labels['general_lastname']#</th>
                            <th>#Application.labels['general_email']#</th>
                            <th>#Application.labels['general_phone']#</th>
                            <th>#Application.labels['general_isactive']#</th>
                        </tr>
                    </thead>

                    <tbody>
                        <cfloop query="Users">
                            <tr>
                                <td>#userId#</td>
                                <td><a href="#Application.urlPath#/index.cfm?view=userEdit&userid=#Users.userID#">#trim(userfirstname)#</a></td>
                                <td>#trim(userlastname)#</td>
                                <td>#trim(userEmail)#</td>
                                <td>#trim(userPhone)#</td>
                                <td>
                                    <!--- daToggle Function --->
                                    <cfset randomID = createUUID()>
                                    <div id="callback_#randomID#">
                                        <a class="daToggle" href="##" data-callback="callback_#randomID#" data-action="#Application.urlPath#/includes/daForm.cfm?daCase=daToggle&dapermit=users.active&id=#userid#&field=userActive">
                                            <cfif userActive>
                                                <div class='alert alert-success' role='alert'>#Application.labels['useractive_yes']#</div>
                                            <cfelse>
                                                <div class='alert alert-danger' role='alert'>#Application.labels['useractive_no']#</div>                                                
                                            </cfif>
                                        </a>    
                                    </div>
                                </td>
                            </tr>
                        </cfloop>
                    </tbody>
                </table>

            </div>
        </div>
    </div>
    <!-- end col -->
</div>
<!-- end row -->
</cfoutput>