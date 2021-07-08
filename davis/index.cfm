<h1>Davis MDB</h1>

<cfdbinfo 
datasource="davis" 
name="davis" 
type="tables" >

<cfloop query="davis">
        <cfdbinfo 
        datasource="davis" 
        name="davis" 
        type="columns" 
        table="#table_name#">
        
        <cfdump var="#davis#" label="#table_name# : #table_type#">
</cfloop>