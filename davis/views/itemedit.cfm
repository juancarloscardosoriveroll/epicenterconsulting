<cfoutput>
    <div class="row">
        <div class="col-lg-12">
            <div class="card">
                <div class="card-body">
                    <h4 class="card-title">
                        <a href="#application.urlPath#/?view=catalogs&catType=#url.catType#"><i class="fas fa-arrow-left"></i></a>&nbsp;                        
                        #replacenocase(Application.labels['itemnew_header'],'%catType',url.catType,'ALL')#</h4>
                    <p class="card-title-desc">#Application.labels["itemnew_intro"]#</p>
    
                    <form class="custom-validation daForm" id="daForm" action="#Application.urlPath#/includes/daForm.cfm?daCase=itemnew">
                        <input type="hidden" name="catType" value="#url.catType#">
                        <div class="mb-3">
                            <label class="form-label">#Application.labels["itemnew_catitem"]# *</label>
                            <div>
                                <input name="catItem" id="catItem"  type="text" class="form-control"
                                    required placeholder="#Application.labels['itemnew_catitem_help']#" />
                            </div>
                        </div>

                        <!--- LOOP STRUCTURE TO FIND FIELD SETTINGS  --->
                        <cfloop from="1" to="#arraylen(application.setup.catalogs)#" index="CAT">
                            <cfset THISCAT = application.setup.catalogs[CAT]>
                            <cfif THISCAT.catType eq url.catType>
                                <cfloop from="1" to="#arraylen(THISCAT.addFields)#" index="AF">
                                    <cfset THISFIELD = THISCAT.addFields[AF]>

                                    <!--- CUSTOM FIELD HERE --->
                                    <div class="mb-3">
                                        <label class="form-label">
                                            <!--- dynamic label from labels.json --->
                                            <cfset dynlabel = "Application.labels.catalogs_#url.catType#_#thisField.fieldName#">
                                            <cfset dynhelp = "Application.labels.catalogs_#url.catType#_#thisField.fieldName#_help">

                                            <cfif isdefined("#dynlabel#")>
                                                #evaluate(dynlabel)#
                                            <cfelse>
                                                #listlast(dynlabel,'.')#
                                            </cfif>
                                            <cfif thisField.required>*</cfif>

                                        </label>
                                        <div>
                                            <input name="#thisField.fieldName#" 
                                                     id="#thisField.fieldName#"  
                                                   type="text" 
                                                  class="form-control"
                                                <cfif thisField.required> required </cfif> 
                                                <cfif isdefined('#dynhelp#')> placeholder="#evaluate(dynhelp)#" </cfif> />
                                        </div>
                                    </div>

                                </cfloop>
                            </cfif>
                        </cfloop>
                        
    
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