<cfparam name="daCase" default="">
<cfset Result = "">

<cfswitch expression="#daCase#">
    <cfcase value="orderNotes">
        <cfset result = application.orders.getOrderNotes(orderNote_type="#type#",orderId="#id#")>
    </cfcase>
</cfswitch>

<cfoutput>#Result#</cfoutput>