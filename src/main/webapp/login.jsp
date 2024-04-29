<%@ page import="org.prajwal.techblogjsp.entities.Message" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>TechBlog: Login</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css"
          integrity="sha384-xOolHFLEh07PJGoPkLv1IbcEPTNtaed2xpHsD9ESMhqIYd0nLMwNLD69Npy4HI+N"
          crossorigin="anonymous">
    <link rel="stylesheet" href="css/styles.css" type="text/css">
    <%-- Icons import--%>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">

</head>
<body>

    <%-- Navbar --%>
    <%@include file="navbar.jsp"%>

    <%-- Login form--%>
    <main class="d-flex align-items-center" style="height: 80vh">
        <div class="container">
            <div class="row">
                <div class="col-md-4 offset-md-4">
                    <div class="card shadow">
                        <div class="card-header bg-primary text-white text-center">
                            <h3>Login</h3>
                        </div>
                        <%
                            Message m = (Message) session.getAttribute("errorMessage");
                            if (m!=null){
                                // error occurred
                        %>
                                <div class="alert <%= m.getCssClass() %>" role="alert">
                                    <%= m.getContent() %>
                                </div>

                        <%
                                session.removeAttribute("errorMessage");
                            }
                        %>
                        <div class="card-body">
                            <form action="login" method="post">
                                <div class="form-group">
                                    <label for="exampleInputEmail1">Email address</label>
                                    <input type="email" name="userEmail" required class="form-control" id="exampleInputEmail1" placeholder="Enter your email"
                                        value="<%= request.getParameter("email") != null ? request.getParameter("email") : "" %>">
                                </div>
                                <div class="form-group">
                                    <label for="exampleInputPassword1">Password</label>
                                    <input type="password" name="userPassword" required class="form-control" id="exampleInputPassword1" placeholder="Enter your password">
                                </div>
                                <button type="submit" class="btn btn-primary btn-block">Login</button>
                            </form>
                        </div>
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

    <%-- External js --%>
    <script src="js/app.js" type="text/javascript"></script>

</body>
</html>
