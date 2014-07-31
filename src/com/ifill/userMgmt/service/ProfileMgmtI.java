package com.ifill.userMgmt.service;

import javax.servlet.http.HttpSession;

import com.ifill.userMgmt.vo.User;

public interface ProfileMgmtI {

	boolean isUserLoggedIn(HttpSession session);
	String findUserById(User user);
	String createUser(User user);
	String createUserCreds(User user);
}
