package ma.ensaevents.config;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.authentication.dao.DaoAuthenticationProvider;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;

import ma.ensaevents.service.UserService;

@Configuration
@EnableWebSecurity
public class SecurityConfig extends WebSecurityConfigurerAdapter {

    @Autowired
    private UserService userService;
    
	@Autowired
	private CustomAuthenticationSuccessHandler customAuthenticationSuccessHandler;

	@Autowired
	private CustomAuthenticationFailureHandler customAuthenticationFailureHandler;

	@Override
	protected void configure(AuthenticationManagerBuilder auth) throws Exception {
		auth.authenticationProvider(authenticationProvider());
	}

	@Override
	protected void configure(HttpSecurity http) throws Exception {
		
		http.authorizeRequests()
				.antMatchers("/assets/**").permitAll()
				.antMatchers("/authenticateTheUser").permitAll()
				.antMatchers("/register").anonymous()
				.antMatchers("/login").anonymous()
				.antMatchers("/club/create").hasAuthority("ROLE_ADMIN")
				.antMatchers("/club/update").hasAuthority("ROLE_MANAGER")
				.antMatchers("/event/create").hasAuthority("ROLE_MANAGER")
				.antMatchers("/event/update").hasAuthority("ROLE_MANAGER")
				.antMatchers("/event/manage").hasAuthority("ROLE_MANAGER")
				.antMatchers("/event/selectUpdate").hasAuthority("ROLE_MANAGER")
				.antMatchers("/event/delete").hasAuthority("ROLE_MANAGER")
				.antMatchers("/user/manage").hasAuthority("ROLE_ADMIN")
				.antMatchers("/review/*").authenticated()
				.antMatchers("event/{eventId}/unparticipate").authenticated()
				.antMatchers("event/{eventId}/participate").authenticated()
				.antMatchers("/user/*").authenticated()
			.and()
				.formLogin()
					.loginPage("/login")
					.loginProcessingUrl("/authenticateTheUser")
					.successHandler(customAuthenticationSuccessHandler)
					.failureHandler(customAuthenticationFailureHandler)
					.permitAll()
			.and()
				.logout().permitAll()
			.and()
				.exceptionHandling().accessDeniedPage("/access-denied");
	}

	
	@Bean
	public BCryptPasswordEncoder passwordEncoder() {
		return new BCryptPasswordEncoder();
	}
	
	//authenticationProvider bean definition
	@Bean
	public DaoAuthenticationProvider authenticationProvider() {
		DaoAuthenticationProvider auth = new DaoAuthenticationProvider();
		auth.setUserDetailsService(userService); //set the custom user details service
		auth.setPasswordEncoder(passwordEncoder()); //set the password encoder - bcrypt
		return auth;
	}
	
}
