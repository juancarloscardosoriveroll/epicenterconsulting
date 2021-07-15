<!--- MAKE SURE REQUIRED URL.USERID EXISTS, ELSE REDIRECT TO HOME --->
<cfif Not(isdefined("url.userid"))><cflocation url="#application.urlPath#/?view=Dashboard" addtoken="false"></cfif>

<!--- Invoke and preProcess in Root View to prevent direct access --->
<cfinvoke component="/root/functions/users" method="getUsers" returnvariable="Usr" userid="#url.userId#" />
<cfinvoke component="/root/functions/users" method="getPermits" returnvariable="Permits" userid="#url.userId#" />
<!--------------------------------------------------------------------->

<cfoutput>
    <div class="row">
        <div class="col-lg-12">
            <div class="card">
                <div class="card-body">

                    <!-- Nav tabs -->
                    <ul class="nav nav-tabs" role="tablist">
                        <li class="nav-item">
                            <a class="nav-link active" data-bs-toggle="tab" href="##profile" role="tab">
                                <span class="d-block d-sm-none"><i class="far fa-user"></i></span>
                                <span class="d-none d-sm-block">Profile</span>
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" data-bs-toggle="tab" href="##permits" role="tab">
                                <span class="d-block d-sm-none"><i class="far fa-envelope"></i></span>
                                <span class="d-none d-sm-block">Permits</span>
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" data-bs-toggle="tab" href="##security" role="tab">
                                <span class="d-block d-sm-none"><i class="fas fa-cog"></i></span>
                                <span class="d-none d-sm-block">Security</span>
                            </a>
                        </li>
                    </ul>

                    <!-- Tab panes -->
                    <div class="tab-content p-3 text-muted">
                        <div class="tab-pane active " id="profile" role="tabpanel">
                            <cfinclude template="/root/views/useredit_profile.cfm">
                        </div>
                        <div class="tab-pane " id="permits" role="tabpanel">
                            <cfinclude template="/root/views/useredit_permits.cfm">
                        </div>
                        <div class="tab-pane " id="security" role="tabpanel">
                            <cfinclude template="/root/views/useredit_security.cfm">
                        </div>
                    </div>
                </div>
            </div>
        
        </div>
                            
    </div>
</cfoutput>