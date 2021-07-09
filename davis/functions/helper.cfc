<cfcomponent>
    <cffunction name="getLangFile" hint="Loads Language File and returns a simple Struct">
        <cffile action="read" file="#expandpath('/root/includes/labels.json')#" variable="labels">
        <cfreturn deserializeJSON(labels)>        
    </cffunction>
</cfcomponent>