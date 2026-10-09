package com.jayasri.jayasrimart.service;

import com.jayasri.jayasrimart.model.User;

public interface UserService {
    boolean registerUser(User user);
    User loginUser(String email, String password);
    boolean isEmailRegistered(String email);
}