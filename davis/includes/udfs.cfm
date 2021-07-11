<!--- User Defined Functions --->

<cfscript> 
    /* Returns true or false Boolean format */ 
    function U_int2Bool(myvalue) 
    { 
        if (myvalue EQ 1 OR myvalue EQ 'true' OR myvalue EQ 'yes')
             {return true } 
        else {return false}
    }

    /* Returns true or false Binary format */
    function U_Bool2Int(myvalue) 
    { 
        if (myvalue EQ 1 OR myvalue EQ 'true' OR myvalue EQ 'yes')
             {return 1 } 
        else {return 0}
    }
</cfscript>