********** File Structure *********

Application.cfc
----------------
this.datasource : registered CF Datasource for SQL
this.mappings.root : Path to root of hosted app (filesystem)
Application.urlPath : Path to root of hosted app (webfacing)


Includes (root/includes)
----------------
/labels.json ---> language/labels file
/head.cfm   ---> customized html head from template 


Functions (root/functions)
----------------
/helper.cfc ---> general system functions


Tests (root/tests)
----------------
/index.cfm --> lists all Unitary & Integration tests


Template (root/template/)
----------------
/admin/dist/index.html ---> Sample Landing of Design Template



********** DATA **********
Errors importing from MDB to SQL
1) Phones (last_cont, Follow_up IGNORED - Bad Datetime)
2) ref_data (trimmed, data error(format/len) after X rows)
3) ref_dataold (trimmed, data error(format/len) after X rows) 
4) q_wip  (trimmed, data error(format/len) after X rows) 



********* TIPS ***********
?init : restarts the application