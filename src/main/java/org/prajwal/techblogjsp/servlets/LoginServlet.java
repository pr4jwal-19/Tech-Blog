package org.prajwal.techblogjsp.servlets;

import org.prajwal.techblogjsp.entities.Message;
import org.prajwal.techblogjsp.entities.User;
import org.prajwal.techblogjsp.repo.UserDao;
import org.prajwal.techblogjsp.utility.ConnectionProvider;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/login")
@MultipartConfig
public class LoginServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        String userEmail = request.getParameter("userEmail");
        String userPassword = request.getParameter("userPassword");

        UserDao dao = new UserDao(ConnectionProvider.getConnection());

        User user = dao.findUserByEmailAndPassword(userEmail,userPassword);

        if (user == null) {
            //login error
            // error message
            Message message = new Message("Invalid Details ! Try again !","error","alert-danger");

            // passing message into session
            HttpSession session = request.getSession();
            session.setAttribute("errorMessage", message);

            //sending back to login.jsp
            response.sendRedirect("login.jsp");

        }else {
            // login success
            HttpSession session = request.getSession();
            session.setAttribute("currentUser", user);
            response.sendRedirect("profile.jsp");
        }
    }

}
