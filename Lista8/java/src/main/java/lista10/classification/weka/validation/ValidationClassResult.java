package lista10.classification.weka.validation;


public class ValidationClassResult implements Comparable<ValidationClassResult> {
    public String className;
    public int correct;
    public int incorrect;
    public int priority;


    @Override
    public int compareTo(ValidationClassResult o) {
        return priority - o.priority;
    }
}
