package ee.ut.intime.service;

import java.util.List;

import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import ee.ut.intime.domain.AppUser;

@Service
public class AppUserService implements UserDetailsService {

	
	@Transactional (readOnly=true, propagation=Propagation.REQUIRES_NEW)
	@Override
	public UserDetails loadUserByUsername(String username)
			throws UsernameNotFoundException {
		
		List<AppUser> l = AppUser.findAppUsersByUsername(username).getResultList();
		if (l.size() == 0) throw new UsernameNotFoundException("User not found");
		return l.get(0);
	}

	
	
}
