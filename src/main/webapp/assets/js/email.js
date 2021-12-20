document.getElementById("emailForm").addEventListener("submit", submitForm)

function submitForm(e) {
    e.preventDefault();

    let name= document.getElementById("sendMailName").value;
    let email= document.getElementById("sendMailEmail").value;
    let message = document.getElementById("sendMailBody").value;

    document.getElementById("submit").value="Sending ...";

    sendEmail(name,email,message)
}

function sendEmail(name,email,message) {
    Email.send({
        Host: "smtp.gmail.com",
        Username: "ensaaevents@gmail.com",
        Password: "Ensaagadir2021",
        To : "ensaaevents@gmail.com",
        From : "ensaaevents@gmail.com",
        Subject : `${name} sent a new message`,
        Body : `Name: ${name} <br/> Email : ${email} <br/> Message: <br/> ${message}`,
    }).then((message) => {
        if(message == "OK") {
            document.getElementById("emailForm").reset();
            var ele = document.getElementById("submit");
            ele.value="Sent";
            ele.classList.add("form-home_button-success")
        } else {
            var ele = document.getElementById("submit");
            ele.value="Error";
            ele.classList.add("form-home_button-fail")
        }
    })
}