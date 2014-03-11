package ee.ut.intime.web;
import ee.ut.intime.domain.AppUser;
import ee.ut.intime.domain.UsedTime;

import org.springframework.roo.addon.web.mvc.controller.scaffold.RooWebScaffold;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

@RequestMapping("/usedtimes")
@Controller
@RooWebScaffold(path = "usedtimes", formBackingObject = UsedTime.class)
public class UsedTimeController {
	
	
	//Pushed this aspect in to add logged in user as the time owner
	@RequestMapping(params = "form", produces = "text/html")
    public String createForm(Model uiModel) {
		UsedTime usedTime = new UsedTime();
		AppUser owner = AppUser.findAppUsersByUsername(
				SecurityContextHolder.getContext().getAuthentication().getName()).getSingleResult();
		usedTime.setOwner(owner);
        populateEditForm(uiModel, new UsedTime());
        return "usedtimes/create";
    }
}
