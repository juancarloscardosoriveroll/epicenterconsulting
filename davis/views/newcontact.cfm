<cfparam name="contactType" default="isLead"> 
<cfparam name="newOrder" default="1">

<cfoutput>
    <div class="row">
        <div class="col-lg-12">
            <div class="card">
                <div class="card-body">
                    <h4 class="card-title">
                        <a href="#application.urlPath#/?view=contactlist"><i class="fas fa-arrow-left"></i>&nbsp;                        
                        #Application.labels['newcontact_header']#</a></h4>
                    <p class="card-title-desc">#Application.labels["newcontact_intro"]#</p> 
    
                    <form class="custom-validation daForm" id="daForm" action="#Application.urlPath#/includes/daForm.cfm?daCase=newcontact">
                        <input type="hidden" name="newOrder" value="#newOrder#">

                        <!--- COUNTRY --->
                        <div class="mb-3">
                            <label class="form-label">
                                #Application.labels['newcontact_country_label']#
                            </label>
                            <div>
                                <cfinvoke component="/functions/remote" method="getCountries" returnvariable="Ct">
                                <cfset myCountries = deserializeJSON(ct)>
                                <select name="cCountry"  class="form-select getStatesfromCountry" data-target="state" data-action="#application.urlPath#/functions/remote.cfc?method=getStates" required>
                                    <cfloop from="1" to="#arraylen(myCountries)#" index="thisCountry">
                                        <option value="#myCountries[thisCountry].code#" <cfif myCountries[thisCountry].code eq 'US'> selected </cfif>>#myCountries[thisCountry].name#</option>
                                    </cfloop>
                                </select>  
                            </div>
                        </div>


                        <!--- ZIPCODE --->  
                        <div class="mb-3">
                            <label class="form-label">
                                #Application.labels['newcontact_zipcode_label']#
                            </label>

                            <div class="input-group-append">
                                <span class="input-group-text" id="basic-addon2">
                                    <input name="zipcode"
                                    id="zipcode" type="text" maxlength="10" minlength="3" required
                                    class="form-control-sm"
                                    placeholder="#Application.labels['newcontact_zipcode_help']#" />

                                    <button type="button" class="btn btn-primary btn-sm waves-effect waves-light"
                                    data-bs-toggle="modal" data-bs-target=".zipcode-modal">#Application.labels['newcontact_zipcode_find']#</button>
                                </span>
                            </div>                                                        

                        </div>




                        <!--- COMPANY NAME --->
                        <div class="mb-3">
                            <label class="form-label">
                                #Application.labels['newcontact_company_label']#
                            </label>
                            <div>
                                <input name="cCoName" type="text" maxlength="50" minlength="5" class="form-control"  
                                placeholder="#Application.labels['newcontact_company_help']#" />
                            </div>
                        </div>


                        <!--- FIRST NAME --->
                        <div class="mb-3">
                            <label class="form-label">
                                #Application.labels['newcontact_firstname_label']#
                            </label>
                            <div>
                                <input name="cFirstName" type="text" maxlength="50" minlength="2" class="form-control" required  
                                placeholder="#Application.labels['newcontact_firstname_help']#" />
                            </div>
                        </div>


                        <!--- LAST NAME --->
                        <div class="mb-3">
                            <label class="form-label">
                                #Application.labels['newcontact_lastname_label']#
                            </label>
                            <div>
                                <input name="cLastName" type="text" maxlength="50" minlength="2" class="form-control" required  
                                placeholder="#Application.labels['newcontact_lastname_help']#" />
                            </div>
                        </div>

                        <!--- STREET & NUMBER --->
                        <div class="mb-3">
                            <label class="form-label">
                                #Application.labels['newcontact_streetNum_label']#
                            </label>
                            <div>
                                <input name="cStreetNum" type="text" maxlength="50" minlength="5" class="form-control" required  
                                placeholder="#Application.labels['newcontact_StreetNum_help']#" />  
                            </div>
                        </div>


                        <!--- PHONE MAIN --->
                        <div class="mb-3">
                            <label class="form-label">
                                #Application.labels['newcontact_phonemain_label']#
                            </label>
                            <div>
                                <input name="cPhoneMain" type="text" data-parsley-type="number" maxlength="50" minlength="5" class="form-control" required  
                                placeholder="#Application.labels['newcontact_phonemain_help']#" />  
                            </div>
                        </div>

                        <!--- EMAIL --->
                        <div class="mb-3">
                            <label class="form-label">
                                #Application.labels['newcontact_email_label']#
                            </label>
                            <div>
                                <input name="cEmail" type="text" data-parsley-type="email" maxlength="75" minlength="5" class="form-control" required  
                                placeholder="#Application.labels['newcontact_email_help']#" />  
                            </div>
                        </div>


                        <!--- SWITCHES --->
                        <div class="row">
                            <div class="col-sm">
                                <!--- isAcct --->
                                <div class="form-check form-switch">
                                    #Application.labels['contactlist_isAcct']#<input class="form-check-input" type="checkbox"  name="contactTypes" id="isAcct" value="isAcct" <cfif listfindnocase(contactType,'isAcct')> checked </cfif> data-parsley-mincheck="1" >
                                </div>
                            </div>
                            <div class="col-sm">
                                <!--- isInsd --->
                                <div class="form-check form-switch">
                                    #Application.labels['contactlist_isInsd']#<input class="form-check-input" type="checkbox"  name="contactTypes" id="isInsd" value="isInsd" <cfif listfindnocase(contactType,'isInsd')> checked </cfif> >
                                </div>
                            </div>



                            <div class="col-sm">
                                <!--- isLead --->
                                <div class="form-check form-switch"> 
                                    #Application.labels['contactlist_isLead']#<input class="form-check-input" type="checkbox"  name="contactTypes" id="isLead" value="isLead" <cfif listfindnocase(contactType,'islead')> checked </cfif> >
                                </div>
                            </div>

                            <div class="col-sm">
                                <!--- isMarina --->
                                <div class="form-check form-switch">    
                                    #Application.labels['contactlist_isMarina']#<input class="form-check-input" type="checkbox"  name="contactTypes" id="isMarina" value="isMarina" <cfif listfindnocase(contactType,'isMarina')> checked </cfif> >
                                </div>
                            </div>
                            <div class="col-sm">
                                <!--- isOEM --->
                                <div class="form-check form-switch">
                                    #Application.labels['contactlist_isOEM']#<input class="form-check-input" type="checkbox"  name="contactTypes" id="isOEM" value="isOEM" <cfif listfindnocase(contactType,'isOEM')> checked </cfif> >
                                </div>
                            </div>
                            <div class="col-sm">
                                <!--- isMFG --->
                                <div class="form-check form-switch">
                                    #Application.labels['contactlist_isMFG']#<input class="form-check-input" type="checkbox"  name="contactTypes" id="isMFG" value="isMFG" <cfif listfindnocase(contactType,'isMFG')> checked </cfif> >
                                </div>
                            </div>
                            <div class="col-sm">
                                <!--- isOMIM --->
                                <div class="form-check form-switch">
                                    #Application.labels['contactlist_isOMIM']#<input class="form-check-input" type="checkbox"  name="contactTypes" id="isOMIM" value="isOMIM" <cfif listfindnocase(contactType,'isOMIM')> checked </cfif> >
                                </div>
                            </div>
                            <div class="col-sm">
                                <!--- isSAIC --->
                                <div class="form-check form-switch">
                                    #Application.labels['contactlist_isSALC']#<input class="form-check-input" type="checkbox"  name="contactTypes" id="isSALC" value="isSALC" <cfif listfindnocase(contactType,'isSALC')> checked </cfif> >
                                </div>
                            </div>
                            <div class="col-sm">
                                <!--- isOffice --->
                                <div class="form-check form-switch">
                                    #Application.labels['contactlist_isOffice']#<input class="form-check-input" type="checkbox"  name="contactTypes" id="isOffice" value="isOffice" <cfif listfindnocase(contactType,'isOffice')> checked </cfif> >
                                </div>
                            </div>

                        </div>
                        <label for="contactTypes"></label>                        

                        <hr size="1">


                        <div>
                            <div>
                                <button type="submit" class="btn btn-primary waves-effect waves-light me-1">
                                    #Application.labels["newcontact_submit"]#
                                </button>
                                <button type="reset" class="btn btn-secondary waves-effect">
                                    #Application.labels["newcontact_reset"]#
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
                            <cfinvoke component="/root/functions/remote" method="getStates" country="US" returnvariable="states">
                            <cfset mystates = deserializeJSON(states)>
                            <select name="state" class="form-select stateToCounty" style="width: 100%;" id="state" data-target="county" data-action="#application.urlPath#/functions/remote.cfc?method=getCounties">
                                <option value="">Select State</option>
                                <cfloop from="1" to="#arraylen(mystates)#" index="X">
                                    <option value="US,#mystates[X].abbreviation#">#mystates[X].name#</option>
                                </cfloop>
                            </select>
                        </div>
                    </div>

                    <div class="mb-3">
                        <label class="form-label">County</label>
                        <div>
                            <select name="county" class="form-select countyToCity" style="width: 100%;" id="county" data-target="city" data-action="#application.urlPath#/functions/remote.cfc?method=getCities">
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