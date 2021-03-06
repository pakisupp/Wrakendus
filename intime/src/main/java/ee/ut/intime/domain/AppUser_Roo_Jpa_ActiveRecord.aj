// WARNING: DO NOT EDIT THIS FILE. THIS FILE IS MANAGED BY SPRING ROO.
// You may push code into the target .java compilation unit if you wish to edit any member(s).

package ee.ut.intime.domain;

import ee.ut.intime.domain.AppUser;
import java.util.List;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import org.springframework.transaction.annotation.Transactional;

privileged aspect AppUser_Roo_Jpa_ActiveRecord {
    
    @PersistenceContext
    transient EntityManager AppUser.entityManager;
    
    public static final List<String> AppUser.fieldNames4OrderClauseFilter = java.util.Arrays.asList("USER_AUTHORITY", "ADMIN_AUTHORITY", "username", "eMail", "password", "openIdIdentifier", "fullName");
    
    public static final EntityManager AppUser.entityManager() {
        EntityManager em = new AppUser().entityManager;
        if (em == null) throw new IllegalStateException("Entity manager has not been injected (is the Spring Aspects JAR configured as an AJC/AJDT aspects library?)");
        return em;
    }
    
    public static long AppUser.countAppUsers() {
        return entityManager().createQuery("SELECT COUNT(o) FROM AppUser o", Long.class).getSingleResult();
    }
    
    public static List<AppUser> AppUser.findAllAppUsers() {
        return entityManager().createQuery("SELECT o FROM AppUser o", AppUser.class).getResultList();
    }
    
    public static List<AppUser> AppUser.findAllAppUsers(String sortFieldName, String sortOrder) {
        String jpaQuery = "SELECT o FROM AppUser o";
        if (fieldNames4OrderClauseFilter.contains(sortFieldName)) {
            jpaQuery = jpaQuery + " ORDER BY " + sortFieldName;
            if ("ASC".equalsIgnoreCase(sortOrder) || "DESC".equalsIgnoreCase(sortOrder)) {
                jpaQuery = jpaQuery + " " + sortOrder;
            }
        }
        return entityManager().createQuery(jpaQuery, AppUser.class).getResultList();
    }
    
    public static AppUser AppUser.findAppUser(Long id) {
        if (id == null) return null;
        return entityManager().find(AppUser.class, id);
    }
    
    public static List<AppUser> AppUser.findAppUserEntries(int firstResult, int maxResults) {
        return entityManager().createQuery("SELECT o FROM AppUser o", AppUser.class).setFirstResult(firstResult).setMaxResults(maxResults).getResultList();
    }
    
    public static List<AppUser> AppUser.findAppUserEntries(int firstResult, int maxResults, String sortFieldName, String sortOrder) {
        String jpaQuery = "SELECT o FROM AppUser o";
        if (fieldNames4OrderClauseFilter.contains(sortFieldName)) {
            jpaQuery = jpaQuery + " ORDER BY " + sortFieldName;
            if ("ASC".equalsIgnoreCase(sortOrder) || "DESC".equalsIgnoreCase(sortOrder)) {
                jpaQuery = jpaQuery + " " + sortOrder;
            }
        }
        return entityManager().createQuery(jpaQuery, AppUser.class).setFirstResult(firstResult).setMaxResults(maxResults).getResultList();
    }
    
    @Transactional
    public void AppUser.persist() {
        if (this.entityManager == null) this.entityManager = entityManager();
        this.entityManager.persist(this);
    }
    
    @Transactional
    public void AppUser.remove() {
        if (this.entityManager == null) this.entityManager = entityManager();
        if (this.entityManager.contains(this)) {
            this.entityManager.remove(this);
        } else {
            AppUser attached = AppUser.findAppUser(this.id);
            this.entityManager.remove(attached);
        }
    }
    
    @Transactional
    public void AppUser.flush() {
        if (this.entityManager == null) this.entityManager = entityManager();
        this.entityManager.flush();
    }
    
    @Transactional
    public void AppUser.clear() {
        if (this.entityManager == null) this.entityManager = entityManager();
        this.entityManager.clear();
    }
    
    @Transactional
    public AppUser AppUser.merge() {
        if (this.entityManager == null) this.entityManager = entityManager();
        AppUser merged = this.entityManager.merge(this);
        this.entityManager.flush();
        return merged;
    }
    
}
