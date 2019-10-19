package com.karol.szczepanski.classification.weka.validation;

/**
 * Created by Karol on 27.05.2017.
 */
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
