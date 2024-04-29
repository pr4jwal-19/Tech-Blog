package org.prajwal.techblogjsp.utility;

import java.sql.Connection;
import java.sql.DriverManager;

public class ConnectionProvider {

    private static Connection con;

    public static Connection getConnection() {
        try{
            if (con==null){
                // load Driver class
                Class.forName("com.mysql.cj.jdbc.Driver");
                // create connection
                con = DriverManager.getConnection
                        ("jdbc:mysql://localhost:3306/prajwalstechblog",
                                "root",
                                "lkjhgfdsa");

            }
        } catch (Exception e){
            e.printStackTrace();
        }
        return con;
    }
}
