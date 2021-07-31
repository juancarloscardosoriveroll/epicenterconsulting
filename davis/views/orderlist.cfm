
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
                            <th>#Application.labels['general_company']#</th>
                            <th>#Application.labels['general_name']#</th>
                            <th>#Application.labels['general_contact']#</th>
                            <th>#Application.labels['general_keys']#</th>
                            <th>#Application.labels['general_meta']#</th>
                            <th>isValid</th>
                        </tr>
                    </thead>

                    <tbody>
                    </tbody>
                </table>

            </div>
        </div>
    </div>
    <!-- end col -->
</div>
<!-- end row -->
</cfoutput>