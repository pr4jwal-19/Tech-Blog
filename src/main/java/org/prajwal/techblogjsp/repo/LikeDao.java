package org.prajwal.techblogjsp.repo;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class LikeDao {

    Connection con;

    public LikeDao(Connection con) {
        this.con = con;
    }

    public boolean insertLike(int postId, int userId){

        boolean flag = false;

        try {

            String query = "insert into likes(postId, userId) values(?,?)";

            PreparedStatement ps = this.con.prepareStatement(query);

            ps.setInt(1, postId);
            ps.setInt(2, userId);

            ps.executeUpdate();

            flag = true;

        }catch (Exception e) {
            e.printStackTrace();
        }
        return flag;
    }

    public int countLikesOnPost(int postId){

        int count = 0;

        try {

            // select rows -> count(*) all rows
            // where column postId = ?
            String query = "select count(*) from likes where postId=?";

            PreparedStatement ps = this.con.prepareStatement(query);

            ps.setInt(1, postId);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {

                count = rs.getInt(1);

            }

        }catch (Exception e) {
            e.printStackTrace();
        }

        return count;

    }

    public boolean isLikedByUser(int userId, int postId){
        boolean isLike = false;

        try {

            String query = "select * from likes where postId=? and userId=?";

            PreparedStatement ps = this.con.prepareStatement(query);

            ps.setInt(1, postId);
            ps.setInt(2, userId);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {

                isLike = true;

            }

        }catch (Exception e) {
            e.printStackTrace();
        }

        return isLike;
    }

    public boolean deleteLike(int postId, int userId){

        boolean dislike = false;

        try {

            String query = "delete from likes where postId=? and userId=?";

            PreparedStatement ps = this.con.prepareStatement(query);

            ps.setInt(1, postId);
            ps.setInt(2, userId);

            ps.executeUpdate();

            dislike = true;

        }catch (Exception e) {
            e.printStackTrace();
        }

        return dislike;

    }
}
