package ee.ut.intime;

import org.springframework.security.authentication.DisabledException;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import ee.ut.intime.domain.AppUser;

import java.util.List;

public class OpenIdUserDetailsService implements UserDetailsService {
	
    public UserDetails loadUserByUsername(String openIdIdentifier) {
        List<AppUser> userList =
                AppUser.findAppUsersByOpenIdIdentifier(openIdIdentifier).getResultList();
        AppUser user = userList.size() == 0 ? null : userList.get(0);
        
        if (user == null) {
            throw new UsernameNotFoundException("User not found for OpenID: " + openIdIdentifier);
        } else {
            if (!user .isEnabled()) {
                throw new DisabledException("User is disabled");
            }
            return user;
        }
    }
}