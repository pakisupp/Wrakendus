package ee.ut.intime.domain;
import java.util.Collection;
import java.util.LinkedList;
import java.util.List;

import javax.persistence.Column;
import javax.persistence.Transient;

import org.springframework.roo.addon.javabean.RooJavaBean;
import org.springframework.roo.addon.jpa.activerecord.RooJpaActiveRecord;
import org.springframework.roo.addon.tostring.RooToString;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

@RooJavaBean
@RooJpaActiveRecord(finders = { "findAppUsersByOpenIdIdentifier", "findAppUsersByUsername" }, table = "appuser")
public class AppUser implements UserDetails {
	@Transient
	private static final GrantedAuthority USER_AUTHORITY = new GrantedAuthority() {
        @Override
        public String getAuthority() {
            return "ROLE_USER";
        }
    };
    @Transient
    private static final GrantedAuthority ADMIN_AUTHORITY = new GrantedAuthority() {
        @Override
        public String getAuthority() {
            return "ROLE_ADMIN";
        }
    };
    /**
     */
    private String username;

    /**
     */
    private String eMail;

    /**
     */
    private String password;

    /**
     */
    @Column(name = "openid_identifier")
    private String openIdIdentifier;

    /**
     */
    private String fullName;

    @Override
    public Collection<? extends GrantedAuthority> getAuthorities() {
        
        List<GrantedAuthority> ret = new LinkedList<GrantedAuthority>();
        ret.add(USER_AUTHORITY);
        if (username.equals("admin")) {
        	ret.add(ADMIN_AUTHORITY);
        }
        return ret;
    }

    @Override
    public String getPassword() {
        return password;
    }

    @Override
    public String getUsername() {
        return username;
    }

    @Override
    public boolean isAccountNonExpired() {
        return true;
    }

    @Override
    public boolean isAccountNonLocked() {
        return true;
    }

    @Override
    public boolean isCredentialsNonExpired() {
        return true;
    }

    @Override
    public boolean isEnabled() {
        return true;
    }
    
    public String toString() {
    	return fullName;
    }
}
