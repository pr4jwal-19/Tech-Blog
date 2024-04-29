package org.prajwal.techblogjsp.servlets;

import org.prajwal.techblogjsp.repo.LikeDao;
import org.prajwal.techblogjsp.utility.ConnectionProvider;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;

@MultipartConfig
@WebServlet("/like")
public class LikeServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        String operation = request.getParameter("operation");

        int userId = Integer.parseInt(request.getParameter("uId"));

        int postId = Integer.parseInt(request.getParameter("pId"));

        PrintWriter out = response.getWriter();

        LikeDao likeDao = new LikeDao(ConnectionProvider.getConnection());

        if (operation.equals("like")) {

            boolean likeStatus = likeDao.insertLike(postId,userId);

            if (likeStatus) {
                out.println("true");
            }
        }


    }

}
