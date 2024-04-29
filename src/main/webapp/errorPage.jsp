<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@page isErrorPage="true" %>
<html>
<head>
    <title>Sorry something went wrong !</title>
    <!--css for web-->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css"
          integrity="sha384-xOolHFLEh07PJGoPkLv1IbcEPTNtaed2xpHsD9ESMhqIYd0nLMwNLD69Npy4HI+N"
          crossorigin="anonymous">
    <link rel="stylesheet" href="css/styles.css" type="text/css">
    <%-- Icons import--%>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">

</head>
<body>
<div class="container error-container">
    <img src="images/warning.png" class="img-fluid error-image">
    <h3 class="error-message">Sorry, something went wrong!</h3>
    <%= exception %>
    <br>
    <a href="index.jsp" class="btn btn-lg text-white custom-home-btn">Home</a>
</div>
</body>
</html>
