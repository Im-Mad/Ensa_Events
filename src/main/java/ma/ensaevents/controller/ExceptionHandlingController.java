package ma.ensaevents.controller;

import ma.ensaevents.exceptions.NotFoundException;
import ma.ensaevents.exceptions.UnauthorizedException;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.servlet.NoHandlerFoundException;

@ControllerAdvice
public class ExceptionHandlingController {

    @ExceptionHandler({NoHandlerFoundException.class, NotFoundException.class})
    public String notHandlerFound(){
        return "exception/404";
    }

    @ExceptionHandler(UnauthorizedException.class)
    public String unauthorized(){
        return "exception/401";
    }

}
