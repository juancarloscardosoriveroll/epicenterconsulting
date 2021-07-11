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


$(document).ready(function() {
    $("#datatable").DataTable()
});
