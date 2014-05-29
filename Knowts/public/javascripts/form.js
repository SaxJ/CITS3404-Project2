function validateName(name) {
    var regex = new RegExp("[A-Za-z0-9\. _]{3,}");
    console.log("blah");
    if(!regex.test(name)) {
        alert("Please Enter a Valid Name."); return false;
    }
    return true;
}

function validateEmail(email) {
    var regex = new RegExp("[A-Za-z0-9._+-]+@[A-Za-z0-9.-]+\.[A-Za-z]");
    console.log("ddd");
    if(!regex.test(email)) {
        alert("Please Enter a Valid Email."); return false;
    }
    return true;
}

function validatePassword() {
    var regex = new RegExp(".{8,}");
    console.log("dzwda");
    if(!regex.test(password)) {
        alert("Please Enter a Valid Password."); return false;
    }
    return true;
}

function validateSignup() {
    var name = document.forms["new_user"]["user[name]"].value;
    var email = document.forms["new_user"]["user[email]"].value;
    var password = document.forms["new_user"]["user[password]"].value;
    var password2 = document.forms["new_user"]["user[password_confirmation]"].value;
    if("" +password != "" + password2) {
        alert("Passwords do not match."); return false;
    }
    return validateName(name) && validateEmail(email) && validatePassword(password);
}