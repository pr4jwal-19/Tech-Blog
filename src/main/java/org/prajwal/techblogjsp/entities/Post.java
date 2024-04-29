package org.prajwal.techblogjsp.entities;

import java.sql.Timestamp;

public class Post {
    private int postId;
    private String postTitle;
    private String postContent;
    private String postCode;
    private String postPicName;
    private Timestamp postDate;
    private int categoryId;
    private int userId;

    public Post() {
    }

    public Post(String postTitle, String postContent, String postCode, String postPicName, int categoryId, int userId) {
        this.postTitle = postTitle;
        this.postContent = postContent;
        this.postCode = postCode;
        this.postPicName = postPicName;
        this.categoryId = categoryId;
        this.userId = userId;
    }

    public Post(int postId, String postTitle, String postContent, String postCode, String postPicName, Timestamp postDate, int categoryId, int userId) {
        this.postId = postId;
        this.postTitle = postTitle;
        this.postContent = postContent;
        this.postCode = postCode;
        this.postPicName = postPicName;
        this.postDate = postDate;
        this.categoryId = categoryId;
        this.userId = userId;
    }

    public int getPostId() {
        return postId;
    }

    public void setPostId(int postId) {
        this.postId = postId;
    }

    public String getPostTitle() {
        return postTitle;
    }

    public void setPostTitle(String postTitle) {
        this.postTitle = postTitle;
    }

    public String getPostContent() {
        return postContent;
    }

    public void setPostContent(String postContent) {
        this.postContent = postContent;
    }

    public String getPostCode() {
        return postCode;
    }

    public void setPostCode(String postCode) {
        this.postCode = postCode;
    }

    public String getPostPicName() {
        return postPicName;
    }

    public void setPostPicName(String postPicName) {
        this.postPicName = postPicName;
    }

    public Timestamp getPostDate() {
        return postDate;
    }

    public void setPostDate(Timestamp postDate) {
        this.postDate = postDate;
    }

    public int getCategoryId() {
        return categoryId;
    }

    public void setCategoryId(int categoryId) {
        this.categoryId = categoryId;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }
}
