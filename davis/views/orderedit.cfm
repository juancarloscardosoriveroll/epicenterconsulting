<cfset Order = application.orders.getorders(orderid)>

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
    <form class="custom-validation daForm" id="daForm" action="#Application.urlPath#/includes/daForm.cfm?daCase=orderedit">
        <input type="hidden" name="orderid" value="#orderid#">

    <div class="row">
        <div class="card">
            <div class="card-body">  
                <h4 class="card-title">
                    <a href="#application.urlPath#/?view=orderlist"><i class="fas fa-arrow-left"></i>&nbsp;                        
                    #Application.labels['general_back']#</a></h4>
                <p class="card-title-desc">#Application.labels["orderedit_intro"]#</p> 


    <div class="row">
        <div class="col-lg-12">

            <!--- INSURED PERSON/COMPANY --->  
            <div class="mb-3">
                <label class="form-label">#application.labels['General_InsuredEntity']#</label>
                <div>
                    #Order.isInsd_cfirstName# (#application.labels['General_order']#: #OrderID#)
                </div>
            </div>
            
        </div>
    </div>
    <div class="row">

        <div class=" mt-3">
            <label class="form-label">#application.labels['General_referedBy']#</label>
            <select class="form-select" name="cid_isacct" required>
                <option value="">#application.labels['General_SelectOne']#</option>
                <cfloop from="1" to="#arraylen(Phones)#" index="X">
                    <option value="#Phones[X].cid#" <cfif Phones[X].cid eq Order.cid_isacct> selected </cfif>>#Phones[X].cCustomKey# (#Phones[X].itemName#) - #Phones[X].cFirstName# (#Phones[X].cCoName#) - ID #Phones[X].cid#</option> 
                </cfloop>
            </select>
        </div>


        <div class=" mt-3">
            <label class="form-label">#application.labels['General_surveyor']#</label>
            <select class="form-select" name="uid_surveyor" required>
                <option value="">#application.labels['General_SelectOne']#</option>
                <cfloop query="Surveyors">
                    <option value="#userid#"  <cfif userid eq Order.uid_surveyor> selected </cfif>>#userFirstname# #userLastname# (#userPhone#,#userEmail#) - ID #userid#</option> 
                </cfloop>
            </select>
        </div>



        <div class=" mt-3">
            <label class="form-label">#application.labels['General_sources']#</label>
            <select class="form-select" name="cat_sourcetype" required>
                <option value="">#application.labels['General_SelectOne']#</option>
                <cfloop query="Sources">
                    <option value="#itemid#" <cfif itemid eq Order.cat_sourcetype> selected </cfif>>#itemName# (ID: #itemid#) <cfif len(itemDesc) gt 0> -#mid(itemDesc,1,25)#...</cfif></option> 
                </cfloop>
            </select>
        </div>


        <div class=" mt-3">
            <label class="form-label">#application.labels['General_claims']#</label>
            <select class="form-select" name="cat_claimtype" required>
                <option value="">#application.labels['General_SelectOne']#</option>
                <cfloop query="Claims">
                    <option value="#itemid#" <cfif itemid eq Order.cat_claimtype> selected </cfif>>#itemName# (ID: #itemid#) <cfif len(itemDesc) gt 0> -#mid(itemDesc,1,25)#...</cfif></option> 
                </cfloop>
            </select>
        </div>


        <div class=" mt-3">
            <label class="form-label">#application.labels['General_Offices']#</label>
            <select class="form-select" name="cid_isoffice" required>
                <option value="">#application.labels['General_SelectOne']#</option>
                <cfloop query="Offices">
                    <option value="#cid#" <cfif cid eq Order.cid_isoffice> selected </cfif>>#cCustomKey# - #cFirstName#  - ID #cid#</option> 
                </cfloop>
            </select>
        </div>


    </div>
    <div class="row">

        <div class="mt-3">
            <div class="float-end">
                <button type="submit" class="btn btn-primary waves-effect waves-light me-1">
                    #Application.labels["orderedit_submit"]#
                </button>
                <button type="reset" class="btn btn-secondary waves-effect">
                    #Application.labels["orderedit_reset"]#
                </button>
            </div>
        </div>
    
    </div>

</div>
</div>
</div>


    
</form>
</cfoutput>

