// WARNING: DO NOT EDIT THIS FILE. THIS FILE IS MANAGED BY SPRING ROO.
// You may push code into the target .java compilation unit if you wish to edit any member(s).

package ee.ut.intime.domain;

import ee.ut.intime.domain.UsedTime;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Version;

privileged aspect UsedTime_Roo_Jpa_Entity {
    
    declare @type: UsedTime: @Entity;
    
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    @Column(name = "id")
    private Long UsedTime.id;
    
    @Version
    @Column(name = "version")
    private Integer UsedTime.version;
    
    public Long UsedTime.getId() {
        return this.id;
    }
    
    public void UsedTime.setId(Long id) {
        this.id = id;
    }
    
    public Integer UsedTime.getVersion() {
        return this.version;
    }
    
    public void UsedTime.setVersion(Integer version) {
        this.version = version;
    }
    
}
