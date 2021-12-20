package ma.ensaevents.entity;

public enum EventStatus {

    ONGOING("ongoing", "yellow"),
    FINISHED("finished", "red"),
    UPCOMING("upcoming", "green");

    private final String label;
    private final String color;

    EventStatus(String label, String color) {
        this.label = label;
        this.color = color;
    }

    @Override
    public String toString() {
        return  label;
    }

    public String getLabel() {
        return label;
    }

    public String getColor() {
        return color;
    }
}
