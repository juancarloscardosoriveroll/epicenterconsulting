<cfinvoke component="/root/functions/contacts" method="getContacts" returnvariable="Contacts" cid="#cid#" />
<cfinvoke component="/root/functions/contacts" method="getContactsMeta" returnvariable="Meta" cid="#cid#" />

<cfoutput>
<div class="row"> 
    <div class="col-12">
        <div class="card">
            <div class="card-body">

                <h4 class="card-title">
                    <a href="#application.urlPath#/?view=contactlist&contactType=#listfirst(Contacts.allkeys)#"><i class="fas fa-arrow-left"></i>&nbsp;                     
                    #contacts.cCoName#</a></h4>
                <p class="card-title-desc">#Application.labels['contactmeta_header']#</p>

                <form class="custom-validation daForm" id="daForm" action="#Application.urlPath#/includes/daForm.cfm?daCase=contactMeta">
                    <input type="hidden" name="cId" value="#contacts.cid#">
                    <input type="hidden" name="cownerid" value="#contacts.cOwnerID#"> 

                    <table class="table table-bordered dt-responsive nowrap table-striped"
                    style="border-collapse: collapse; border-spacing: 0; width: 100%;">

                    <!--- KEYS --->
                    <cfloop from="1" to="#arraylen(Application.setup.rkeycontacts)#" index="K">
                        <cfset cKey =  Application.setup.rkeycontacts[K]>

                        <cfif listfindnocase(Contacts.Allkeys,ckey.type)>
                            <tr>
                                <th>
                                    #evaluate("application.labels.contactlist_" & ckey.type)#
                                </th>
                                <td>
                                    <!--- try to set default --->
                                    <cfparam name="meta.#ckey.fieldName#" default="#ckey.default#">

                                    <!--- Display options --->
                                    <cfset myCats = Application.catalogs.getItems(ckey.catalog)>
                                    <select class="form-select" required name="#ckey.fieldname#">
                                        <option value="">#application.labels['general_selectOne']#</option>
                                        <cfloop query="myCats"> 
                                            <option value="#itemID#" <cfif evaluate('meta.' & ckey.fieldName) eq itemID> selected </cfif>>#itemName#</option>
                                        </cfloop>
                                    </select>

                                </td>
                            </tr>
                        </cfif>

                    </cfloop>




                    <!--- META --->
                    <cfloop from="1" to="#arraylen(application.setup.metacontacts)#" index="MC">
                        <cfif application.setup.metacontacts[MC].type eq 'all' or listfindnocase(Contacts.allkeys,application.setup.metacontacts[MC].type)>

                        <tr>
                            <th>
                                #application.setup.metacontacts[MC].fieldName#
                            </th>
                            <td>
                                <cfparam name="meta.#application.setup.metacontacts[MC].fieldName#" default="#application.setup.metacontacts[MC].default#">
                                <cfswitch expression="#application.setup.metacontacts[MC].dataType#">
                                    <cfcase value="text">
                                        <input name="#application.setup.metacontacts[MC].fieldName#"  type="text" class="form-control" value="#evaluate('meta.' & application.setup.metacontacts[MC].fieldName)#"> 
                                    </cfcase>
                                    <cfcase value="number">
                                        <input name="#application.setup.metacontacts[MC].fieldName#"  type="number" class="form-control" value="#evaluate('meta.' & application.setup.metacontacts[MC].fieldName)#" data-parsley-type="number"> 
                                    </cfcase>
                                    <cfcase value="textarea">
                                        <textarea name="#application.setup.metacontacts[MC].fieldName#" class="form-control" rows="3">#evaluate('meta.' & application.setup.metacontacts[MC].fieldName)#</textarea> 
                                    </cfcase>
                                    <cfcase value="select">
                                        <select name="#application.setup.metacontacts[MC].fieldName#" class="form-select">
                                            <cfloop list="#application.setup.metacontacts[MC].options#" index="Opt">
                                                <option <cfif evaluate('meta.' & application.setup.metacontacts[MC].fieldName) eq Opt> selected </cfif> >#Opt#</option>
                                            </cfloop>
                                        </select>
                                    </cfcase>
                                    <cfcase value="date">
                                        <input name="#application.setup.metacontacts[MC].fieldName#"  type="date" class="form-control" value="#evaluate('meta.' & application.setup.metacontacts[MC].fieldName)#"> 
                                    </cfcase>

                                </cfswitch>

                            </td>
                        </tr>

                    </cfif>
                </cfloop>


                </table>

                <hr size="1">


                <div class="float-end">
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
<!-- end row -->
</cfoutput>