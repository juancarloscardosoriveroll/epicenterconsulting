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
                                <th>Item</th>
                                <th>Date</th>
                                <th>Status</th>
                                <th>Detail</th>
                            </tr>
                        </thead>
                        <tbody>
                            <cfloop query="items">
                            <tr>
                                <td>#catID#</td>
                                <td><a href="#Application.urlPath#/?view=itemEdit&cattype=#trim(catType)#&catid=#catid#">#catItem#</a></td>
                                <td>#dateformat(catdate,'mmm-yy')#</td>
                                <td>#booleanFormat(catActive)#</td>
                                <td>&nbsp;</td>
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
                