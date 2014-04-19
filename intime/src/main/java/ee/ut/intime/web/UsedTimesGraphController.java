package ee.ut.intime.web;
import java.util.LinkedList;
import java.util.List;

import javax.persistence.TypedQuery;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import ee.ut.intime.domain.Subject;
import ee.ut.intime.domain.UsedTime;
import ee.ut.intime.web.jsonmodel.GraphPoint;

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
    	modelMap.addAttribute("test", "Statistika");
//    	System.out.println("misiganes");
		return "usedtimes/utgraph/index";
    }

    @RequestMapping
    public String index() {
        return "usedtimes/utgraph/index";
    }
    
	@RequestMapping(value="all", headers ={"Accept=application/json"}, method = RequestMethod.GET)
	public @ResponseBody List getPoints(){
		
		List graphPoints = new LinkedList<GraphPoint>();
		List <Subject> subjects = Subject.findAllSubjects();
		
		for(Subject subject : subjects){
			
			List data = new LinkedList<List>();
			TypedQuery<UsedTime> timesBySubject = UsedTime.findUsedTimesBySubject(subject, "workDate", "ASC");
						
			for(UsedTime usedTime : timesBySubject.getResultList()){
				List point = new LinkedList();
				point.add(usedTime.getWorkDate().getTime());
				point.add(usedTime.getHours());
				data.add(point);
			}
			
			GraphPoint ret = new GraphPoint();
			ret.setLabel(subject.getName());
			ret.setData(data);
			
			graphPoints.add(ret);
		}
		
		return graphPoints;
	}
    
}
