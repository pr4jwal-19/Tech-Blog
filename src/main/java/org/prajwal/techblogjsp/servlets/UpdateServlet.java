package org.prajwal.techblogjsp.servlets;

import org.prajwal.techblogjsp.entities.Message;
import org.prajwal.techblogjsp.entities.User;
import org.prajwal.techblogjsp.repo.UserDao;
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
@WebServlet("/update")
public class UpdateServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        // fetch all data
        String userName = request.getParameter("user_name");
        String userEmail = request.getParameter("user_email");
        String userPassword = request.getParameter("user_password");
        String userAbout = request.getParameter("user_about");
        Part profileFile = request.getPart("user_image");
        // image name with extension
        String imageFileName = profileFile.getSubmittedFileName();

        //get the user from the session
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("currentUser");
        user.setUserName(userName);
        user.setEmail(userEmail);
        user.setPassword(userPassword);
        user.setAbout(userAbout);

        // old file path
        String oldPicPath = user.getProfilePic();

        // new path set for pp
        user.setProfilePic(imageFileName);

        // update this updated user into the database
        UserDao dao = new UserDao(ConnectionProvider.getConnection());

        if (dao.updateUser(user)){
            // dir for old profile pic path
            String oldPath = request.getServletContext().getRealPath("/")+"profilePics"+ File.separator+oldPicPath;
            // deleting the old pic
            if (!oldPicPath.equals("default.png")){
                FileUpdater.deleteFile(oldPath);
            }

            String newPath = request.getServletContext().getRealPath("/")+"profilePics"+ File.separator+user.getProfilePic();

            if (FileUpdater.saveFile(profileFile.getInputStream(),newPath)){
                Message message = new Message("Profile details Updated Successfully !","success","alert-success");
                session.setAttribute("ppSavedMessage", message);

            }else {
                Message message = new Message("Profile details Update Failed!","error","alert-danger");
                session.setAttribute("ppSavedMessage", message);
            }

        }else {
            Message message = new Message("Profile details Update Failed!","error","alert-danger");
            session.setAttribute("ppSavedMessage", message);
        }
        //sending back to login.jsp
        response.sendRedirect("profile.jsp");

    }

}
