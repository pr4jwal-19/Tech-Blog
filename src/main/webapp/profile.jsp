<%@ page import="org.prajwal.techblogjsp.entities.User" %>
<%@ page import="org.prajwal.techblogjsp.entities.Message" %>
<%@ page import="org.prajwal.techblogjsp.repo.PostDao" %>
<%@ page import="org.prajwal.techblogjsp.utility.ConnectionProvider" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="org.prajwal.techblogjsp.entities.Category" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@page errorPage="errorPage.jsp" %>
<%
    response.setHeader("Cache-Control","no-cache,no-store,must-revalidate"); // http 1.1

    response.setHeader("Pragma", "no-cache"); // http 1.0

    response.setHeader("Expires", "0"); // proxy servers
%>
<%
    User user = (User) session.getAttribute("currentUser");
    if (user == null) {
        // error
        response.sendRedirect("login.jsp");
    }
    assert user != null;

%>

<html>
<head>
    <title>TechBlog: Profile</title>
    <!--css for web-->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css"
          integrity="sha384-xOolHFLEh07PJGoPkLv1IbcEPTNtaed2xpHsD9ESMhqIYd0nLMwNLD69Npy4HI+N"
          crossorigin="anonymous">
    <link rel="stylesheet" href="css/styles.css" type="text/css">
    <%-- Icons import--%>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">


</head>
<body>
    <%-- Navbar starts--%>

    <nav class="navbar navbar-expand-lg navbar-light primary-background">
        <a class="navbar-brand" href="#"><span class="fa fa-code-fork"></span> TechBlog</a>
        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarSupportedContent">
            <ul class="navbar-nav mr-auto">
                <li class="nav-item active">
                    <a class="nav-link" href="index.jsp"><span class="fa fa-home"></span> Home <span class="sr-only">(current)</span></a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="#"><span class="fa fa-newspaper-o"></span> Research</a>
                </li>
                <li class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle" href="#" role="button" data-toggle="dropdown" aria-expanded="false">
                        <span class="fa fa-folder-open"></span> Categories
                    </a>
                    <div class="dropdown-menu">
                        <a class="dropdown-item" href="#">Programming</a>
                        <a class="dropdown-item" href="#">Artificial Intelligence</a>
                        <div class="dropdown-divider"></div>
                        <a class="dropdown-item" href="#">Computer Science</a>
                    </div>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="#"><span class="fa fa-book"></span> Contact</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="#" data-toggle="modal" data-target="#add-post-modal"><span class="fa fa-plus-square-o"></span> Add Post</a>
                </li>

            </ul>

            <ul class="navbar-nav mr-right">
                <li class="nav-item">
                    <a class="nav-link" href="#!" data-toggle="modal" data-target="#profile-modal" type="submit"><span class="fa fa-user-circle-o"></span>  <%= user.getUserName() %></a>
                </li>
                <li class="nav-item">
                    <a href="logout" class="btn btn-primary" type="submit"><span class="fa fa-user-times"></span> Logout</a>
                </li>

            </ul>
        </div>
    </nav>


    <%-- Navbar ends--%>

    <%
        Message m = (Message) session.getAttribute("ppSavedMessage");
        if (m!=null){
            // error occurred
    %>
    <div class="alert <%= m.getCssClass() %>" role="alert">
        <%= m.getContent() %>
    </div>

    <%
            session.removeAttribute("ppSavedMessage");
        }
    %>

    <%--MAIN BODY of the page starts here--%>
    <main>
        <%--Centered--%>
        <div class="container">

            <div class="row mt-4">
                <%--first column--%>
                <div class="col-md-4">
                <%--List of categories--%>
                    <div class="list-group">
                        <a href="#" onclick="getPosts(0,this)" class=" c-link list-group-item list-group-item-action active" aria-current="true">
                            All Posts
                        </a>
                        <%--Get all categories--%>
                        <%
                            PostDao dao = new PostDao(ConnectionProvider.getConnection());
                            ArrayList<Category> postCategories = dao.getAllCategories();
                            for (Category cat : postCategories) {
                        %>
                        <a href="#" onclick="getPosts(<%= cat.getCategoryId() %>,this)" class="c-link list-group-item list-group-item-action"><%= cat.getCategoryName() %></a>
                        <%
                            }
                        %>

                    </div>

                </div>
                <%--Second column--%>
                <div class="col-md-8">
                    <%--All the Posts according to categories selected--%>

                    <%--post loader--%>
                    <div class="container text-center" id="loader">
                        <i class="fa fa-refresh fa-3x fa-spin" ></i>
                        <p class="mt-4">Loading...</p>
                    </div>
                    <%--post content will be shown here--%>
                    <div class="fluid-container" id="post-container">

                    </div>

                </div>
            </div>

        </div>

    </main>

    <%--MAIN BODY ends here--%>



    <%-- Profile modal starts here--%>

    <!-- Modal -->
    <div class="modal fade" id="profile-modal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header" style="background-color: #007bff; color: white; text-align: center">
                    <h5 class="modal-title" id="userProfile"> TechBlog : Profile </h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <div class="container text-center">
                        <%-- Details --%>
                        <div id="profile-details">
                            <div id="display-profile-pic" style="position:relative; display: inline-block">
                                <img src="profilePics/<%= user.getProfilePic() %>" class="img-fluid" style="border-radius: 50%; max-width: 120px"  alt="">
                            </div>
                            <h5 class="modal-title mt-3 mb-3" id="userNameLabel1"><%= user.getUserName() %></h5>

                            <table class="table table-hover">
                                <tbody>
                                <tr>
                                    <th scope="row">ID : </th>
                                    <td><%= user.getId() %></td>
                                </tr>
                                <tr>
                                    <th scope="row">Email: </th>
                                    <td><%= user.getEmail() %></td>
                                </tr>
                                <tr>
                                    <th scope="row">Gender</th>
                                    <td colspan="2"><%= user.getGender() %></td>
                                </tr>
                                <tr>
                                    <th scope="row">About</th>
                                    <td colspan="2"><%= user.getAbout() %></td>
                                </tr>
                                <tr>
                                    <th scope="row">Registered Date</th>
                                    <td colspan="2"><%= user.getRegistrationDate().toString() %></td>
                                </tr>
                                </tbody>
                            </table>
                        </div>
                        <%--profile-edit--%>
                        <div id="profile-edit" style="display: none">
                            <div id="edit-profile-pic" style="position: relative; display: inline-block">
                                <img src="profilePics/<%= user.getProfilePic() %>" class="img-fluid" style="border-radius: 50%; max-width: 120px" >
                                <button id="editProfilePicBtn" class="btn btn-sm btn-outline-primary" style="position: absolute; bottom: 0; right: 0;">
                                    Edit
                                </button>
                            </div>
                            <h5 class="modal-title mt-3 mb-3" id="userNameLabel2"><%= user.getUserName() %></h5>
                            <p class="mt-2">Edit carefully</p>
                            <form action="update" method="post" enctype="multipart/form-data">
                                <table class="table table-hover">
                                    <tbody>
                                    <tr>
                                        <th scope="row">ID : </th>
                                        <td><%= user.getId() %></td>
                                    </tr>
                                    <tr>
                                        <th scope="row">Username: </th>
                                        <td><input type="text" class="form-control" name="user_name" value="<%= user.getUserName() %>"></td>
                                    </tr>
                                    <tr>
                                        <th scope="row">Email: </th>
                                        <td><input type="email" class="form-control" name="user_email" value="<%= user.getEmail() %>"></td>
                                    </tr>
                                    <tr>
                                        <th scope="row">Password: </th>
                                        <td><input type="password" class="form-control" name="user_password" value="<%= user.getPassword() %>"></td>
                                    </tr>
                                    <tr>
                                        <th scope="row">Gender</th>
                                        <td colspan="2"><%= user.getGender() %></td>
                                    </tr>
                                    <tr>
                                        <th scope="row">About</th>
                                        <td colspan="2">
                                            <textarea rows="3" class="form-control" name="user_about" ><%= user.getAbout() %></textarea>
                                        </td>
                                    </tr>
                                    <tr>
                                        <th scope="row">Registered Date</th>
                                        <td colspan="2"><%= user.getRegistrationDate().toString() %></td>
                                    </tr>
                                    <tr>
                                        <th scope="row">New Profile Pic</th>
                                        <td colspan="2"><input type="file" name="user_image" id="profilePicInput" style="display: inline-block;"></td>
                                    </tr>
                                    </tbody>
                                </table>
                                <div class="container">
                                    <button type="submit" class="btn btn-outline-primary">
                                        Save
                                    </button>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                    <button type="button" id="edit-profile-button" class="btn btn-primary">Edit</button>
                </div>
            </div>
        </div>
    </div>

    <%-- Profile modal ends here--%>

    <%--Post Modal Starts here--%>
    <!-- Modal -->
    <div class="modal fade" id="add-post-modal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-lg"> <!-- Use modal-lg for a larger modal -->
            <div class="modal-content">
                <div class="modal-header bg-primary text-white"> <!-- Use a blue header with white text -->
                    <h5 class="modal-title" id="exampleModalLabel">TechBlog: Add a Post</h5>
                    <button type="button" class="close text-white" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <form id="add-post-form" action="addPost" method="post">
                        <div class="form-group">
                            <label for="categorySelect">Select Category:</label>
                            <select class="form-control" id="categorySelect" name="category">
                                <option selected disabled>----Select Category----</option>
                                <%
                                    PostDao postDao = new PostDao(ConnectionProvider.getConnection());
                                    ArrayList<Category> categories = postDao.getAllCategories();
                                    for (Category category : categories) {

                                %>
                                <option value="<%= category.getCategoryId() %>"><%= category.getCategoryName() %></option>
                                <%
                                    }
                                %>
                            </select>
                        </div>
                        <div class="form-group">
                            <input type="text" class="form-control" id="postTitle" name="postTitle" placeholder="Enter Post Title">
                        </div>
                        <div class="form-group">
                            <textarea class="form-control" id="postContent" name="postContent" style="height: 150px" placeholder="Enter Post Content"></textarea>
                        </div>
                        <div class="form-group">
                            <textarea class="form-control" id="postCode" name="postCode" style="height: 150px" placeholder="Enter the Code/Program (if any)"></textarea>
                        </div>
                        <div class="form-group">
                            <label for="uploadPhotos"><h5>Upload Photos</h5></label>
                            <br>
                            <input type="file" class="form-control-file" id="uploadPhotos" name="uploadPhotos">
                        </div>
                        <div class="modal-footer text-center">
                            <button type="submit" class="btn btn-outline-primary">Post</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>


    <%--Post modal ends here--%>


    <script>
        // Check if the user is not logged in (session has expired or been invalidated)
        if (!<%= session.getAttribute("currentUser") != null %>) {
            // Redirect to login page
            window.location.replace("login.jsp");
        }
    </script>

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

    <%-- External js --%>
    <script src="js/app.js" type="text/javascript"></script>

    <script>
        $(document).ready(function (){

            let editStatus = false;

            $('#edit-profile-button').click(function () {

                if (editStatus==false){
                    $('#profile-details').hide()
                    $('#profile-edit').show();
                    editStatus = true;
                    $(this).text("Back");
                } else {
                    $('#profile-details').show()
                    $('#profile-edit').hide();
                    editStatus = false;
                    $(this).text("Edit");
                }
            })
        })
    </script>

    <script>
        $(document).ready(function() {
            // Trigger file input when edit button is clicked
            $('#editProfilePicBtn').click(function() {
                $('#profilePicInput').trigger('click');
            });

            // Handle file input change event
            $('#profilePicInput').change(function() {
                var selectedFile = $(this).prop('files')[0];

                if (selectedFile) {
                    // Display the filename in a placeholder element
                    $('#selectedFileName').text(selectedFile.name);
                } else {
                    // Clear the placeholder text if no file is selected
                    $('#selectedFileName').text('');
                }});
        });
    </script>

    <%--Add post js--%>
    <script>
        $(document).ready(function (){
            //AJAX asynchronous request
            $('#add-post-form').on('submit',function (event){
                //this code gets called when form is submitted
                event.preventDefault();
                console.log("Post Submitted")
                let form = new FormData(this);
                // now requesting to server
                $.ajax({
                    url: "addPost",
                    type: "POST",
                    data: form,
                    success: function (data,textStatus,jqXHR){
                        //success...
                        console.log("Post Added Successfully !",data);
                        if (data.trim()==="done"){
                            swal("Good job!", "Post Published Successfully!", "success");
                            let allPost = $('.c-link')[0];
                            getPosts(0,allPost);
                        }else {
                            swal("Error!", "Something went wrong!", "error");
                        }
                    },
                    error: function (jqXHR,textStatus,errorThrown){
                        //error...
                        console.log("Error adding post : ",errorThrown);
                        swal("Error!", "Something went wrong!", "error");
                    },
                    processData: false,
                    contentType: false
                });
            });
        });
    </script>

    <%--Loading all the posts using AJAX--%>
    <script>

        function getPosts(catId,temp){
            $('#loader').show();
            $('#post-container').hide();

            $('.c-link').removeClass('active');

            $.ajax({
                url: "loadPosts.jsp",
                data: {cid:catId},
                success: function (data,textStatus,jqXHR){
                    console.log("Loading post content...",data);
                    $('#loader').hide();
                    $('#post-container').show();
                    $('#post-container').html(data);
                    $(temp).addClass('active');
                }
            });
        }
        $(document).ready(function (e){
            let allPostRef = $('.c-link')[0];
            getPosts(0,allPostRef);
        })

    </script>

</body>
</html>
