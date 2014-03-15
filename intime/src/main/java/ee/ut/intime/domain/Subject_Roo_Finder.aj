// WARNING: DO NOT EDIT THIS FILE. THIS FILE IS MANAGED BY SPRING ROO.
// You may push code into the target .java compilation unit if you wish to edit any member(s).

package ee.ut.intime.domain;

import ee.ut.intime.domain.AppUser;
import ee.ut.intime.domain.Subject;
import javax.persistence.EntityManager;
import javax.persistence.TypedQuery;

privileged aspect Subject_Roo_Finder {
    
    public static Long Subject.countFindSubjectsByOwner(AppUser owner) {
        if (owner == null) throw new IllegalArgumentException("The owner argument is required");
        EntityManager em = Subject.entityManager();
        TypedQuery q = em.createQuery("SELECT COUNT(o) FROM Subject AS o WHERE o.owner = :owner", Long.class);
        q.setParameter("owner", owner);
        return ((Long) q.getSingleResult());
    }
    
    public static TypedQuery<Subject> Subject.findSubjectsByOwner(AppUser owner) {
        if (owner == null) throw new IllegalArgumentException("The owner argument is required");
        EntityManager em = Subject.entityManager();
        TypedQuery<Subject> q = em.createQuery("SELECT o FROM Subject AS o WHERE o.owner = :owner", Subject.class);
        q.setParameter("owner", owner);
        return q;
    }
    
    public static TypedQuery<Subject> Subject.findSubjectsByOwner(AppUser owner, String sortFieldName, String sortOrder) {
        if (owner == null) throw new IllegalArgumentException("The owner argument is required");
        EntityManager em = Subject.entityManager();
        String jpaQuery = "SELECT o FROM Subject AS o WHERE o.owner = :owner";
        if (fieldNames4OrderClauseFilter.contains(sortFieldName)) {
            jpaQuery = jpaQuery + " ORDER BY " + sortFieldName;
            if ("ASC".equalsIgnoreCase(sortOrder) || "DESC".equalsIgnoreCase(sortOrder)) {
                jpaQuery = jpaQuery + " " + sortOrder;
            }
        }
        TypedQuery<Subject> q = em.createQuery(jpaQuery, Subject.class);
        q.setParameter("owner", owner);
        return q;
    }
    
}