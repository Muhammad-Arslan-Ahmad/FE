package com.salesfuse.client;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.autoconfigure.domain.EntityScan;
import org.springframework.boot.autoconfigure.jdbc.DataSourceAutoConfiguration;
import org.springframework.boot.builder.SpringApplicationBuilder;
import org.springframework.boot.web.servlet.support.SpringBootServletInitializer;

@SpringBootApplication(exclude = DataSourceAutoConfiguration.class)
@EntityScan(basePackageClasses = {
		ClientApplication.class
})
public class ClientApplication extends SpringBootServletInitializer {

    public static void main(String[] args) {
        SpringApplication.run(ClientApplication.class, args);
    }

    @Override
	protected SpringApplicationBuilder configure(SpringApplicationBuilder application) {
		return application.sources(ClientApplication.class);
	}
}
