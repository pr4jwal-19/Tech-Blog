package org.prajwal.techblogjsp.servlets;

import org.prajwal.techblogjsp.entities.Message;
import org.prajwal.techblogjsp.entities.Post;
import org.prajwal.techblogjsp.entities.User;
import org.prajwal.techblogjsp.repo.PostDao;
import org.prajwal.techblogjsp.utility.ConnectionProvider;
import org.prajwal.techblogjsp.utility.FileUpdater;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;

@MultipartConfig
@WebServlet("/addPost")
public class AddPostServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        // category id -> category
        int cId = Integer.parseInt(request.getParameter("category"));
        // post title
        String postTitle = request.getParameter("postTitle");
        // post content
        String postContent = request.getParameter("postContent");
        // post code
        String postCode = request.getParameter("postCode");
        // file part of img selected
        Part filePart = request.getPart("uploadPhotos");
        // file name
        String fileName = filePart.getSubmittedFileName();

        // getting the user from the session
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("currentUser");

        int userId = user.getId();

        PrintWriter out = response.getWriter();

        Post post = new Post(postTitle,postContent,postCode,fileName,cId,userId);

        // save the post in dB or publish in dB
        PostDao dao = new PostDao(ConnectionProvider.getConnection());

        if (dao.savePost(post)){

            String path = request.getServletContext().getRealPath("/")+"postPics"+File.separator+fileName;

            FileUpdater.saveFile(filePart.getInputStream(),path);

            out.println("done");

        } else {
            out.println("failed");
        }


    }
}
