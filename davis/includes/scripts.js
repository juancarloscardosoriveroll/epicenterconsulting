$(".daToggle").on("click",function(event){
    /* Convert from URL Data Attr to Dynamic Form so to use daForm logic */
    var myAction = $(this).data("action"); 
    var myCallback = $(this).data("callback");

    $.get(myAction, function(data){
        var obj = JSON.parse(data);

        // change calling element
        try { $("#" + myCallback + " a").html(obj.data.callback);  }  
        catch (error) {/*ignore*/}      

        // return message if not empty
        if (obj.message.length > 0)
            //use sweet alerts
            Swal.fire({
                title: obj.message,
                confirmButtonColor: "#3b5de7",
                type: "info"
            }).then(function(t) {
                // redirect to a different view if case
                if (obj.view.split(";")[0] == 'redirect')
                    location.href = obj.view.split(";")[1];

                // or reload existing view if case
                if (obj.view.split(";")[0] == 'reload')
                    location.reload();
            })

    });
});


/* SCRIPT TO MANAGE ALL VALIDATED FORMS ASYNC */
$(".daForm").on("submit", function(event){

    $(this).parsley().validate(); 
    if ($(this).parsley().isValid()){

        event.preventDefault();
        var formValues= $(this).serialize();
        var myAction = $(this).attr('action');        
        $.post(myAction, formValues, function(data){
            var obj = JSON.parse(data);

            // return message if not empty
            if (obj.message.length > 0)
                //use sweet alerts
                Swal.fire({
                    title: obj.message,
                    confirmButtonColor: "#3b5de7",
                    type: "info"
                }).then(function(t) {
    
                    // redirect to a different view if case
                    if (obj.view.split(";")[0] == 'redirect')
                        location.href = obj.view.split(";")[1];

                    // or reload existing view if case
                    if (obj.view.split(";")[0] == 'reload')
                        location.reload();
    

                })
    

        });
    }
});


$(".getStatesfromCountry").on("change",function(event){
    
    var myCountry = $(this).val();
    var myAction = $(this).data("action") + "&country=" + myCountry; 

    let dropdown1 = $("#state");
    dropdown1.empty();
    dropdown1.append('<option selected="true" disabled>Choose State</option>'); 
    dropdown1.prop('selectedIndex', 0);

    let dropdown2 = $("#county");
    dropdown2.empty();
    dropdown2.append('<option selected="true" disabled>Choose County</option>'); 
    dropdown2.prop('selectedIndex', 0);

    let dropdown3 = $("#city");
    dropdown3.empty();
    dropdown3.append('<option selected="true" disabled>Choose City</option>'); 
    dropdown3.prop('selectedIndex', 0);


    $.getJSON(myAction, function (data) {
        $.each(data, function (key, entry) {
          dropdown1.append($('<option></option>').attr('value',myCountry + ',' +  entry.abbreviation).text(entry.name));
        })
      });
});



$(".stateToCounty").on("change",function(event){
    /* Convert from URL Data Attr to Dynamic Form so to use daForm logic */
    var tempval = $(this).val();
    var myCountry = tempval.split(",")[0];     
    var myState = tempval.split(",")[1]; 

    var myAction = $(this).data("action") + "&state=" + myState + "&country=" + myCountry; 

    let dropdown1 = $("#county");
    dropdown1.empty();
    dropdown1.append('<option selected="true" disabled>Choose State</option>'); 
    dropdown1.prop('selectedIndex', 0);

    let dropdown2 = $("#city");
    dropdown2.empty();
    dropdown2.append('<option selected="true" disabled>Choose County</option>'); 
    dropdown2.prop('selectedIndex', 0);
 

    $.getJSON(myAction, function (data) {
        $.each(data, function (key, entry) {
          dropdown1.append($('<option></option>').attr('value', myState + ',' + entry.value).text(entry.name));
        })
      });
});

$(".countyToCity").on("change",function(event){
    /* Convert from URL Data Attr to Dynamic Form so to use daForm logic */  
    var tempval = $(this).val();
    var myState = tempval.split(",")[0];     
    var myCounty = tempval.split(",")[1];     
    var myAction = $(this).data("action") + "&state=" + myState + "&county=" + myCounty; 

    let dropdown1 = $("#city");
    dropdown1.empty();
    dropdown1.append('<option selected="true" disabled>Choose State</option>'); 
    dropdown1.prop('selectedIndex', 0);

    $.getJSON(myAction, function (data) {
        $.each(data, function (key, entry) {
          dropdown1.append($('<option></option>').attr('value', entry.value).text(entry.name));
        })
      });
});


$(".updateZipCode").on("click",function(event){
    let zipcode = $("#city").val();    
    $("#zipcode").val(zipcode);
    $(".zipcode-modal").modal('hide');

});

$( function() {
    
    $( ".cid" ).autocomplete({
      source: "http://tutoro.me/davis/functions/remote.cfc?method=AC_Contacts&contactType=" + $(".cid").data("type"),
      minLength: 2,
      select: function( event, ui ) {
        $("#insName").val(ui.item.label);
        $("#insAddress").val(ui.item.address);
        $("#insContact").val(ui.item.contact);

      }
    });
});


$(document).ready(function() {
    $("#datatable").DataTable()
});


