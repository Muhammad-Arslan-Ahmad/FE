package com.salesfuse.client.config.security;

import com.fasterxml.jackson.databind.DeserializationFeature;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.salesfuse.client.authentication.service.AuthenticationService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.builders.WebSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import com.salesfuse.client.authentication.service.CustomAuthenticationDetailSource;
import java.util.ArrayList;
import java.util.List;
import java.util.Locale;
import org.springframework.http.client.ClientHttpRequestInterceptor;
import org.springframework.http.converter.json.MappingJackson2HttpMessageConverter;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.session.HttpSessionEventPublisher;
import org.springframework.util.CollectionUtils;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.servlet.LocaleResolver;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;
import org.springframework.web.servlet.i18n.SessionLocaleResolver;

@Configuration
@EnableWebSecurity
public class SecurityConfiguration extends WebSecurityConfigurerAdapter implements WebMvcConfigurer {

    @Autowired
    private AuthenticationService authenticationService;

    @Bean
    public RestTemplate restTemplate() {
        RestTemplate restTemplate = new RestTemplate();

        List<ClientHttpRequestInterceptor> interceptors
                = restTemplate.getInterceptors();
        if (CollectionUtils.isEmpty(interceptors)) {
            interceptors = new ArrayList<>();
        }
        restTemplate.setInterceptors(interceptors);
        MappingJackson2HttpMessageConverter jsonConverter = new MappingJackson2HttpMessageConverter();
        ObjectMapper objectMapper = jsonConverter.getObjectMapper();
        objectMapper.configure(DeserializationFeature.FAIL_ON_UNKNOWN_PROPERTIES, false);
        restTemplate.getMessageConverters().add(jsonConverter);
        return restTemplate;
    }

    @Bean
    public LocaleResolver localeResolver() {
        SessionLocaleResolver slr = new SessionLocaleResolver();
        slr.setDefaultLocale(new Locale("bn"));
        return slr;
    }

    @Bean
    public CustomAuthenticationDetailSource authenticationDetailSource() {
        System.out.println("Configuring Spring Security : Initializaing user details service...");
        return new CustomAuthenticationDetailSource();
    }

    @Override
    public void configure(WebSecurity web) throws Exception {
        web.ignoring()
                .antMatchers("/resources/**")
                .antMatchers("/")
                .antMatchers("/register/**")
                .antMatchers("/logout/**")
                .antMatchers("/signout/**");
    }

    @Bean
    public HttpSessionEventPublisher httpSessionEventPublisher() {
        return new HttpSessionEventPublisher();
    }

    @Override
    protected void configure(HttpSecurity http) throws Exception {
        http.headers().httpStrictTransportSecurity().and().frameOptions().disable().xssProtection().and().cacheControl();

        http
                .csrf().disable()
                .logout().logoutUrl("/signout").logoutSuccessUrl("/signout").invalidateHttpSession(true)
                .deleteCookies("JSESSIONID");

        http.authorizeRequests().anyRequest()
                .fullyAuthenticated()
                //.and().logout().logoutUrl("/signout").logoutSuccessUrl("/signout")
                .and().formLogin().authenticationDetailsSource(authenticationDetailSource())
                .loginPage("/").loginProcessingUrl("/j_login")
                .defaultSuccessUrl("/play/list/", true).failureUrl("/login?error=true");
        http.sessionManagement().maximumSessions(10).expiredUrl("/login").and().invalidSessionUrl("/");

    }

    @Override
    public void configure(AuthenticationManagerBuilder auth) throws Exception {
        auth.userDetailsService(authenticationService).passwordEncoder(passwordEncoder());
    }

//    @Bean
//    public BCryptPasswordEncoder passwordEncoder() {
//        return new BCryptPasswordEncoder();
//    }
    @Bean
    public PasswordEncoder passwordEncoder() {
        return new BCryptPasswordEncoder();
    }
}
