<!--- Use this as callback when New Customer is created --->
<cfparam name="cid" default="">
<cfinvoke component="/root/functions/remote" method="AC_Contacts" returnvariable="AC" contactType="isInsd" term="#cid#" />
<cfset baseValue = deserializeJSON(AC)>
<cfparam name="term" default="">
<cfparam name="insName" default="">
<cfparam name="insAddress" default="">
<cfparam name="insContact" default="">
<cftry>
    <cfset term = cid>
    <cfset insName = baseValue[1].label>
    <cfset insAddress = baseValue[1].address>
    <cfset insContact = baseValue[1].contact>
    <cfcatch/>
</cftry>

<cfoutput>
    <div class="row">
        <div class="col-lg-12">
            <div class="card">
                <div class="card-body">  
                    <h4 class="card-title">
                        <a href="#application.urlPath#/?view=orderlist"><i class="fas fa-arrow-left"></i>&nbsp;                        
                        #Application.labels['general_back']#</a></h4>
                    <p class="card-title-desc">#Application.labels["neworder_intro"]#</p> 
    
                    <form class="custom-validation daForm" id="daForm" action="#Application.urlPath#/includes/daForm.cfm?daCase=neworder">

                        <!--- INSURED PERSON/COMPANY --->  
                        <div class="mb-3">
                            <label class="form-label">Insured Entity</label>
                            <div class="input-group-append">
                                <span class="input-group-text" id="basic-addon2">                                    <input name="cid"
                                    type="text" required
                                    class="cid form-control-sm" 
                                    data-type="isInsd" 
                                    placeholder="name, company or id"
                                    value="#term#" />

                                    <a href="#application.urlPath#/?view=newContact&contactType=isInsd" class="btn btn-primary w-md waves-effect waves-light">
                                        <i class="fa fa-user-plus"> #Application.labels['contactlist_addnew']# </i>
                                    </a>      
                                </span>
                            </div>                                                        
                            <div>
                                <input id="insName" type="text" class="form-control" disabled value="#insName#" />
                                <input id="insAddress" type="text" class="form-control" disabled value="#insAddress#" />
                                <input id="insContact" type="text" class="form-control" disabled value="#insContact#" />

                            </div>
                        </div>
                        
                        <div>
                            <div>
                                <button type="submit" class="btn btn-primary waves-effect waves-light me-1">
                                    #Application.labels["neworder_submit"]#
                                </button>
                                <button type="reset" class="btn btn-secondary waves-effect">
                                    #Application.labels["neworder_reset"]#
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

