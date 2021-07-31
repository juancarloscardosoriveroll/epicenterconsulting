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
                    <!--- Orders --->
                    <ul class="sub-menu" aria-expanded="false">
                        <li><a href="#Application.urlPath#/?view=orderlist">#Application.labels['sidemenu_home_group_orderlist']#</a></li>
                    </ul>


                    <!--- Dashboard --->
                    <!---
                    <ul class="sub-menu" aria-expanded="false">
                        <li><a href="index.cfm">#Application.labels['sidemenu_home_group_dashboard']#</a></li>
                    </ul>
                    --->
                    
                    <!--- Users --->
                    <ul class="sub-menu" aria-expanded="false">
                        <li><a href="#Application.urlPath#/?view=userlist">#Application.labels['sidemenu_users_group']#</a></li>
                    </ul>
                    <!--- Help --->
                    <ul class="sub-menu" aria-expanded="false">
                        <li><a href="#Application.urlPath#/?view=faqs">#Application.labels['sidemenu_help_group']#</a></li>
                    </ul>


                </li>

                <!--- Contacts ---> 
                <cfset Count = Application.contacts.getStats()>
                <li>
                    <a href="javascript: void(0);" class="has-arrow waves-effect">
                        <i class="#Application.labels['sidemenu_contacts_icon']#"></i>
                        <span>#Application.labels['sidemenu_contacts_group']#</span>
                    </a>

                    <ul class="sub-menu" aria-expanded="false">
                        <li>
                            <a href="#Application.urlPath#/?view=contactlist&contactType=isAcct">
                                <span>#Application.labels['sideMenu_contacts_isAcct']# (#Count["isAcct"]#)</span>
                            </a> 
                        </li>

                        <li>
                            <a href="#Application.urlPath#/?view=contactlist&contactType=isInsd">
                                <span>#Application.labels['sideMenu_contacts_isInsd']# (#Count["isInsd"]#)</span>
                            </a> 
                        </li>

                        <li>
                            <a href="#Application.urlPath#/?view=contactlist&contactType=isLead">
                                <span>#Application.labels['sideMenu_contacts_isLead']# (#Count["isLead"]#)</span>
                            </a> 
                        </li>

                        <li>
                            <a href="#Application.urlPath#/?view=contactlist&contactType=isMarina">
                                <span>#Application.labels['sideMenu_contacts_isMarina']# (#Count["isMarina"]#)</span>
                            </a> 
                        </li>

                        <li>
                            <a href="#Application.urlPath#/?view=contactlist&contactType=isOEM">
                                <span>#Application.labels['sideMenu_contacts_isOEM']# (#Count["isOEM"]#)</span>
                            </a> 
                        </li>

                        <li>
                            <a href="#Application.urlPath#/?view=contactlist&contactType=isMFG">
                                <span>#Application.labels['sideMenu_contacts_isMFG']# (#Count["isMFG"]#)</span>
                            </a> 
                        </li>

                        <li>
                            <a href="#Application.urlPath#/?view=contactlist&contactType=isSalC">
                                <span>#Application.labels['sideMenu_contacts_isSalC']# (#Count["isSalC"]#)</span>
                            </a> 
                        </li>
                        <li>
                            <a href="#Application.urlPath#/?view=contactlist&contactType=isOmim">
                                <span>#Application.labels['sideMenu_contacts_isOmim']# (#Count["isOmim"]#)</span>
                            </a> 
                        </li>
                        <li>
                            <a href="#Application.urlPath#/?view=contactlist&contactType=isOffice">
                                <span>#Application.labels['sideMenu_contacts_isOffice']# (#Count["isOffice"]#)</span>
                            </a> 
                        </li>

                    </ul>
                </li>

                <!---Catalogs --->
                <li>
                    <a href="javascript: void(0);" class="has-arrow waves-effect">
                        <i class="#Application.labels['sidemenu_catalogs_icon']#"></i>
                        <span>#Application.labels['sidemenu_catalogs_group']#</span>
                    </a>

                    <!--- Dynamic --->
                    <cfset Count = Application.catalogs.getStats()>
                    <cfloop from="1" to="#arraylen(Application.setup.catalogs)#" index="CT">
                        <cfset TC = Application.setup.catalogs[CT]>
                        <ul class="sub-menu" aria-expanded="false">
                            <li>
                                <a href="#Application.urlPath#/?view=catalogs&catType=#trim(TC.id)#">
                                    <span>#TC.display# (#evaluate("Count." & TC.id)#)</span>
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
