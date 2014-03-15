// WARNING: DO NOT EDIT THIS FILE. THIS FILE IS MANAGED BY SPRING ROO.
// You may push code into the target .java compilation unit if you wish to edit any member(s).

package ee.ut.intime.domain;

import ee.ut.intime.domain.AppUserDataOnDemand;
import ee.ut.intime.domain.Subject;
import ee.ut.intime.domain.SubjectDataOnDemand;
import java.security.SecureRandom;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.Random;
import javax.validation.ConstraintViolation;
import javax.validation.ConstraintViolationException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

privileged aspect SubjectDataOnDemand_Roo_DataOnDemand {
    
    declare @type: SubjectDataOnDemand: @Component;
    
    private Random SubjectDataOnDemand.rnd = new SecureRandom();
    
    private List<Subject> SubjectDataOnDemand.data;
    
    @Autowired
    AppUserDataOnDemand SubjectDataOnDemand.appUserDataOnDemand;
    
    public Subject SubjectDataOnDemand.getNewTransientSubject(int index) {
        Subject obj = new Subject();
        setCode(obj, index);
        setName(obj, index);
        return obj;
    }
    
    public void SubjectDataOnDemand.setCode(Subject obj, int index) {
        String code = "code_" + index;
        if (code.length() > 20) {
            code = code.substring(0, 20);
        }
        obj.setCode(code);
    }
    
    public void SubjectDataOnDemand.setName(Subject obj, int index) {
        String name = "name_" + index;
        if (name.length() > 128) {
            name = name.substring(0, 128);
        }
        obj.setName(name);
    }
    
    public Subject SubjectDataOnDemand.getSpecificSubject(int index) {
        init();
        if (index < 0) {
            index = 0;
        }
        if (index > (data.size() - 1)) {
            index = data.size() - 1;
        }
        Subject obj = data.get(index);
        Long id = obj.getId();
        return Subject.findSubject(id);
    }
    
    public Subject SubjectDataOnDemand.getRandomSubject() {
        init();
        Subject obj = data.get(rnd.nextInt(data.size()));
        Long id = obj.getId();
        return Subject.findSubject(id);
    }
    
    public boolean SubjectDataOnDemand.modifySubject(Subject obj) {
        return false;
    }
    
    public void SubjectDataOnDemand.init() {
        int from = 0;
        int to = 10;
        data = Subject.findSubjectEntries(from, to);
        if (data == null) {
            throw new IllegalStateException("Find entries implementation for 'Subject' illegally returned null");
        }
        if (!data.isEmpty()) {
            return;
        }
        
        data = new ArrayList<Subject>();
        for (int i = 0; i < 10; i++) {
            Subject obj = getNewTransientSubject(i);
            try {
                obj.persist();
            } catch (final ConstraintViolationException e) {
                final StringBuilder msg = new StringBuilder();
                for (Iterator<ConstraintViolation<?>> iter = e.getConstraintViolations().iterator(); iter.hasNext();) {
                    final ConstraintViolation<?> cv = iter.next();
                    msg.append("[").append(cv.getRootBean().getClass().getName()).append(".").append(cv.getPropertyPath()).append(": ").append(cv.getMessage()).append(" (invalid value = ").append(cv.getInvalidValue()).append(")").append("]");
                }
                throw new IllegalStateException(msg.toString(), e);
            }
            obj.flush();
            data.add(obj);
        }
    }
    
}