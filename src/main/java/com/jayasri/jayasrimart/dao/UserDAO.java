package com.jayasri.jayasrimart.dao;

import com.jayasri.jayasrimart.model.User;

public interface UserDAO {
    boolean registerUser(User user);
    User loginUser(String email, String password);
    boolean isEmailRegistered(String email);
}