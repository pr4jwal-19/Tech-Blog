<%@ page import="org.prajwal.techblogjsp.repo.PostDao" %>
<%@ page import="org.prajwal.techblogjsp.utility.ConnectionProvider" %>
<%@ page import="java.util.List" %>
<%@ page import="org.prajwal.techblogjsp.entities.Post" %>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="org.prajwal.techblogjsp.repo.UserDao" %>
<%@ page import="java.text.DateFormat" %>
<%@ page import="org.prajwal.techblogjsp.entities.User" %>
<%@ page import="org.prajwal.techblogjsp.repo.LikeDao" %>

<%
    User user = (User) session.getAttribute("currentUser");
    if (user == null) {
        // error
        response.sendRedirect("login.jsp");
    }
    assert user != null;

%>

<div class="row">
<%--Fetching all the posts from dB --%>
<%

    // hide this code when u host the website somewhere
    try {
        Thread.sleep(500);
    } catch (InterruptedException e) {
        throw new RuntimeException(e);
    }

    /* to access the method of getting all the posts */
    PostDao dao = new PostDao(ConnectionProvider.getConnection());

    int cid = Integer.parseInt(request.getParameter("cid"));

    List<Post> postList = null;
    if (cid==0){
        postList = dao.getAllPosts();
    } else {
        postList = dao.getPostsByCategory(cid);
    }

    PrintWriter out1 = response.getWriter();
    if (postList.isEmpty()){
        out1.println("<h3 class='display-5 text-center'>No Posts available for this Category </h3>");
        return;
    }

    for (Post post : postList) {
%>

<div class="col-md-6 mt-3">

    <div class="card post-card mb-4">
        <img src="postPics/<%= post.getPostPicName() %>" class="card-img-top" alt="">
        <div class="card-body post-card-body">
            <h5 class="card-title"><%= post.getPostTitle() %></h5>
            <p class="card-text"><%= post.getPostContent().length() > 150 ? post.getPostContent().substring(0,150)+"..." : post.getPostContent() %></p>
        </div>
        <%
            LikeDao likeDao = new LikeDao(ConnectionProvider.getConnection());
        %>
        <div class="card-footer" style="background-color: white">
            <a href="#" class="btn btn-custom btn-read-more btn-sm" data-toggle="modal" data-target="#postModal<%= post.getPostId() %>">Read More</a>
            <a href="#" class="btn btn-custom btn-like btn-sm" onclick="doLike(<%= post.getPostId() %>,<%= user.getId() %>, this)"><i class="fa fa-thumbs-o-up"><span class="like-counter"> <%= likeDao.countLikesOnPost(post.getPostId())%></span></i></a>
            <a href="#" class="btn btn-custom btn-like btn-sm"><i class="fa fa-commenting-o"><span> 30</span></i></a>
        </div>
    </div>

</div>
    <!-- Modal for post details -->
    <div class="modal fade" id="postModal<%= post.getPostId() %>" tabindex="-1" role="dialog" aria-labelledby="postModalLabel<%= post.getPostId() %>" aria-hidden="true">
        <div class="modal-dialog modal-lg" role="document">
            <div class="modal-content">
                <div class="modal-header" style="background-color: #bbdefb ; margin-bottom: 15px;">
                    <h5 class="modal-title" style="" id="postModalLabel<%= post.getPostId() %>">| TechBlog | <%= post.getPostTitle() %></h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <img src="postPics/<%= post.getPostPicName() %>" class="card-img-top" alt="" style="max-height: 100%; object-fit: contain">
                <div class="row my-3 mx-2" style="border: 1px solid #e2e2e2">
                    <%
                        UserDao userDao = new UserDao(ConnectionProvider.getConnection());
                    %>
                    <div class="col-md-8" style="contain: content; background-color: aliceblue">
                        <p style="margin: 10px 0;"> | <a href="#!">@<%= userDao.getUserByUserId(post.getUserId()).getUserName()%> </a> posted ... |</p>
                    </div>
                    <div class="col-md-4" style="contain: content; background-color: aliceblue">
                        <p style="margin: 10px 0; font-style: italic; font-weight: bold"> <%= DateFormat.getDateTimeInstance().format(post.getPostDate()) %></p>
                    </div>
                </div>
                <div class="modal-body">
                    <p><%= post.getPostContent() %></p>
                    <pre class="code-block"><%= post.getPostCode() %></pre>
                    <p>Author: <%= post.getUserId() %></p>
                </div>
                <div class="modal-footer post-card-footer">
                    <a href="#" class="btn btn-custom btn-like btn-sm" onclick="doLike(<%= post.getPostId() %>,<%= user.getId() %>, this)"><i class="fa fa-thumbs-o-up"><span class="like-counter"> <%= likeDao.countLikesOnPost(post.getPostId()) %></span></i></a>
                    <a href="#" class="btn btn-custom btn-like btn-sm"><i class="fa fa-commenting-o"><span> 30</span></i></a>
                </div>
            </div>
        </div>
    </div>
<%
    }
%>


</div>

<script src="<%= request.getContextPath() %>/js/app.js"></script>
