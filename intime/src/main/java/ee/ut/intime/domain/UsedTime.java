package ee.ut.intime.domain;
import org.springframework.roo.addon.javabean.RooJavaBean;
import org.springframework.roo.addon.jpa.activerecord.RooJpaActiveRecord;
import org.springframework.roo.addon.tostring.RooToString;

import java.util.Date;

import javax.persistence.EntityManager;
import javax.persistence.Query;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.persistence.TypedQuery;

import org.springframework.format.annotation.DateTimeFormat;

import javax.persistence.ManyToOne;

import org.springframework.roo.addon.web.mvc.controller.json.RooWebJson;

@RooJavaBean
@RooToString
@RooWebJson(jsonObject = UsedTime.class)
@RooJpaActiveRecord(finders = { "findUsedTimesByOwner", "findUsedTimesBySubject" })
public class UsedTime {

    /**
     */
    @Temporal(TemporalType.TIMESTAMP)
    @DateTimeFormat(style = "M-")
    private Date workDate;

    /**
     */
    private int hours;

    /**
     */
    @ManyToOne
    private Subject subject;

    /**
     */
    @ManyToOne
    private AppUser owner;
    
    public static Query findUsedTimesBySubjectSortAndGroupByDate(Subject subject) {
        if (subject == null) throw new IllegalArgumentException("The subject argument is required");
        EntityManager em = UsedTime.entityManager();
        String jpaQuery = "SELECT o.workDate AS date, SUM(o.hours) FROM UsedTime AS o "
        		+ "WHERE o.subject = :subject GROUP BY o.workDate ORDER BY o.workDate";
        
        Query q = em.createQuery(jpaQuery);
        q.setParameter("subject", subject);
        return q;
    }
    
}
