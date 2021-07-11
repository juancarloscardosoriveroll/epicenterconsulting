component
{
    // global settings
    this.name = "davis";
    this.mappings["/root"] = "C:\home\tutoro.me\wwwroot\davis"; 


    this.devMode = true;
    THIS.ApplicationTimeout = CreateTimeSpan( 0, 1, 0, 0 );
    THIS.SessionManagement = true;
    THIS.SetClientCookies = true;
    cfprocessingdirective.pageencoding = "utf-8";

    // run this on each page request
    function onRequest(required string TargetPage) {
        //Reset Application if url.init
        if (isdefined("init")) {onApplicationStart();} 

        // Include Custom System Functions
        include '/root/includes/udfs.cfm';

        // Default Navigation View
        cfparam(name="view", default="dashboard");

        // Important, force Login (when live)
        if (Not(this.devMode)) { 
            if (not(isdefined("client.userid"))) {
                view = 'login';
                include '/root/index.cfm';
            }
            else{ include TargetPage; }
        }
        // add anything else needed for dev under here}
        else{ include TargetPage; 
        }
        return true;
    }

    // run this when Applicatio Starts
    function onApplicationStart() {
        Application.datasource = "davis";    
        Application.urlPath = "http://tutoro.me/davis";
        Application.helper = createObject('component','root/functions/helper');
        Application.labels = Application.helper.getLangFile();
        Application.errors = Application.helper.getErrorFile();
        Application.setup = Application.helper.getSetupFile();        
        Application.permits = Application.helper.getPermitFile();        
        return true;  
    }

}
