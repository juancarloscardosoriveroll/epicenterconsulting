component
{
        this.name = "davis";
        this.datasource = "davis";
        this.mappings["/root"] = "C:\home\tutoro.me\wwwroot\davis"; 
        THIS.ApplicationTimeout = CreateTimeSpan( 0, 1, 0, 0 );
        THIS.SessionManagement = true;
        THIS.SetClientCookies = true;
        cfprocessingdirective.pageencoding = "utf-8";

        function OnRequestStart() {
            return true;
        }

        function onRequest(required string TargetPage) {
            //Reset Application if url.init
            if (isdefined("init")) {onApplicationStart();}
            include TargetPage;
            return true;
        }

        function onApplicationStart() {
            Application.urlPath = "http://tutoro.me/davis";
            Application.labels = createObject('component','root/functions/helper').getLangFile();
            return true;
        }

}
