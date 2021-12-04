package ma.ensaevents.utils;

import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;
import java.util.Date;

public class CreateEvent {

    @NotNull(message = "A username is required")
    @Size(min = 1, message = "A username is required")
    private Date date;

    @NotNull(message = "A username is required")
    @Size(min = 1, message = "A username is required")
    private String name;

    @NotNull(message = "A username is required")
    @Size(min = 1, message = "A username is required")
    private String description;

    private String coverPhoto;
}
