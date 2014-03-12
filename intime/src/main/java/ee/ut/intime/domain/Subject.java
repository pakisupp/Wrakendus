package ee.ut.intime.domain;
import org.springframework.roo.addon.javabean.RooJavaBean;
import org.springframework.roo.addon.jpa.activerecord.RooJpaActiveRecord;
import org.springframework.roo.addon.tostring.RooToString;
import javax.validation.constraints.Size;
import javax.persistence.ManyToOne;

@RooJavaBean
@RooToString
@RooJpaActiveRecord(finders = { "findSubjectsByOwner" })
public class Subject {

    /**
     */
    @Size(max = 20)
    private String code;

    /**
     */
    @Size(min = 3, max = 128)
    private String name;

    /**
     */
    @ManyToOne
    private AppUser owner;
}
