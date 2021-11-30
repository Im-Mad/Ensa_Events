package ma.ensaevents.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class LoginController {

    @GetMapping("/login")
    public String showMyLoginPage() {

        // return "plain-login";

        return "login";

    }

    // add request mapping for /access-denied

    @GetMapping("/access-denied")
    public String showAccessDenied() {

        return "access-denied";

    }

}
