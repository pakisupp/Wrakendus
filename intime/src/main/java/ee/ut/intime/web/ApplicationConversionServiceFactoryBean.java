package ee.ut.intime.web;

import org.springframework.core.convert.converter.Converter;
import org.springframework.format.FormatterRegistry;
import org.springframework.format.support.FormattingConversionServiceFactoryBean;
import org.springframework.roo.addon.web.mvc.controller.converter.RooConversionService;

import ee.ut.intime.domain.AppUser;

/**
 * A central place to register application converters and formatters. 
 */
@RooConversionService
public class ApplicationConversionServiceFactoryBean extends FormattingConversionServiceFactoryBean {

	@Override
	protected void installFormatters(FormatterRegistry registry) {
		super.installFormatters(registry);
		// Register application converters and formatters
	}
	
	public Converter<AppUser, String> getAppUserToStringConverter() {
        return new org.springframework.core.convert.converter.Converter<ee.ut.intime.domain.AppUser, java.lang.String>() {
            public String convert(AppUser appUser) {
                return appUser.getUsername();
            }
        };
    }
    
}
