<cfinvoke component="/root/functions/orders" method="getOrders" returnvariable="Order" orderid="#orderid#">

<cfoutput>
    <div class="row">
        <div class="col-lg-12">
            <div class="card">
                <div class="card-body">
                    <h4 class="card-title">
                        <a href="#application.urlPath#/?view=orderlist"><i class="fas fa-arrow-left"></i>&nbsp;                        
                        #order.orderid#</a></h4>
                    </h4>

                    <p class="card-title-desc">#Application.labels["ordernotes_intro"]#</p> 
    
                    <form class="custom-validation daForm" id="daForm" action="#Application.urlPath#/includes/daForm.cfm?daCase=ordernotes">
                        <input type="hidden" name="orderId" value="#orderid#">

                        <!--- TYPE --->
                        <div class="mb-3">
                            <label class="form-label">
                                Type
                            </label>
                            <div>
                                <select class="form-select populate" name="orderNote_type" required data-value="#orderid#" data-action="#application.urlPath#/includes/daGet.cfm?daCase=orderNotes" data-callback="orderNotes_value">
                                    <option value="">#application.labels['general_selectOne']#</option>
                                    <cfloop from="1" to="#arraylen(Application.setup.orderNotes)#" index="Note">
                                        <cfset mylabel = "(" & application.setup.orderNotes[Note].label & ") " & left(Application.orders.getOrderNotes(application.setup.orderNotes[Note].value,orderid),50) & "...">
                                        <option value="#application.setup.orderNotes[Note].value#">#mylabel#</option>
                                    </cfloop>
                                </select>
                            </div>
                        </div>


                        <!--- NOTE --->
                        <div class="mb-3">
                            <label class="form-label">
                                Value
                            </label>
                            <div>
                                <textarea class="form-control" rows="10" name="orderNote_value" id="orderNotes_value"></textarea>
                            </div>
                        </div>


                        <!--- SUBMIT --->
                        <div>
                            <div>
                                <button type="submit" class="btn btn-primary waves-effect waves-light me-1">
                                    #Application.labels["general_submit"]#
                                </button>
                                <button type="reset" class="btn btn-secondary waves-effect">
                                    #Application.labels["general_reset"]#
                                </button>
                            </div>
                        </div>
                    </form>




                </div>
            </div>
        </div>
    </div>
</cfoutput>