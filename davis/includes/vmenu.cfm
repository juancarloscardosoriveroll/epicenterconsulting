<cfoutput>
<div class="vertical-menu">
    <div class="h-100">

        <div class="user-wid text-center py-4">
            <div class="user-img">
                <img src="https://ui-avatars.com/api/?name=#user.userfirstname#" alt="" class="avatar-md mx-auto rounded-circle">
            </div>

            <div class="mt-3">

                <a href="##" class="text-dark fw-medium font-size-16">#user.userfirstname#</a>
                <p class="text-body mt-1 mb-0 font-size-13">#user.useremail#</p>

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

                    <!--- Contacts --->
                    <ul class="sub-menu" aria-expanded="false">
                        <li><a href="#Application.urlPath#/?view=contactlist">#Application.labels['sidemenu_contacts_group']#</a></li>
                    </ul>

                    <!--- Users --->
                    <ul class="sub-menu" aria-expanded="false">
                        <li><a href="#Application.urlPath#/?view=userlist">#Application.labels['sidemenu_users_group']#</a></li>
                    </ul>


                </li>


                

                <!---Catalogs --->
                <li>
                    <a href="javascript: void(0);" class="has-arrow waves-effect">
                        <i class="#Application.labels['sidemenu_catalogs_icon']#"></i>
                        <span>#Application.labels['sidemenu_catalogs_group']#</span>
                    </a>

                    <!--- Dynamic --->
                    <cfloop from="1" to="#arraylen(Application.setup.catalogs)#" index="CT">
                        <cfset TC = Application.setup.catalogs[CT]>
                        <ul class="sub-menu" aria-expanded="false">
                            <li>
                                <a href="#Application.urlPath#/?view=catalogs&catType=#trim(TC.id)#">
                                    <span>#TC.display#</span>
                                </a> 
                            </li>
                        </ul>
                    </cfloop>
                </li>

                <!---

                <!--- Dynamic --->
                <cfloop from="1" to="#arraylen(Application.setup.catalogs)#" index="CT">
                    <cfset TC = Application.setup.catalogs[CT]>

                    <li>
                        <a href="#Application.urlPath#/?view=catalogs&catType=#trim(TC.catType)#" class="">
                            <i class="#Application.labels['sidemenu_users_icon']#"></i>
                            <span>#TC.catType#</span>
                        </a> 
                    </li>
                </cfloop>
                --->

            </ul>
        </div>
        <!-- Sidebar -->
    </div>
</div>
</cfoutput>
