<cfoutput>
<div class="vertical-menu">
    <div class="h-100">

        <div class="user-wid text-center py-4">
            <div class="user-img">
                <img src="assets/images/users/avatar-2.jpg" alt="" class="avatar-md mx-auto rounded-circle">
            </div>

            <div class="mt-3">

                <a href="##" class="text-dark fw-medium font-size-16">Patrick Becker</a>
                <p class="text-body mt-1 mb-0 font-size-13">UI/UX Designer</p>

            </div>
        </div>
 
        <!--- Sidemenu --->
        <div id="sidebar-menu">
            <!-- Left Menu Start -->
            <ul class="metismenu list-unstyled" id="side-menu">
                <li class="menu-title">#Application.labels['sidemenu_title']#</li>

                <!---Home --->
                <li>
                    <a href="javascript: void(0);" class="has-arrow waves-effect">
                        <i class="#Application.labels['sidemenu_home_icon']#"></i>
                        <span>#Application.labels['sidemenu_home_group']#</span>
                    </a>
                    <!--- Dashboard --->
                    <ul class="sub-menu" aria-expanded="false">
                        <li><a href="index.cfm">#Application.labels['sidemenu_home_group_dashboard']#</a></li>
                    </ul>
                </li>

                <!--- Users --->
                <li>
                    <a href="javascript: void(0);" class="has-arrow waves-effect">
                        <i class="#Application.labels['sidemenu_users_icon']#"></i>
                        <span>#Application.labels['sidemenu_users_group']#</span>
                    </a> 
                    <!--- List ---> 
                    <cfif application.helper.hasPermit(session.userId,'users.userList.view')>
                        <ul class="sub-menu" aria-expanded="false">
                            <li><a href="#Application.urlPath#/?view=userlist">#Application.labels['sidemenu_users_group_list']#</a></li>
                        </ul>
                    </cfif>

                    <!--- Register --->
                    <cfif application.helper.hasPermit(session.userId,'users.register.write')>
                        <ul class="sub-menu" aria-expanded="false"> 
                            <li><a href="#Application.urlPath#/?view=register">#Application.labels['sidemenu_users_group_register']#</a></li>
                        </ul>
                    </cfif>
                </li>


            </ul>
        </div>
        <!-- Sidebar -->
    </div>
</div>
</cfoutput>
