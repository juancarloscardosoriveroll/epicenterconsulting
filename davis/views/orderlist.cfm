<cfinvoke component="/root/functions/orders" method="getOrders" returnvariable="Orders">

<cfoutput>
<div class="row"> 
    <div class="col-12">
        <div class="card">
            <div class="card-head mt-5">
                <div class="d-print-none">
                    <div class="float-end">   
                        <a href="#application.urlPath#/?view=newOrder" class="btn btn-primary w-md waves-effect waves-light">
                            <i class="fa fa-cogs"> #Application.labels['orderlist_addnew']# </i>
                        </a>  
                        &nbsp;   
                    </div> 
                </div>
            </div>

            <div class="card-body">

                <h4 class="card-title">#evaluate('Application.labels.orderlist_header')#</h4>
                <p class="card-title-desc">#Application.labels['orderlist_intro']#</p>

                <table id="datatable" class="table table-bordered dt-responsive nowrap table-striped"
                    style="border-collapse: collapse; border-spacing: 0; width: 100%;">
                    <thead>
                        <tr>
                            <th>Id</th>
                            <th>#application.labels["general_Date"]#</th>
                            <th>#application.labels["general_insuredEntity"]#</th>
                            <th>#application.labels["general_referedBy"]#</th>
                            <th>#application.labels["general_surveyor"]#</th>
                            <th>#application.labels["general_claims"]#</th>
                            <th>#application.labels["general_offices"]#</th>
                            <th></th>
                        </tr>
                    </thead>
                    <tbody>
                        <cfloop query="orders">
                        <tr>
                            <td><a href="#application.urlpath#/index.cfm?view=orderEdit&orderid=#orderId#">#orderId#</a></td>
                            <td>#orderDate#</td>
                            <td>#isInsd_cFirstName#</td>
                            <td>#isAcct_cFirstName#</td>
                            <td>#surveyor_cFirstName#</td>
                            <td>#claim_name#</td>
                            <td>#office_cFirstName#</td>
                            <td>
                                <div class="btn-group-vertical" role="group" aria-label="Vertical button group">
                                    <div class="btn-group" role="group">
                                        <button id="btnGroupVerticalDrop1" type="button"
                                            class="btn btn-secondary dropdown-toggle" data-bs-toggle="dropdown"
                                            aria-haspopup="true" aria-expanded="false">
                                            #application.labels["general_manage"]# <i class="mdi mdi-chevron-down"></i>
                                        </button>
                                        <div class="dropdown-menu" aria-labelledby="btnGroupVerticalDrop1">
                                            <a class="dropdown-item" href="#Application.urlPath#/index.cfm?view=OrderInsurance&orderid=#orderid#">Insurance</a>
                                            <a class="dropdown-item" href="#Application.urlPath#/index.cfm?view=OrderVessel&orderid=#orderid#">Vessel</a>
                                            <a class="dropdown-item" href="#Application.urlPath#/index.cfm?view=OrderPayments&orderid=#orderid#">Payments</a>
                                            <a class="dropdown-item" href="#Application.urlPath#/index.cfm?view=OrderInvoicing&orderid=#orderid#">Invoicing</a> 
                                            <a class="dropdown-item" href="#Application.urlPath#/index.cfm?view=OrderNotes&orderid=#orderid#">Notes</a> <!--- job recap, survey, comment, accident, conclusion, incident, billing, nonloss, special, notes --->

                                        </div>
                                    </div>
                                </div>
                            </td>
                        </tr>                            
                        </cfloop>
                    </tbody>
                </table>

            </div>
        </div>
    </div>
    <!-- end col -->
</div>
<!-- end row -->
</cfoutput>