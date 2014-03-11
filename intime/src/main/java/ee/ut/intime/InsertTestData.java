package ee.ut.intime;

import org.springframework.beans.factory.annotation.Configurable;
import org.springframework.context.ApplicationListener;
import org.springframework.context.event.ContextRefreshedEvent;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.crypto.password.StandardPasswordEncoder;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import ee.ut.intime.domain.AppUser;

@Service
@Configurable
public class InsertTestData implements ApplicationListener<ContextRefreshedEvent> {

	@Override
	public void onApplicationEvent(ContextRefreshedEvent event) {
		populateDatabaseIfNeeded();
	}
	
	  @Transactional(propagation = Propagation.REQUIRES_NEW)
	    private void populateDatabaseIfNeeded() {
		  	StandardPasswordEncoder spe = new StandardPasswordEncoder();
	        if (!AppUser.findAllAppUsers().isEmpty()) {
	            // don't do anything if there is data in the db
	            return;
	        }
	        
	        AppUser user = new AppUser();
	        user.setUsername("user");
	        user.setFullName("John Q Public");
	        user.setPassword("user");
	        user.persist();
	        
	        user = new AppUser();
	        user.setUsername("admin");
	        user.setFullName("Admin");
	        user.setPassword("admin");
	        user.persist();
	  }

	

	
	
}
