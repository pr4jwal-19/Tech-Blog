<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%--// In your servlet response--%>
<%
response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate"); // HTTP 1.1.
response.setHeader("Pragma", "no-cache"); // HTTP 1.0.
response.setDateHeader("Expires", 0); // Proxies.
%>
<!DOCTYPE html>
<html>
<head>
    <title>TechBlog: Register</title>
    <!--css for web-->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css"
          integrity="sha384-xOolHFLEh07PJGoPkLv1IbcEPTNtaed2xpHsD9ESMhqIYd0nLMwNLD69Npy4HI+N"
          crossorigin="anonymous">
    <link rel="stylesheet" href="css/styles.css" type="text/css">
    <%-- Icons import--%>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">

</head>
<body>

<main>
    <div class="container mt-5">
        <div class="col-md-6 offset-md-3" style="margin-bottom: 35px">
            <div class="card shadow">
                <div class="card-header bg-primary text-white text-center">
                    Register Here
                </div>
                <div class="card-body" style="height: auto;">

                    <form id="reg-form" action="register" method="post">

                        <div class="form-group">
                            <label for="exampleInputUsername">Username</label>
                            <input type="text" name="user_name" class="form-control" id="exampleInputUsername" placeholder="Enter your username">
                        </div>
                        <div class="form-group">
                            <label for="exampleInputEmail1">Email address</label>
                            <input type="email" name="user_email" class="form-control" id="exampleInputEmail1" placeholder="Enter your email">
                        </div>
                        <div class="form-group">
                            <label for="exampleInputPassword1">Password</label>
                            <input type="password" name="user_password" class="form-control" id="exampleInputPassword1" placeholder="Enter your password">
                        </div>
                        <div class="form-group">
                            <label>Gender</label><br>
                            <div class="form-check form-check-inline">
                                <input class="form-check-input" type="radio" name="gender" id="maleRadio" value="Male">
                                <label class="form-check-label" for="maleRadio">Male</label>
                            </div>
                            <div class="form-check form-check-inline">
                                <input class="form-check-input" type="radio" name="gender" id="femaleRadio" value="Female">
                                <label class="form-check-label" for="femaleRadio">Female</label>
                            </div>
                            <div class="form-check form-check-inline">
                                <input class="form-check-input" type="radio" name="gender" id="otherRadio" value="Other">
                                <label class="form-check-label" for="otherRadio">Other</label>
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="exampleAbout">About</label><textarea name="about" class="form-control" id="exampleAbout" rows="5" placeholder="What best describes you !"></textarea>
                        </div>
                        <div class="form-group form-check">
                            <input type="checkbox" name="agreement" class="form-check-input" id="exampleCheck1">
                            <label class="form-check-label" for="exampleCheck1">Agree to terms & conditions</label>
                        </div>
                        <div class="container text-center" id="loader" style="display: none">
                            <span class="fa fa-refresh fa-spin fa-3x"></span>
                        </div>
                        <br>
                        <button type="submit" id="submit-btn" class="btn btn-primary btn-block">Register</button>
                    </form>
                </div>
            </div>
        </div>
    </div>
</main>

<%--javascript--%>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"
        integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo="
        crossorigin="anonymous">
</script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-Fy6S3B9q64WdZWQUiU+q4/2Lc9npb8tCaSX9FK7E8HnRr0Jz8D6OP9dO5Vg3Q9ct"
        crossorigin="anonymous">
</script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/2.1.2/sweetalert.min.js"></script>
<script>

    $(document).ready(function (){
        console.log("loaded.....")
        $('#reg-form').on('submit',function (event){
            event.preventDefault();
            let form = new FormData(this);

            //before sending data to servlet
            $('#submit-btn').hide();
            // show the loader
            $('#loader').show();

            //send to RegisterServlet
            $.ajax({
               url: "register",
               type: 'POST',
               data: form,
               success: function (data,textStatus,jqXHR){
                    console.log(data)
                    $('#loader').hide();
                    $('#submit-btn').show();
                    if(data.trim()==="done"){
                        let userEmail = $('#exampleInputEmail1').val();
                        swal("Good job!,You are registered successfully! ","Redirecting to Login", "success")
                            .then((value) => {
                                window.location="login.jsp?email="+userEmail;
                            });
                    }
                    else{
                        swal(data);
                    }
               },
               error: function (jqXHR,textStatus,errorThrown) {
                   $('#loader').hide();
                   $('#submit-btn').show();
                   swal("Something went wrong...Try Again !","error");
               },
               processData: false,
               contentType: false

            });

        });

    });

</script>
<%-- External js --%>
<script src="js/app.js" type="text/javascript"></script>

</body>
</html>
