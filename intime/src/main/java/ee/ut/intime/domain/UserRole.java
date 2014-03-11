package ee.ut.intime.domain;
import javax.persistence.EnumType;
import javax.persistence.Enumerated;
import javax.validation.constraints.NotNull;

public enum UserRole {

    ROLE_ADMIN, ROLE_USER;

    /**
     */
    @NotNull
    @Enumerated(EnumType.STRING)
    private UserRole userRole;
}
