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


$(".stateToCounty").on("change",function(event){
    /* Convert from URL Data Attr to Dynamic Form so to use daForm logic */
    var myState = $(this).val();
    var myTarget = $(this).data("target");
    var myAction = $(this).data("action") + "&state=" + myState; 

    let dropdown = $("#" + myTarget);
    dropdown.empty();
    dropdown.append('<option selected="true" disabled>Choose County</option>'); 
    dropdown.prop('selectedIndex', 0);

    $.getJSON(myAction, function (data) {
        $.each(data, function (key, entry) {
          dropdown.append($('<option></option>').attr('value', myState + ',' + entry.value).text(entry.name));
        })
      });
});

$(".countyToCity").on("change",function(event){
    /* Convert from URL Data Attr to Dynamic Form so to use daForm logic */  
    var tempval = $(this).val();
    var myState = tempval.split(",")[0];     
    var myCounty = tempval.split(",")[1];     
    var myTarget = $(this).data("target");
    var myAction = $(this).data("action") + "&state=" + myState + "&county=" + myCounty; 

    let dropdown = $("#" + myTarget);
    dropdown.empty();
    dropdown.append('<option selected="true" disabled>Choose City</option>');
    dropdown.prop('selectedIndex', 0);

    $.getJSON(myAction, function (data) {
        $.each(data, function (key, entry) {
          dropdown.append($('<option></option>').attr('value', entry.value).text(entry.name));
        })
      });
});


$(".updateZipCode").on("click",function(event){
    let zipcode = $("#city").val();    
    $("#zipcode").val(zipcode);
    $(".zipcode-modal").modal('hide');

});


$(document).ready(function() {
    $("#datatable").DataTable()
});


