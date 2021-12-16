package ma.ensaevents.config;


import org.springframework.security.core.AuthenticationException;
import org.springframework.security.web.authentication.AuthenticationFailureHandler;
import org.springframework.stereotype.Component;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@Component
public class CustomAuthenticationFailureHandler implements AuthenticationFailureHandler {


    @Override
    public void onAuthenticationFailure(HttpServletRequest request, HttpServletResponse response, AuthenticationException exception) throws IOException, ServletException {
        String error = exception.getMessage();
        String redirectUrl = request.getContextPath();
        if(error.equals("User is disabled")) {
             redirectUrl +="/login?disabled";
        }   else {
             redirectUrl +="/login?error";
        }
        response.sendRedirect(redirectUrl);
    }
}

