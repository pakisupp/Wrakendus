package ee.ut.intime.web;
import java.util.Date;

import ee.ut.intime.domain.AppUser;
import ee.ut.intime.domain.Subject;
import ee.ut.intime.domain.UsedTime;
import ee.ut.intime.service.SecurityUtils;

import javax.persistence.TypedQuery;
import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;

import org.springframework.roo.addon.web.mvc.controller.scaffold.RooWebScaffold;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

@RequestMapping("/usedtimes")
@Controller
@RooWebScaffold(path = "usedtimes", formBackingObject = UsedTime.class)
public class UsedTimeController {
	
	
	//Pushed this aspect in to add logged in user as the time owner
	@RequestMapping(params = "form", produces = "text/html")
    public String createForm(Model uiModel) {
		UsedTime usedTime = new UsedTime();
		AppUser owner = AppUser.findAppUser(SecurityUtils.getLoggedInUser().getId()); //need to refresh hibernate binding
		usedTime.setOwner(owner);
		usedTime.setHours(0);
		usedTime.setWorkDate(new Date());
        populateEditForm(uiModel, usedTime);
        return "usedtimes/create";
    }

	void populateEditForm(Model uiModel, UsedTime usedTime) {
        uiModel.addAttribute("usedTime", usedTime);
        addDateTimeFormatPatterns(uiModel);
        uiModel.addAttribute("appusers", AppUser.findAllAppUsers());
        if (SecurityUtils.getLoggedInUser().isAdmin()) {
        	uiModel.addAttribute("subjects", Subject.findAllSubjects());
        } else {        	
        	uiModel.addAttribute("subjects", Subject.findSubjectsByOwner(SecurityUtils.getLoggedInUser()).getResultList());
        }
    }

	@RequestMapping(method = RequestMethod.PUT, produces = "text/html")
    public String update(@Valid UsedTime usedTime, BindingResult bindingResult, Model uiModel, HttpServletRequest httpServletRequest) {
        if (bindingResult.hasErrors()) {
            populateEditForm(uiModel, usedTime);
            return "usedtimes/update";
        }
        uiModel.asMap().clear();
        if (!SecurityUtils.getLoggedInUser().isAdmin()) {
        	usedTime.setOwner(SecurityUtils.getLoggedInUser());
        }
        usedTime.merge();
        return "redirect:/usedtimes/" + encodeUrlPathSegment(usedTime.getId().toString(), httpServletRequest);
    }

	@RequestMapping(produces = "text/html")
    public String list(@RequestParam(value = "page", required = false) Integer page, @RequestParam(value = "size", required = false) Integer size, Model uiModel) {
		TypedQuery<UsedTime> q = UsedTime.findUsedTimesByOwner(SecurityUtils.getLoggedInUser());
		if (page != null || size != null) {
            int sizeNo = size == null ? 10 : size.intValue();
            final int firstResult = page == null ? 0 : (page.intValue() - 1) * sizeNo;
            uiModel.addAttribute("usedtimes", q.setFirstResult(firstResult).setMaxResults(sizeNo).getResultList());
            float nrOfPages = (float) UsedTime.countUsedTimes() / sizeNo;
            uiModel.addAttribute("maxPages", (int) ((nrOfPages > (int) nrOfPages || nrOfPages == 0.0) ? nrOfPages + 1 : nrOfPages));
        } else {
            uiModel.addAttribute("usedtimes", q.getResultList());
        }
        addDateTimeFormatPatterns(uiModel);
        return "usedtimes/list";
    }

	@RequestMapping(method = RequestMethod.POST, produces = "text/html")
    public String create(@Valid UsedTime usedTime, BindingResult bindingResult, Model uiModel, HttpServletRequest httpServletRequest) {
        if (bindingResult.hasErrors()) {
            populateEditForm(uiModel, usedTime);
            return "usedtimes/create";
        }
        uiModel.asMap().clear();
        if (!SecurityUtils.getLoggedInUser().isAdmin()) {
        	usedTime.setOwner(SecurityUtils.getLoggedInUser());
        }
        usedTime.persist();
        return "redirect:/usedtimes/" + encodeUrlPathSegment(usedTime.getId().toString(), httpServletRequest);
    }
}
