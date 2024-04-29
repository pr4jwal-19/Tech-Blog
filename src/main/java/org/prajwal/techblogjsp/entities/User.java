package org.prajwal.techblogjsp.entities;

import java.sql.*;

public class User {
    private int id;
    private String userName;
    private String email;
    private String password;
    private String gender;
    private Timestamp registrationDate;
    private String about;
    private String profilePic;
    private boolean giveUpdates;

    public User() {}

    public User(int id, String userName, String email, String password, String gender, Timestamp registrationDate, String about, boolean giveUpdates) {
        this.id = id;
        this.userName = userName;
        this.email = email;
        this.password = password;
        this.gender = gender;
        this.registrationDate = registrationDate;
        this.about = about;
        this.giveUpdates = giveUpdates;
    }

    public User(int id, String userName, String email, String password, String gender, String about, Timestamp registrationDate, String profilePic) {
        this.id = id;
        this.userName = userName;
        this.email = email;
        this.password = password;
        this.gender = gender;
        this.about = about;
        this.registrationDate = registrationDate;
        this.profilePic = profilePic;
    }

    public User(String userName, String email, String password, String gender, String about, boolean giveUpdates) {
        this.userName = userName;
        this.email = email;
        this.password = password;
        this.gender = gender;
        this.about = about;
        this.giveUpdates = giveUpdates;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getGender() {
        return gender;
    }

    public void setGender(String gender) {
        this.gender = gender;
    }

    public Timestamp getRegistrationDate() {
        return registrationDate;
    }

    public void setRegistrationDate(Timestamp registrationDate) {
        this.registrationDate = registrationDate;
    }

    public String getAbout() {
        return about;
    }

    public void setAbout(String about) {
        this.about = about;
    }

    public String getProfilePic() {
        return profilePic;
    }

    public void setProfilePic(String profilePic) {
        this.profilePic = profilePic;
    }

    public boolean isGiveUpdates() {
        return giveUpdates;
    }

    public void setGiveUpdates(boolean giveUpdates) {
        this.giveUpdates = giveUpdates;
    }
}
