<cfinvoke component="/root/functions/users" method="getUsers" returnvariable="Users" />
<cfoutput>
<div class="row">
    <div class="col-12">
        <div class="card">
            <div class="card-body">

                <h4 class="card-title">#Application.labels['userlist_header']#</h4>
                <p class="card-title-desc">#Application.labels['userlist_intro']#</p>

                <table id="datatable" class="table table-bordered dt-responsive nowrap"
                    style="border-collapse: collapse; border-spacing: 0; width: 100%;">
                    <thead>
                        <tr>
                            <th>Id</th>
                            <th>FirstName</th>
                            <th>LastName</th>
                            <th>Email</th>
                            <th>Phone</th>
                            <th>isActive</th>
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
                                <td><cfif userActive>YES<cfelse>NO</cfif></td>
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