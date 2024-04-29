package org.prajwal.techblogjsp.servlets;

import org.prajwal.techblogjsp.entities.User;
import org.prajwal.techblogjsp.repo.UserDao;
import org.prajwal.techblogjsp.utility.ConnectionProvider;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;

@WebServlet("/register")
@MultipartConfig
public class RegisterServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        PrintWriter out = response.getWriter();
        String checkBox = request.getParameter("agreement");
        boolean agreement = (checkBox != null && checkBox.equals("on"));
        if(!agreement){
            out.println("Please check the terms and conditions");
        }
        else {
            String username=request.getParameter("user_name");
            String email=request.getParameter("user_email");
            String password=request.getParameter("user_password");
            String gender=request.getParameter("gender");
            String about=request.getParameter("about");

            // create user obj and set it fields
            User user = new User(username,email,password,gender,about,agreement);

            //create a user dao obj
            UserDao dao = new UserDao(ConnectionProvider.getConnection());

            //save it in db
            if (dao.saveUser(user)){
                // Registration successful
                response.setContentType("text/plain");
                response.getWriter().write("done");
            }else {
                // Registration failed
                response.setContentType("text/plain");
                response.getWriter().write("Failed to register user. Please try again.");
            }
        }

    }
}
