package org.prajwal.techblogjsp.repo;

import org.prajwal.techblogjsp.entities.Category;
import org.prajwal.techblogjsp.entities.Post;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class PostDao {

    Connection con;

    public PostDao(Connection con) {
        this.con = con;
    }

    // gets all the categories from the dB
    public ArrayList<Category> getAllCategories() {

        ArrayList<Category> listOfCategories = new ArrayList<>();

        try {

            String query = "select * from categories";

            Statement stmt = this.con.createStatement();

            ResultSet rs = stmt.executeQuery(query);

            while (rs.next()){
                int id = rs.getInt("catId");
                String catName = rs.getString("categoryName");
                String catDescription = rs.getString("categoryDesc");
                Category category = new Category(id, catName, catDescription);
                listOfCategories.add(category);
            }

        }catch (Exception e) {
            e.printStackTrace();
        }

        return listOfCategories;

    }

    // saves a post into the dB
    public boolean savePost(Post post) {
        boolean flag = false;

        try {
            // query to insert
            String query = "insert into posts(postTitle,postContent,postCode,postPic,catId,userId) values(?,?,?,?,?,?)";
            // dynamically populate the query
            PreparedStatement stmt = this.con.prepareStatement(query);

            stmt.setString(1, post.getPostTitle());
            stmt.setString(2, post.getPostContent());
            stmt.setString(3, post.getPostCode());
            stmt.setString(4, post.getPostPicName());
            stmt.setInt(5, post.getCategoryId());
            stmt.setInt(6,post.getUserId());

            stmt.executeUpdate();
            flag = true;

        }catch (Exception e) {
            e.printStackTrace();
        }
        return flag;
    }

    // fetches the list of posts from the dB
    public List<Post> getAllPosts() {

        List<Post> listOfPosts = new ArrayList<>();

        try {

            String query = "select * from posts order by postDate";

            PreparedStatement stmt = this.con.prepareStatement(query);

            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {

                int postId = rs.getInt("postId");
                String postTitle = rs.getString("postTitle");
                String postContent = rs.getString("postContent");
                String postCode = rs.getString("postCode");
                String postPicName = rs.getString("postPic");
                Timestamp postDate = rs.getTimestamp("postDate");
                int catId = rs.getInt("catId");
                int userId = rs.getInt("userId");

                Post post = new Post(postId,postTitle,postContent,postCode,postPicName,postDate,catId,userId);

                listOfPosts.add(post);

            }

        } catch (Exception e){
            e.printStackTrace();
        }

        return listOfPosts;
    }

    // fetches all the posts by category id
    public List<Post> getPostsByCategory(int catId) {

        List<Post> listOfPosts = new ArrayList<>();

        try {

            String query = "select * from posts where catId=?";

            PreparedStatement stmt = this.con.prepareStatement(query);

            stmt.setInt(1, catId);

            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {

                int postId = rs.getInt("postId");
                String postTitle = rs.getString("postTitle");
                String postContent = rs.getString("postContent");
                String postCode = rs.getString("postCode");
                String postPicName = rs.getString("postPic");
                Timestamp postDate = rs.getTimestamp("postDate");
                int userId = rs.getInt("userId");

                Post post = new Post(postId,postTitle,postContent,postCode,postPicName,postDate,catId,userId);

                listOfPosts.add(post);

            }

        }  catch (Exception e) {
            e.printStackTrace();
        }

        return listOfPosts;

    }

    public Post getPostsByPostId(int postId) {

        Post post = null;

        try {

            String query = "select * from posts where postId=?";

            PreparedStatement stmt = this.con.prepareStatement(query);

            stmt.setInt(1, postId);

            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {

                int pId = rs.getInt("postId");
                String postTitle = rs.getString("postTitle");
                String postContent = rs.getString("postContent");
                String postCode = rs.getString("postCode");
                String postPicName = rs.getString("postPic");
                Timestamp postDate = rs.getTimestamp("postDate");

                int catId = rs.getInt("catId");
                int userId = rs.getInt("userId");

                post = new Post(pId,postTitle,postContent,postCode,postPicName,postDate,catId,userId);

            }

        }catch (Exception e){
            e.printStackTrace();
        }

        return post;

    }
}
