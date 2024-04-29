package org.prajwal.techblogjsp.repo;

import org.prajwal.techblogjsp.entities.User;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Timestamp;

public class UserDao {

    private Connection con;

    public UserDao(Connection con) {
        this.con = con;
    }

    //method to insert data to db
    public boolean saveUser(User user) {
        boolean check = false;
        try {
            // persist user to db
            String query = "insert into users(Username,Email,Password,Gender,About,Updates) values(?,?,?,?,?,?)";

            PreparedStatement ps = this.con.prepareStatement(query);
            ps.setString(1,user.getUserName());
            ps.setString(2,user.getEmail());
            ps.setString(3,user.getPassword());
            ps.setString(4,user.getGender());
            ps.setString(5,user.getAbout());
            ps.setBoolean(6, user.isGiveUpdates());

            ps.executeUpdate();

            check = true;

        }catch (Exception e) {
            e.printStackTrace();
        }
        return check;
    }

    // method to get user by email and password
    public User findUserByEmailAndPassword(String userEmail,String password) {
        User user = null;
        try {
            // query to get User by email and password
            String query = "select * from users where Email=? and Password=?";
            PreparedStatement ps = this.con.prepareStatement(query);
            ps.setString(1,userEmail);
            ps.setString(2,password);

            ResultSet rs = ps.executeQuery();

            if(rs.next()) {
                user = new User();
                user.setId(rs.getInt("UserID"));
                user.setUserName(rs.getString("Username"));
                user.setEmail(rs.getString("Email"));
                user.setPassword(rs.getString("Password"));
                user.setGender(rs.getString("Gender"));
                user.setAbout(rs.getString("About"));
                user.setRegistrationDate(rs.getTimestamp("RegDate"));
                user.setProfilePic(rs.getString("Profile"));
                user.setGiveUpdates(rs.getBoolean("Updates"));


            }
        } catch (Exception e){
            e.printStackTrace();
        }
        return user;
    }

    public boolean updateUser(User user) {
        boolean check = false;
        try {
            String query = "update users set Username = ? , Email = ? , Password = ? , About = ? , Profile = ? where UserID = ?";
            PreparedStatement ps = this.con.prepareStatement(query);
            ps.setString(1,user.getUserName());
            ps.setString(2,user.getEmail());
            ps.setString(3,user.getPassword());
            ps.setString(4,user.getAbout());
            ps.setString(5,user.getProfilePic());
            ps.setInt(6,user.getId());

            ps.executeUpdate();

            check = true;

        }catch (Exception e){
            e.printStackTrace();
        }
        return check;
    }

    public User getUserByUserId(int userId) {

        User user = null;

        try {

            String query = "select * from users where UserID = ?";

            PreparedStatement ps = this.con.prepareStatement(query);

            ps.setInt(1,userId);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {

                int userID = rs.getInt("UserID");
                String userName = rs.getString("Username");
                String email = rs.getString("Email");
                String password = rs.getString("Password");
                String gender = rs.getString("Gender");
                String about = rs.getString("About");
                Timestamp regDate = rs.getTimestamp("RegDate");
                String profilePic = rs.getString("Profile");

                user = new User(userID,userName,email,password,gender,about,regDate,profilePic);

            }

        } catch (Exception e){
            e.printStackTrace();
        }

        return user;

    }
}
