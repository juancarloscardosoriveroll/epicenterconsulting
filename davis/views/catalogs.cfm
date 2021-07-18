<cfif not(isdefined("url.catType")) OR not(isdefined("session.userid"))>
    <cflocation url="#application.urlPath#" addtoken="false">
</cfif>

<cfinvoke component="/root/functions/catalogs" method="getItems" catType="#url.catType#" returnvariable="Items">

<cfoutput>
    <div class="row">
        <div class="col-lg-12">
            <div class="card">
                <div class="card-head mt-5">
                    <div class="d-print-none">
                        <div class="float-end">
                            <a href="#application.urlPath#/?view=itemnew&catType=#url.catType#" class="btn btn-primary w-md waves-effect waves-light">
                                <i class="fa fa-user-plus"> #Application.labels['catalogs_addnewrecord']# </i>
                            </a>
                            &nbsp;
                        </div>
                    </div>
                </div>
    
                <div class="card-body">
    
                    <h4 class="card-title">
                        #replacenocase(Application.labels['catalogs_header'],'%catType',catType,'ALL')#</h4>
                    <p class="card-title-desc">#Application.labels['catalogs_intro']#</p>
    
                    <table id="datatable" class="table table-bordered dt-responsive nowrap"
                        style="border-collapse: collapse; border-spacing: 0; width: 100%;">
                        <thead>
                            <tr>
                                <th>Id</th>
                                <th>Name</th>
                                <th>Description</th>
                                <th>Owner</th>
                                <th>Status</th>
                            </tr>
                        </thead>
                        <tbody>
                            <cfloop query="items">
                            <tr>
                                <td>#itemId#</td>
                                <td><a href="#Application.urlPath#/?view=itemEdit&cattype=#trim(catType)#&itemId=#itemId#">#itemName#</a></td>
                                <td>#itemDesc#</td>
                                <td>#userFirstname# #userLastname#</td>
                                <td>
                                    <!--- daToggle Function --->
                                    <cfset randomID = createUUID()>
                                    <div id="callback_#randomID#">
                                        <a class="daToggle" href="##" data-callback="callback_#randomID#" data-action="#Application.urlPath#/includes/daForm.cfm?daCase=daToggle&dapermit=catalogs.active&id=#itemid#&field=catactive">
                                            <cfif catActive>
                                                <div class='alert alert-success' role='alert'>#Application.labels['catactive_yes']#</div>
                                            <cfelse>
                                                <div class='alert alert-danger' role='alert'>#Application.labels['catactive_no']#</div>                                                
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
    </div>
</div>    
</cfoutput>     
                      