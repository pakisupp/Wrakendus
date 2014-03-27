package ee.ut.intime.web;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@RequestMapping("/usedtimes/utgraph/**")
@Controller
public class UsedTimesGraphController {
	
//	@PersistenceContext
//    transient EntityManager UsedTime.entityManager;

    @RequestMapping(method = RequestMethod.POST, value = "{id}")
    public void post(@PathVariable Long id, ModelMap modelMap, HttpServletRequest request, HttpServletResponse response) {
    }
    
    @RequestMapping(method = RequestMethod.GET, value = "index")
    public String get(ModelMap modelMap, HttpServletRequest request, HttpServletResponse response) {
    	modelMap.addAttribute("test", "testValue");
    	System.out.println("misiganes");
		return "usedtimes/utgraph/index";
    }

    @RequestMapping
    public String index() {
        return "usedtimes/utgraph/index";
    }
}
