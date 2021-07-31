<cfparam name="contactType" default="isLead"> 
<cfif len(contactType) eq 0><cfset contactType = "isLead"></cfif>
<cfinvoke component="/root/functions/contacts" method="getContacts" returnvariable="Contacts" contactTypes="#contactType#" />

<cfoutput>
<div class="row"> 
    <div class="col-12">
        <div class="card">
            <div class="card-head mt-5">
                <div class="d-print-none">
                    <div class="float-end">   
                        <a href="#application.urlPath#/?view=newContact&contactType=#contactType#" class="btn btn-primary w-md waves-effect waves-light">
                            <i class="fa fa-user-plus"> #Application.labels['contactlist_addnew']# </i>
                        </a>  
                        &nbsp;   
                    </div> 
                </div>
            </div>

            <div class="card-body">

                <h4 class="card-title">#evaluate('Application.labels.contactlist_' & contactType)#</h4>
                <p class="card-title-desc">#Application.labels['contactlist_intro']#</p>

                <table id="datatable" class="table table-bordered dt-responsive nowrap table-striped"
                    style="border-collapse: collapse; border-spacing: 0; width: 100%;">
                    <thead>
                        <tr>
                            <th>Id</th>
                            <th>#Application.labels['general_company']#</th>
                            <th>#Application.labels['general_name']#</th>
                            <th>#Application.labels['general_contact']#</th>
                            <th>#Application.labels['general_meta']#</th>
                            <th>isValid</th>
                        </tr>
                    </thead>

                    <tbody>
                        <cfloop query="Contacts">
                            <tr>
                                <td>
                                    #cID#
                                </td>
                                <td>#trim(cCoName)#</a></td>
                                <td><a href="#Application.urlPath#/index.cfm?view=contactEdit&cId=#cId#">#trim(cFirstName)#<br>#trim(cLastName)#</a></td>
                                <td>#trim(cEmail)#<br>#trim(cPhoneMain)#</td>
                                <td>
                                    <!--- Link to Metadata --->
                                    <a href="#Application.urlPath#/index.cfm?view=contactMeta&cId=#cId#">#meta#</a>
                                </td>
                                <td>
                                    <!--- daToggle Function --->
                                    <cfset randomID = createUUID()>
                                    <div id="callback_#randomID#">
                                        <a class="daToggle" href="##" data-callback="callback_#randomID#" data-action="#Application.urlPath#/includes/daForm.cfm?daCase=daToggle&dapermit=contacts.active&id=#cid#">
                                            <cfif cIsValid>
                                                <div class='alert alert-success' role='alert'>#Application.labels['general_yes']#</div>
                                            <cfelse>
                                                <div class='alert alert-danger' role='alert'>#Application.labels['general_no']#</div>                                                
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