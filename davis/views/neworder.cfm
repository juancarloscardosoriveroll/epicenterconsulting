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

<!--- Get All Phones (Referers) --->
<cfset Phones = Application.contacts.getContactsFromMeta(contactType="isAcct",filterKeys="CYA")>
<!--- Get ALl Surveyos --->
<cfset Surveyors = Application.users.getUsersbyPermit(permitname="orders.surveyor")>
<!--- Get All Sources --->
<cfset Sources = Application.catalogs.getItems(catType="sourceTypes",catActive=1)>
<!--- Get All ClaimTypes --->
<cfset Claims = Application.catalogs.getItems(catType="claimTypes",catActive=1)>
<!--- Get All Offices --->
<cfset Offices = Application.contacts.getContacts(contactTypes="isOffice",cisValid=1)>

<cfoutput>
    <form class="custom-validation daForm" id="daForm" action="#Application.urlPath#/includes/daForm.cfm?daCase=neworder">

    <div class="row">
        <div class="card">
            <div class="card-body">  
                <h4 class="card-title">
                    <a href="#application.urlPath#/?view=orderlist"><i class="fas fa-arrow-left"></i>&nbsp;                        
                    #Application.labels['general_back']#</a></h4>
                <p class="card-title-desc">#Application.labels["neworder_intro"]#</p> 


    <div class="row">
        <div class="col-lg-12">

            <!--- INSURED PERSON/COMPANY --->  
            <div class="mb-3">
                <label class="form-label">#application.labels['General_InsuredEntity']#</label>
                <div class="input-group-append">
                    <span class="input-group-text" id="basic-addon2">                                    
                        <input name="cid_isinsd"
                        type="text" required
                        class="cid form-control" 
                        data-type="http://tutoro.me/davis/functions/remote.cfc?method=AC_Contacts&contactType=isInsd" 
                        placeholder="name, company or id"
                        value="#term#" />

                        <a href="#application.urlPath#/?view=newContact&contactType=isInsd" class="btn btn-primary w-md waves-effect waves-light">
                            <i class="fa fa-user-plus"> #Application.labels['contactlist_addnew']# </i>
                        </a>      
                    </span>
                </div>                                                        
                <div>
                    <textarea id="insName" type="text" class="form-control" disabled />#insName# #insAddress# #insContact#</textarea>
                </div>
            </div>
            
        </div>
    </div>
    <div class="row">

        <div class="col-4 mt-3">
            <label class="form-label">#application.labels['General_referedBy']#</label>
            <select class="form-select" name="cid_isacct" required>
                <option value="">#application.labels['General_SelectOne']#</option>
                <cfloop from="1" to="#arraylen(Phones)#" index="X">
                    <option value="#Phones[X].cid#">#Phones[X].cCustomKey# (#Phones[X].itemName#) - #Phones[X].cFirstName# (#Phones[X].cCoName#) - ID #Phones[X].cid#</option> 
                </cfloop>
            </select>
        </div>


        <div class="col-4 mt-3">
            <label class="form-label">#application.labels['General_surveyor']#</label>
            <select class="form-select" name="uid_surveyor" required>
                <option value="">#application.labels['General_SelectOne']#</option>
                <cfloop query="Surveyors">
                    <option value="#userid#">#userFirstname# #userLastname# (#userPhone#,#userEmail#) - ID #userid#</option> 
                </cfloop>
            </select>
        </div>



        <div class="col-4 mt-3">
            <label class="form-label">#application.labels['General_sources']#</label>
            <select class="form-select" name="cat_sourcetype" required>
                <option value="">#application.labels['General_SelectOne']#</option>
                <cfloop query="Sources">
                    <option value="#itemid#">#itemName# (ID: #itemid#) <cfif len(itemDesc) gt 0> -#mid(itemDesc,1,25)#...</cfif></option> 
                </cfloop>
            </select>
        </div>


        <div class="col-4 mt-3">
            <label class="form-label">#application.labels['General_claims']#</label>
            <select class="form-select" name="cat_claimtype" required>
                <option value="">#application.labels['General_SelectOne']#</option>
                <cfloop query="Claims">
                    <option value="#itemid#">#itemName# (ID: #itemid#) <cfif len(itemDesc) gt 0> -#mid(itemDesc,1,25)#...</cfif></option> 
                </cfloop>
            </select>
        </div>


        <div class="col-4 mt-3">
            <label class="form-label">#application.labels['General_offices']#</label>
            <select class="form-select" name="cid_isoffice" required>
                <option value="">#application.labels['General_SelectOne']#</option>
                <cfloop query="Offices">
                    <option value="#cid#">#cCustomKey# - #cFirstName#  - ID #cid#</option> 
                </cfloop>
            </select>
        </div>


    </div>
    <div class="row">

        <div class="mt-3">
            <div class="float-end">
                <button type="submit" class="btn btn-primary waves-effect waves-light me-1">
                    #Application.labels["neworder_submit"]#
                </button>
                <button type="reset" class="btn btn-secondary waves-effect">
                    #Application.labels["neworder_reset"]#
                </button>
            </div>
        </div>
    
    </div>

</div>
</div>
</div>


    
</form>
</cfoutput>

