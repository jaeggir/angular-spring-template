package ch.uhttraktor.website.rest.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.PropertySource;
import org.springframework.scheduling.annotation.EnableScheduling;
import org.springframework.web.multipart.MultipartResolver;
import org.springframework.web.multipart.commons.CommonsMultipartResolver;

@Configuration
@EnableScheduling
@ComponentScan({
        "ch.uhttraktor.website.persistence", "ch.uhttraktor.website.domain",
        "ch.uhttraktor.website.rest.service"
})
@PropertySource("classpath:application.properties")
public class ApplicationConfiguration {

    @Bean
    public MultipartResolver multipartResolver() {
        CommonsMultipartResolver multipartResolver = new CommonsMultipartResolver();
        multipartResolver.setMaxUploadSize(10 * 1024 * 1024); // 10MB
        return multipartResolver;
    }

}
