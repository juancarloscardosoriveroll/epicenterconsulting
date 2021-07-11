<cfset session.userId = 2>

<cfoutput>
<!doctype html>
<html lang="en">
    <!--- Include Head (links/scripts) --->
    <cfinclude template="/root/includes/head.cfm">

    <body data-layout="detached" data-topbar="colored">
    <!-- <body data-layout="horizontal" data-topbar="dark"> -->

        <div class="container-fluid">
            <!-- Begin page -->
            <div id="layout-wrapper">
                <header id="page-topbar">
                    <div class="navbar-header">
                        <div class="container-fluid">  
                            <cfinclude template="/root/includes/header.cfm">
                        </div>
                    </div>
                </header>

                <!--- Only include sidemenu if logged-in --->
                <cfif isdefined("session.userid")>
                    <cfinclude template="/root/includes/vmenu.cfm">
                </cfif>

                <!-- ============================================================== -->
                <!-- Start right Content here -->
                <!-- ============================================================== -->
                <div class="main-content">
                    <div class="page-content">
                        <!-- start page title -->
                        <div class="row">
                            <div class="col-12">
                                <div class="page-title-box d-flex align-items-center justify-content-between">
                                    <h4 class="page-title mb-0 font-size-18">#evaluate("Application.labels.#view#_title")#</h4>
                                    <div class="page-title-right">
                                        <ol class="breadcrumb m-0">
                                            <li class="breadcrumb-item active">#evaluate("Application.labels.#view#_subtitle")#</li>
                                        </ol>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <!-- end page title -->

                        <!--- Include Navigation Content --->
                        <cfinclude template="/root/views/#view#.cfm">


                    </div>
                    <!-- End Page-content -->

                    <cfinclude template="/root/includes/footer.cfm">
                </div> <!-- end main content-->
            </div> <!-- END layout-wrapper -->
        </div>  <!-- end container-fluid -->

        <!--- <cfinclude template="/root/includes/rightbar.cfm"> --->

        <!-- INCLUDE CUSTOM TEMPLATE SCRIPTS -->
        <cfinclude template="/root/includes/scripts.cfm">
    </body>

</html>
</cfoutput>