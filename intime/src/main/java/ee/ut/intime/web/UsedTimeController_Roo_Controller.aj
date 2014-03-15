// WARNING: DO NOT EDIT THIS FILE. THIS FILE IS MANAGED BY SPRING ROO.
// You may push code into the target .java compilation unit if you wish to edit any member(s).

package ee.ut.intime.web;

import ee.ut.intime.domain.AppUser;
import ee.ut.intime.domain.Subject;
import ee.ut.intime.domain.UsedTime;
import ee.ut.intime.web.UsedTimeController;
import java.io.UnsupportedEncodingException;
import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;
import org.joda.time.format.DateTimeFormat;
import org.springframework.context.i18n.LocaleContextHolder;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.util.UriUtils;
import org.springframework.web.util.WebUtils;

privileged aspect UsedTimeController_Roo_Controller {
    
    @RequestMapping(method = RequestMethod.POST, produces = "text/html")
    public String UsedTimeController.create(@Valid UsedTime usedTime, BindingResult bindingResult, Model uiModel, HttpServletRequest httpServletRequest) {
        if (bindingResult.hasErrors()) {
            populateEditForm(uiModel, usedTime);
            return "usedtimes/create";
        }
        uiModel.asMap().clear();
        usedTime.persist();
        return "redirect:/usedtimes/" + encodeUrlPathSegment(usedTime.getId().toString(), httpServletRequest);
    }
    
    @RequestMapping(value = "/{id}", produces = "text/html")
    public String UsedTimeController.show(@PathVariable("id") Long id, Model uiModel) {
        addDateTimeFormatPatterns(uiModel);
        uiModel.addAttribute("usedtime", UsedTime.findUsedTime(id));
        uiModel.addAttribute("itemId", id);
        return "usedtimes/show";
    }
    
    @RequestMapping(produces = "text/html")
    public String UsedTimeController.list(@RequestParam(value = "page", required = false) Integer page, @RequestParam(value = "size", required = false) Integer size, @RequestParam(value = "sortFieldName", required = false) String sortFieldName, @RequestParam(value = "sortOrder", required = false) String sortOrder, Model uiModel) {
        if (page != null || size != null) {
            int sizeNo = size == null ? 10 : size.intValue();
            final int firstResult = page == null ? 0 : (page.intValue() - 1) * sizeNo;
            uiModel.addAttribute("usedtimes", UsedTime.findUsedTimeEntries(firstResult, sizeNo, sortFieldName, sortOrder));
            float nrOfPages = (float) UsedTime.countUsedTimes() / sizeNo;
            uiModel.addAttribute("maxPages", (int) ((nrOfPages > (int) nrOfPages || nrOfPages == 0.0) ? nrOfPages + 1 : nrOfPages));
        } else {
            uiModel.addAttribute("usedtimes", UsedTime.findAllUsedTimes(sortFieldName, sortOrder));
        }
        addDateTimeFormatPatterns(uiModel);
        return "usedtimes/list";
    }
    
    @RequestMapping(method = RequestMethod.PUT, produces = "text/html")
    public String UsedTimeController.update(@Valid UsedTime usedTime, BindingResult bindingResult, Model uiModel, HttpServletRequest httpServletRequest) {
        if (bindingResult.hasErrors()) {
            populateEditForm(uiModel, usedTime);
            return "usedtimes/update";
        }
        uiModel.asMap().clear();
        usedTime.merge();
        return "redirect:/usedtimes/" + encodeUrlPathSegment(usedTime.getId().toString(), httpServletRequest);
    }
    
    @RequestMapping(value = "/{id}", params = "form", produces = "text/html")
    public String UsedTimeController.updateForm(@PathVariable("id") Long id, Model uiModel) {
        populateEditForm(uiModel, UsedTime.findUsedTime(id));
        return "usedtimes/update";
    }
    
    @RequestMapping(value = "/{id}", method = RequestMethod.DELETE, produces = "text/html")
    public String UsedTimeController.delete(@PathVariable("id") Long id, @RequestParam(value = "page", required = false) Integer page, @RequestParam(value = "size", required = false) Integer size, Model uiModel) {
        UsedTime usedTime = UsedTime.findUsedTime(id);
        usedTime.remove();
        uiModel.asMap().clear();
        uiModel.addAttribute("page", (page == null) ? "1" : page.toString());
        uiModel.addAttribute("size", (size == null) ? "10" : size.toString());
        return "redirect:/usedtimes";
    }
    
    void UsedTimeController.addDateTimeFormatPatterns(Model uiModel) {
        uiModel.addAttribute("usedTime_workdate_date_format", DateTimeFormat.patternForStyle("M-", LocaleContextHolder.getLocale()));
    }
    
    void UsedTimeController.populateEditForm(Model uiModel, UsedTime usedTime) {
        uiModel.addAttribute("usedTime", usedTime);
        addDateTimeFormatPatterns(uiModel);
        uiModel.addAttribute("appusers", AppUser.findAllAppUsers());
        uiModel.addAttribute("subjects", Subject.findAllSubjects());
    }
    
    String UsedTimeController.encodeUrlPathSegment(String pathSegment, HttpServletRequest httpServletRequest) {
        String enc = httpServletRequest.getCharacterEncoding();
        if (enc == null) {
            enc = WebUtils.DEFAULT_CHARACTER_ENCODING;
        }
        try {
            pathSegment = UriUtils.encodePathSegment(pathSegment, enc);
        } catch (UnsupportedEncodingException uee) {}
        return pathSegment;
    }
    
}