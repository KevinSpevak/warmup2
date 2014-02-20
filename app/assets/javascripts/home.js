SUCCESS             =  1;
ERR_BAD_CREDENTIALS = -1;
ERR_USER_EXISTS     = -2;
ERR_BAD_USERNAME    = -3;
ERR_BAD_PASSWORD    = -4;


function clear_form() {
    $("#user").val("");
    $("#password").val("");
}

function send_credentials(username, password, path, on_success) {
    json_data = JSON.stringify( { user : username, password : password });
    $.ajax({
	type: 'POST',
	url: path,
        data: json_data,
	contentType: "application/json",
	dataType: "json",
	success: on_success,
	error: alert_error
    });
}

function alert_error(e) {
    alert('An error occured on request');
}

function handle_response(user, request_type, response) {
    err = response.errCode;
    count = response.count;
    if (err == SUCCESS) {
        is_new = (request_type == "add")
	show_welcome_screen(user, count, is_new);
        return
    }
    err_msg = "could not find error message";
    switch (err) {
    case -1:
	err_msg = "Invalid username and password combination."
	break;
    case -2:
        err_msg = "This username already exists."
	break;
    case -3:
	err_msg = "The username should be non-empty and at most 128 characters long."
	break;
    case -4:
	err_msg = "The password should be at most 128 characters long."
    }
    $('#home_msg').html(err_msg + "  Please try again.");

    
}

function show_welcome_screen(user, count, is_new) {
    $('#login_screen').hide();
    if (is_new) {
	$('#welcome_msg').html("Welcome new user " + user + "! You have logged in once.");
    } else {
        $('#welcome_msg').html("Welcome back " + user + "! You have logged in " + count + " times.");
    }
    $('#welcome_screen').show();
}

function show_login_screen() {
    $('#welcome_screen').hide();
    $('#login_screen').show();
}

