<!--- Tool to import Old catalogs to new format --->

<!--- 1) BOAT TYPES --->
<cfquery dbtype="odbc" datasource="#application.datasource#" name="boatTypes">
select * FROM dbo.[Boat Types];
</cfquery>


<cfdump var="#BoatTypes#">        