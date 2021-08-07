<cfscript>
    function RQ(string,q) {return replacenocase(string,q,'<b>' & q & '</b>','all');}
</cfscript>

<cfparam name="q" default="">
<cfset Results = application.helper.search(q=q)>

<cfoutput>

    <!--- Contacts --->
    <cfif isdefined("results.contacts") and results["contacts"].recordcount gt 0>
        <div class="card">
            <div class="card-head">
                CONTACTS
            </div>
            <div class="card-body">
                <ul>
                    <cfloop query="#results.contacts#"> 
                        <li>(ID: <a href="#application.urlPath#/index.cfm?view=contactEdit&cid=#cid#">#cid#</a>) #RQ(cFirstName,q)# #RQ(cLastname,q)# #RQ(cCoName,q)#</li>
                    </cfloop>
                </ul>
            </div>
        </div>
    </cfif>

    <!--- Contacts Meta Data --->
    <cfif isdefined("results.metadata") and results["metadata"].recordcount gt 0>
        <div class="card">
            <div class="card-head">
                CONTACT METADATA
            </div>
            <div class="card-body">
                <ul>
                    <cfloop query="#results.metadata#"> 
                        <li>(ID: <a href="#application.urlPath#/index.cfm?view=contactMeta&cid=#cid#">#cid#</a>) #RQ(cFirstName,q)# #RQ(cLastname,q)# #RQ(cCoName,q)# - #CField# : #rq(cValue,q)#</li>
                    </cfloop>
                </ul>
            </div>
        </div>
    </cfif>

    



</cfoutput>

