<cfoutput>
<footer class="footer">
    <div class="container-fluid">
        <div class="row">
            <div class="col-sm-6">
                <script>document.write(new Date().getFullYear())</script> © #Application.labels["footer_name"]#.
            </div>
            <div class="col-sm-6">
                <div class="text-sm-end d-none d-sm-block">
                    #Application.labels["footer_madeby"]# 
                    <cfif isdefined("session.userid")>(#session.userid#)</cfif>
                </div>
            </div>
        </div>
    </div>
</footer>
</cfoutput>

