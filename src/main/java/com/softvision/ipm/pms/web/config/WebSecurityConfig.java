package com.softvision.ipm.pms.web.config;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.builders.WebSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;

import com.softvision.ipm.pms.acl.service.SVAuthenticationProvider;

@Configuration
@EnableWebSecurity
public class WebSecurityConfig extends WebSecurityConfigurerAdapter {

	@Autowired
	//private TestAuthenticationProvider authenticationProvider;
	private SVAuthenticationProvider authenticationProvider;

	@Autowired
    public void configureGlobal(AuthenticationManagerBuilder auth) throws Exception {
		auth.authenticationProvider(authenticationProvider);
    }

	@Override
    protected void configure(HttpSecurity http) throws Exception {
		//http.csrf().disable();
		http.csrf().disable()
		.authorizeRequests().antMatchers("/", "/login").permitAll()
				.anyRequest().authenticated()
		.and()
            .formLogin()
                .loginPage("/login")
            	.failureUrl("/")
                .defaultSuccessUrl("/dashboard")
                .usernameParameter("username")
				.passwordParameter("password")
        .and()
            .logout()
				.logoutSuccessUrl("/");
    }

	@Override
	public void configure(WebSecurity web) throws Exception {
		web.ignoring().antMatchers("/fonts/**", "/scripts/**", "/images/**",
				"/AdminBSBMaterialDesign/**", "/StarAdmin/**");
	}

}
