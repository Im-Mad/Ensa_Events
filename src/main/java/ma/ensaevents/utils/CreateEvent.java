package ma.ensaevents.utils;

import java.util.Date;

public class CreateEvent {

    public static boolean validate(String eventName) {
        if(eventName.length() <= 12 && eventName.length()>0 ) {
            return true;
        }
        return false;
    }

    public static boolean validate(Date startDate, Date endDate) {
        if(startDate.before(endDate))
            return true;
        return false;
    }
}
