package ee.ut.intime.web;
import ee.ut.intime.domain.AppUser;
import ee.ut.intime.domain.Subject;
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

@RequestMapping("/subjects")
@Controller
@RooWebScaffold(path = "subjects", formBackingObject = Subject.class)
public class SubjectController {
	

	@RequestMapping(produces = "text/html")
    public String list(@RequestParam(value = "page", required = false) Integer page, @RequestParam(value = "size", required = false) Integer size, Model uiModel) {
        TypedQuery<Subject> q = null;
        if (SecurityUtils.getLoggedInUser().isAdmin()) {
        	q = Subject.findAllSubjectsQuery();
        } else {
        	q = Subject.findSubjectsByOwner(SecurityUtils.getLoggedInUser());        	
        }
		if (page != null || size != null) {
            int sizeNo = size == null ? 10 : size.intValue();
            final int firstResult = page == null ? 0 : (page.intValue() - 1) * sizeNo;
            uiModel.addAttribute("subjects", q.setFirstResult(firstResult).setMaxResults(sizeNo).getResultList());
            float nrOfPages = (float) Subject.countSubjects() / sizeNo;
            uiModel.addAttribute("maxPages", (int) ((nrOfPages > (int) nrOfPages || nrOfPages == 0.0) ? nrOfPages + 1 : nrOfPages));
        } else {
            uiModel.addAttribute("subjects", q.getResultList());
        }
        return "subjects/list";
    }

	@RequestMapping(method = RequestMethod.PUT, produces = "text/html")
    public String update(@Valid Subject subject, BindingResult bindingResult, Model uiModel, HttpServletRequest httpServletRequest) {
        if (bindingResult.hasErrors()) {
            populateEditForm(uiModel, subject);
            return "subjects/update";
        }
        uiModel.asMap().clear();
        if (!SecurityUtils.getLoggedInUser().isAdmin()) {
        	subject.setOwner(SecurityUtils.getLoggedInUser());
        }
        subject.merge();
        return "redirect:/subjects/" + encodeUrlPathSegment(subject.getId().toString(), httpServletRequest);
    }
	


	@RequestMapping(method = RequestMethod.POST, produces = "text/html")
    public String create(@Valid Subject subject, BindingResult bindingResult, Model uiModel, HttpServletRequest httpServletRequest) {
        if (bindingResult.hasErrors()) {
            populateEditForm(uiModel, subject);
            return "subjects/create";
        }
        uiModel.asMap().clear();
        if (!SecurityUtils.getLoggedInUser().isAdmin()) {
        	subject.setOwner(SecurityUtils.getLoggedInUser());
        }
        subject.persist();
        return "redirect:/subjects/" + encodeUrlPathSegment(subject.getId().toString(), httpServletRequest);
    }
}
