<cfoutput>
    <div class="row">
        <div class="col-lg-12">
            <div class="card">
                <div class="card-body">
                    <h4 class="card-title">
                        <a href="#application.urlPath#/?view=catalogs&catType=#url.catType#"><i class="fas fa-arrow-left"></i>&nbsp;                        
                        #replacenocase(Application.labels['itemnew_header'],'%catType',url.catType,'ALL')#</a></h4>
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
                            <cfif THISCAT.catType.id eq url.catType>
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
                                            <cfif isdefined("thisField.required") and thisField.required>*</cfif>
                                        </label>
                                        <div>
                                            <cfswitch expression="#thisField.type#">
                                                <cfcase value="area">
                                                    <textarea name="#thisField.fieldName#" 
                                                         maxlength="#thisField.maxlength#"
                                                         minlength="#thisField.minlength#"
                                                             class="form-control"
                                                             rows="5"
                                                    <cfif thisField.required> required </cfif>
                                                    placeholder="#evaluate(dynhelp)#"></textarea>                                                    
                                                </cfcase>

                                                <cfcase value="zipcode">

                                                    <div class="input-group mb-3">


                                                        <div class="input-group-append">
                                                            <span class="input-group-text" id="basic-addon2">
  
                                                              <button type="button" class="btn btn-primary btn-sm waves-effect waves-light"
                                                              data-bs-toggle="modal" data-bs-target=".zipcode-modal">Find it</button>
      
                                                            </span>
                                                          </div>                                                        

                                                        <input name="#thisField.fieldName#"
                                                            id="zipcode" 
                                                            type="number" 
                                                        maxlength="5"
                                                        minlength="5"
                                                            class="form-control-sm"
                                                            style="width: 100px;"
                                                    <cfif thisField.required> required </cfif>
                                                    placeholder="#evaluate(dynhelp)#"
                                                    />
    

                                                      </div>


        
                                                </cfcase>

                                                <cfcase value="idkey">
                                                    <input type="text" 
                                                        disabled value="#evaluate(dynhelp)#"
                                                        class="form-control">
                                                    <!--- no logic needed, key is inserted by backend service --->
                                                </cfcase>

                                                <cfdefaultcase>
                                                        <input name="#thisField.fieldName#" 
                                                            type="#thisField.type#" 
                                                        maxlength="#thisField.maxlength#"
                                                        minlength="#thisField.minlength#"
                                                            class="form-control"
                                                            <cfif thisField.required> required </cfif>
                                                            placeholder="#evaluate(dynhelp)#" 
                                                            />
                                                </cfdefaultcase>
                                            </cfswitch>
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



<!--- ZIPCODE Modal --->   
<cfoutput> 
<div class="modal fade zipcode-modal" tabindex="-1" role="dialog"
    aria-labelledby="mySmallModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-sm">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title mt-0" id="mySmallModalLabel">ZipCode Finder</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal"
                    aria-label="Close"></button>
            </div>
            <div class="modal-body">

                <form>
                <div class="row">
                    <div class="mb-3">
                        <label class="form-label">State</label>
                        <div>
                            <cfinvoke component="/root/functions/remote" method="getStates" returnvariable="states">
                            <cfset mystates = deserializeJSON(states)>
                            <select name="state" class="form-select stateToCounty" style="width: 100%;" id="state" data-target="county" data-action="http://tutoro.me/davis/functions/remote.cfc?method=getCounties">
                                <option value="">Select State</option>
                                <cfloop from="1" to="#arraylen(mystates)#" index="X">
                                    <option value="#mystates[X].abbreviation#">#mystates[X].name#</option>
                                </cfloop>
                            </select>
                        </div>
                    </div>

                    <div class="mb-3">
                        <label class="form-label">County</label>
                        <div>
                            <select name="county" class="form-select countyToCity" style="width: 100%;" id="county" data-target="city" data-action="http://tutoro.me/davis/functions/remote.cfc?method=getCities">
                            </select>
                        </div>
                    </div>

                    <div class="mb-3">
                        <label class="form-label">City</label>
                        <div>
                            <select name="city" class="form-select" id="city" style="width: 100%;">
                            </select>
                        </div>
                    </div>


                    <div class="text-center">
                        <a class="btn btn-primary waves-effect waves-light me-1 updateZipCode">
                            Select this Zipcode
                        </a>
                    </div>



                </div>
                </form>

            </div>
        </div>
        <!-- /.modal-content -->
    </div>
    <!-- /.modal-dialog -->
</div>
<!-- /.modal -->
</cfoutput>