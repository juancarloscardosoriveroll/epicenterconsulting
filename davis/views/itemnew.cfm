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
                                    placeholder="#Application.labels['catalogs_' & url.catType & '_describe_help']#"></textarea>                                                    
                            </div>
                        </div>

                    <!---

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

                    --->

                        <div>
                            <div>
                                <button type="submit" class="btn btn-primary waves-effect waves-light me-1">
                                    #Application.labels["catalogs_submit"]#
                                </button>
                                <button type="reset" class="btn btn-secondary waves-effect">
                                    #Application.labels["catalogs_reset"]#
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
