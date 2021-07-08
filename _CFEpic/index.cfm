<!--- Get Data --->
<cfset myDir = createObject("component","scripts").init("directory.json")>
<cfset sorted = myDir.dataAsQuery("name")>

<html>
    <head>
        <title> awesomeContacts </title>
        <meta charset="utf-8"> 
        <meta name="viewport" content="width=device-width, initial-scale=1">

        <!--- JQUERY, JQUERYUI, BOOTSTRAP, FA CDNS FOR FRAMEWORK --->
        <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
        <link rel="stylesheet" href="https://pro.fontawesome.com/releases/v5.10.0/css/all.css" integrity="sha384-AYmEC3Yw5cVb3ZcuHtOA93w35dYTsvhLPVnYs9eStHfGJvOvKxVfELGroGkvsg+p" crossorigin="anonymous"/>
        <script src="https://code.jquery.com/jquery-1.12.4.js"></script>
        <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>        
        
        <!--- CUSTOM SETTINGS --->
        <link rel="stylesheet" href="styles.css?uuid=<cfoutput>#createuuid()#</cfoutput>"> 
        <script src="scripts.js?uuid=<cfoutput>#createuuid()#</cfoutput>"></script>
        
    </head>
    <body>

        <div class="container">

            <!--- HEADER --->
            <a href="index.cfm"><img src="logo.png"></a>


            <!--- MAIN LISTING --->
            <Cfoutput>
                <div id="list-form" class="custom-register is-active">
                    <div class="card">
                        <div class="card-header">
                            <span class="search">Search </span> <input type="text" name="search" id="search">
                            <div class="menu">
                                <button type="button" data-target="##new-form" class="btn btn-light btn-sm activate-form"><i class="fa fa-plus"></i> AddNew</button>
                            </div>
                        </div>
                        <div class="card-body">
                            <div id="accordion">
                                <cfloop query="sorted" >
                                    <h3>#name#
                                        <div class="menu">
                                            <a href="##" class="btn btn-primary btn-sm text-white" onclick="javascript:editContact('#id#');">Update</a>                       
                                            <a href="##" class="btn btn-dark btn-sm text-white" onclick="javascript:delContact('#id#');">Delete</a>                       
                                        </div>
                                    </h3>
                                    <div>     
                                            name: #name#
                                            <br>phone: #phone#
                                            <br>email: #email#
                                    </div>
                                </cfloop>
                            </div> <!--- ACCORDION --->
                        </div>
                    </div>

                </div> <!--- DIV LIST-FORM --->
            </Cfoutput>


            <!--- ADD NEW  --->
            <cfoutput>
                <div id="new-form" class="custom-register">
                    <div class="card">
                        <form id="myform">
                            <div class="card-header">
                                <button type="button" data-target="##list-form" class="btn btn-light btn-sm activate-form"><i class="fa fa-arrow-left"></i> Back</button>
                                <div class="menu">
                                    <button type="button" class="btn btn-light btn-sm" disabled><i class="fa fa-plus"></i> AddNew</button>
                                </div>
                            </div>
                            <div class="card-body">
                                <div class="form-group">
                                    <label for="name" class="label">name</label>
                                    <input type="text" class="form-control" id="name" name="name" required >
                                </div>                                
                                <div class="form-group">
                                    <label for="phone" class="label">phone</label>
                                    <input type="text" class="form-control" id="phone" name="phone" required >
                                </div>                                
                                <div class="form-group">
                                    <label for="email" class="label">email</label>
                                    <input type="text" class="form-control" id="email" name="email" required>
                                </div>                                
                            </div>
                            <div class="card-footer">
                                <button  type="submit" class="btn btn-primary mb-2">Save</button>
                                <button type="reset" class="btn btn-secondary mb-2">Reset</button>
                            </div>
                        </form>

                    </div> 
                </div>
            </cfoutput>


            <!--- UPDATE  --->
            <cfoutput>
                <div id="edit-form" class="custom-register">
                    <div class="card">
                        <form id="myform2">
                            <input type="hidden" id="edit-id" name="id" value="">
                            <div class="card-header">
                                <button type="button" data-target="##list-form" class="btn btn-light btn-sm activate-form"><i class="fa fa-arrow-left"></i> Back</button>
                                <div class="menu">
                                    <button type="button" class="btn btn-light btn-sm" disabled><i class="fa fa-pencil"></i> Update</button>
                                </div>
                            </div>
                            <div class="card-body">
                                <div class="form-group">
                                    <label for="name" class="label">name</label>
                                    <input type="text" class="form-control" id="edit-name" name="name" required >
                                </div>                                
                                <div class="form-group">
                                    <label for="phone" class="label">phone</label>
                                    <input type="text" class="form-control" id="edit-phone" name="phone" required >
                                </div>                                
                                <div class="form-group">
                                    <label for="email" class="label">email</label>
                                    <input type="text" class="form-control" id="edit-email" name="email" required >
                                </div>                                
                            </div>
                            <div class="card-footer">
                                <button  type="submit" class="btn btn-primary mb-2">Save</button>
                                <button data-target="##list-form" class="btn btn-secondary mb-2">Cancel</button>
                            </div>
                        </form>

                    </div> 
                </div>
            </cfoutput>

            <div class="footer">Epicenter Consulting Mexico <Cfoutput>#year(now())#</Cfoutput></div>

        </div> <!--- CONTAINER --->

    </body>

</html>