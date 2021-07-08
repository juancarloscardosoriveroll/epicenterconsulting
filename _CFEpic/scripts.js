// TOGGLE DIV VISIBILITY (MULTIPLE DIVS SINGLE PAGE)
jQuery(($) => {
    const $actForms = $(".custom-register");
    const $actFormsBtns = $(".activate-form");
    $actFormsBtns.on("click", function() {
      $actFormsBtns.add($actForms).removeClass("is-active");
      $(this).add($(this.dataset.target)).addClass("is-active");
    });
});


// SIMPLE ASYNC FUNCTION TO DELETE
function delContact(id){
    if (confirm("Are you sure you wish to delete?")) {
        $.ajax(
            {   url: "scripts.cfm?delete=" + id, 
            success: function(result){ location.reload();}
            } ); 
    } else return;
}

// Prepopulate fields (get from service)
function editContact(id){
    $.ajax(
        {   
            url: "scripts.cfm?getid=" + id, 
        success: function(result){ 
            var obj = JSON.parse(result);
            $("#edit-id").val(obj.id);
            $("#edit-name").val(obj.name);
            $("#edit-phone").val(obj.phone);
            $("#edit-email").val(obj.email);

            $("#list-form").removeClass("is-active");
            $("#edit-form").addClass("is-active");

            }
        } );
}

// DOCUMENT READY INIT
$(document).ready(function(){
    // ACCORDION 
    $( function() { $( "#accordion" ).accordion({ collapsible: true, active: false }); } );

    // JQUERY FILTER (PRE-SEARCH)
    $("#search").on("keyup", function() {
      var value = $(this).val().toLowerCase();
      $("h3").filter(function() {
        $(this).toggle($(this).text().toLowerCase().indexOf(value) > -1)
      });
    });

    // JQUERY FORM NEW SUBMIT
    $("#myform").on("submit", function(event){
        event.preventDefault();
        var formValues= $(this).serialize();
        $.post("scripts.cfm?addnew", formValues, function(data){
            var obj = JSON.parse(data);
            if (!obj.success) alert(obj.message)
            else location.reload();            
        });
    });

    // JQUERY FORM EDIT SUBMIT
    $("#myform2").on("submit", function(event){
        event.preventDefault();
        var formValues= $(this).serialize();
        $.post("scripts.cfm", formValues, function(data){
            var obj = JSON.parse(data);
            if (!obj.success) alert(obj.message)
            else location.reload();            
        });
    });
});