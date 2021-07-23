<cfinvoke component="/root/functions/contacts" method="getContacts" returnvariable="Contacts" cid="#cid#" />
<cfinvoke component="/root/functions/contacts" method="getContactsMeta" returnvariable="Meta" cid="#cid#" />

<cfoutput>
<div class="row"> 
    <div class="col-12">
        <div class="card">
            <div class="card-head mt-5">
                <div class="d-print-none">
                    <div class="float-end">   
                        <a href="#application.urlPath#/?view=newContact" class="btn btn-primary w-md waves-effect waves-light">
                            <i class="fa fa-user-plus"> #Application.labels['contactlist_addnew']# </i>
                        </a>  
                        &nbsp;   
                    </div> 
                </div>
            </div>

            <div class="card-body">

                <h4 class="card-title">
                    <a href="#application.urlPath#/?view=contactlist"><i class="fas fa-arrow-left"></i>&nbsp;                     
                    #contacts.cCoName#</a></h4>
                <p class="card-title-desc">#Application.labels['contactmeta_header']#</p>

                <form class="custom-validation daForm" id="daForm" action="#Application.urlPath#/includes/daForm.cfm?daCase=contactMeta">
                    <input type="hidden" name="cId" value="#contacts.cid#">
                    <input type="hidden" name="cownerid" value="#contacts.cOwnerID#"> 
                    <cfparam name="url.dataid" default="0"> <!--- set for edit --->
                    <input type="hidden" name="dataId" value="#url.dataid#"> 

                    <cfset def_cField = "">
                    <cfset def_cValue = "">
                    <cfif url.dataid neq 0>
                        <!--- get Default Data --->
                        <cfquery dbtype="query" name="def">
                            select * from meta where dataid = <cfqueryparam value="#url.dataid#">
                        </cfquery>
                        <cfset def_cField = def.cField>
                        <cfset def_cValue = def.cValue>
                    </cfif>


                <table id="datatable" class="table table-bordered dt-responsive nowrap <cfif url.dataid eq 0>table-striped</cfif>"
                    style="border-collapse: collapse; border-spacing: 0; width: 100%;">
                    <thead>
                        <tr>
                            <td>
                                <select name="cField" required class="form-select">
                                    <option value="" selected>#application.Labels["general_selectOne"]#</option>
                                    <cfloop from="1" to="#arraylen(application.setup.metacontacts)#" index="MC">
                                        <option <cfif def_cField eq application.setup.metacontacts[MC]> selected </cfif>>#application.setup.metacontacts[MC]#</option>
                                    </cfloop>
                                </select> 
                            </td>
                            <td>
                                <input name="cValue" required class="form-control" value="#def_cValue#"> 
                            </td>
                            <td> 
                                <button type="submit" class="btn btn-primary waves-effect waves-light me-1">
                                    <cfif url.dataid eq 0>
                                        #Application.labels["contactmeta_submit"]#
                                    <cfelse>
                                        #Application.labels["general_edit"]#
                                    </cfif>
                                </button>
                                <cfif url.dataid neq 0>
                                    <!--- Back Button --->
                                    <a class="btn-secondary waves-effect waves-light me-1" href="#Application.urlPath#/?view=contactmeta&cid=#cid#">#application.labels['general_back']#</a>
                                </cfif>

                            </td>
                        </tr>
                        <tr>
                            <th>#Application.labels['contactmeta_field']#</th>
                            <th>#Application.labels['contactmeta_value']#</th>
                            <th>&nbsp;</th>
                        </tr>
        
                    </thead>

                    <tbody>

                        <cfloop query="Meta">
                            <tr <cfif url.dataid eq dataid> class="bg-primary" </cfif>>
                                <td>#cField#</td>
                                <td>#cValue#</td>   
                                <td>
                                    <cfif url.dataid neq dataid>
                                        <a href="#Application.urlPath#/?view=contactmeta&cid=#cid#&dataid=#dataid#">#Application.labels["general_edit"]#</a> | 
                                        
                                        <a class="daToggle" href="##" data-callback="callback_none" data-action="#Application.urlPath#/includes/daForm.cfm?daCase=daToggle&dapermit=contacts.metadelete&id=#dataid#">
                                            #Application.labels["general_delete"]#
                                        </a>

                                    </cfif>
                                </td>
                            </tr>
                        </cfloop>
                    </tbody>
                </table>
                </form>


            </div>
        </div>
    </div>
    <!-- end col -->
</div>
<!-- end row -->
</cfoutput>