component
{
    // global settings
    this.name = "davis";
    this.mappings["/root"] = "C:\home\tutoro.me\wwwroot\davis"; 

    THIS.ApplicationTimeout = CreateTimeSpan( 0, 1, 0, 0 );
    THIS.SessionManagement = true;
    THIS.SetClientCookies = true;
    cfprocessingdirective.pageencoding = "utf-8";

    // run this on each page request
    function onRequest(required string TargetPage) {
        //Reset Application if url.init
        if (isdefined("init")) {onApplicationStart();} 

        if (isdefined("url.logout")) {Logout();}

        // Include Custom System Functions
        include '/root/includes/udfs.cfm';

        // Default Navigation View
        include TargetPage; 
        return true;
    }

    // run this when Applicatio Starts
    function onApplicationStart() {
        Application.datasource = "davis";    
        Application.urlPath = "http://tutoro.me/davis";
        Application.labels = Application.helper.getLangFile();
        Application.errors = Application.helper.getErrorFile();
        Application.setup = Application.helper.getSetupFile();        
        Application.permits = Application.setup["permits"];  
        Application.helper = createObject('component','root/functions/helper');
        Application.catalogs = createObject('component','root/functions/catalogs');
        Application.contacts = createObject('component','root/functions/contacts');
        Application.users = createObject('component','root/functions/users');
        Application.orders = createObject('component','root/functions/orders');
        return true;  
    }

    // Logout function
    function Logout(){
        if (structKeyExists(session,"userid"))
        {
            structDelete(session,"userid");
        }
        location(Application.urlPath,"false");
    }

}
