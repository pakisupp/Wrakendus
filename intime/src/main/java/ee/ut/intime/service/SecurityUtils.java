package ee.ut.intime.service;

import org.springframework.security.core.context.SecurityContextHolder;

import ee.ut.intime.domain.AppUser;

public class SecurityUtils {
	
	public static AppUser getLoggedInUser() {
		return (AppUser) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
	}

}
