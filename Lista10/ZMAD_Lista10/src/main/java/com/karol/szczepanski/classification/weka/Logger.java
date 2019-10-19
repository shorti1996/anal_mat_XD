package com.karol.szczepanski.classification.weka;

/**
 * Created by Karol on 27.05.2017.
 */
public interface Logger {
    void log(String text);

    void logLn(String text);

    void logLn();
}
