<cfinvoke component="/root/functions/catalogs" method="getItems" returnvariable="Item"
    catType="#url.catType#" itemId="#url.itemId#">

<cfoutput>
    <div class="row">
        <div class="col-lg-12">
            <div class="card">
                <div class="card-body">
                    <h4 class="card-title">
                        <a href="#application.urlPath#/?view=catalogs&catType=#url.catType#"><i class="fas fa-arrow-left"></i>&nbsp;                        
                        #replacenocase(Application.labels['itemnew_header'],'%catType',url.catType,'ALL')#</a></h4>
                    <p class="card-title-desc">#Application.labels["itemnew_intro"]#</p> 
    
                    <form class="custom-validation daForm" id="daForm" action="#Application.urlPath#/includes/daForm.cfm?daCase=itemedit">
                        <input type="hidden" name="itemId" value="#url.itemId#">
                        <input type="hidden" name="ownerId" value="#item.ownerId#">


                        <!--- NAME --->
                        <div class="mb-3">
                            <label class="form-label">
                                #Application.labels["catalogs_" & url.catType & "_name"]#
                            </label>
                            <div>
                                <input name="itemName" 
                                type="text" 
                            maxlength="50"
                            minlength="5"
                                class="form-control"
                                value="#item.itemName#"
                                required 
                                placeholder="#Application.labels['catalogs_' & url.catType & '_name_help']#" 
                                />
                            </div>
                        </div>

                        <!--- DESCRIPTION --->
                        <div class="mb-3">
                            <label class="form-label">
                                #Application.labels["catalogs_" & url.catType & "_describe"]#
                            </label>
                            <div>
                                <textarea name="itemDesc" 
                                minlength="5"
                                maxlength="500"
                                    class="form-control"
                                    rows="5"
                                    placeholder="#Application.labels['catalogs_' & url.catType & '_describe_help']#">#item.itemDesc#</textarea>                                                    
                            </div>
                        </div>

                        <!--- CATTYPE --->
                        <div class="mb-3">
                            <label class="form-label">
                                #Application.labels["catalogs_cattype"]#
                            </label>
                            <div>
                                <select class="form-select" name="catType">
                                    <cfloop from="1" to="#arraylen(Application.setup.catalogs)#" index="CAT">
                                        <cfset TC = Application.setup.catalogs[CAT]>
                                        <option value="#tc.id#" <cfif TC.id eq item.catType> selected </cfif>>#TC.display#</option>
                                    </cfloop>
                                </select>
                            </div> 
                        </div>


                        <div>
                            <div>
                                <button type="submit" class="btn btn-primary waves-effect waves-light me-1">
                                    #Application.labels["register_submit"]#
                                </button>
                                <button type="reset" class="btn btn-secondary waves-effect">
                                    #Application.labels["register_reset"]#
                                </button>
                            </div>
                        </div>
                    </form>
    
                </div>
            </div>
    
        </div>
        <!-- end col -->
    
    </div>
    </cfoutput>