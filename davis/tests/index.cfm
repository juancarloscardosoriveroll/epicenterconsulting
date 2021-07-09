<cfdirectory action="list" directory='#expandPath("./")#' recurse="false" name="Dir">

<cfoutput>
    <cfloop query="Dir">
        <cfif type eq 'Dir'>
            <cfset thisDir = Directory & "\" & Name>
            <cfset thisFolder = Name>
            <h3>#thisFolder#</h3>
            <cfdirectory action="list" directory='#thisDir#' recurse="false" name="Sub">
            <ol>
                <cfloop query="sub">
                    <li><a href="#thisFolder#/#Name#" target="TEST">#Name#</a></li>
                </cfloop>    
            </ol>
            <hr size="1">
        </cfif>
    </cfloop>
</cfoutput>
