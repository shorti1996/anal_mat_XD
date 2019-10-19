package com.karol.szczepanski.classification.weka;

import com.sun.istack.internal.NotNull;
import com.sun.istack.internal.Nullable;
import weka.core.Attribute;
import weka.core.Instances;
import weka.core.converters.ConverterUtils;

import java.util.Enumeration;

/**
 * Created by Karol on 27.05.2017.
 */
public class WekaAlgorithm {
    @NotNull
    protected final Instances data;
    @Nullable
    protected Logger logger;

    public WekaAlgorithm(Instances data) {
        this.data = data;
    }

    public WekaAlgorithm(@NotNull String path) throws Exception {
        this(loadData(path));
    }

    @NotNull
    public Instances getData() {
        return data;
    }

    @Nullable
    public Logger getLogger() {
        return logger;
    }

    public void setLogger(@Nullable Logger logger) {
        this.logger = logger;
    }

    public void setClass(@Nullable String attributeName) {
        Attribute attribute = data.attribute(attributeName);
        data.setClass(attribute);
    }

    public void printAttributesWithValues() {
        if (logger == null) {
            return;
        }
        printAttributeValues(data, data.classAttribute().name());
        Enumeration<Attribute> values = data.enumerateAttributes();
        while (values.hasMoreElements()) {
            String name = values.nextElement().name();
            printAttributeValues(data, name);
        }
        logger.logLn();
    }

    protected void printAttributeValues(Instances data, String name) {
        if (logger == null) {
            return;
        }
        logger.logLn(name + " {");
        Attribute attribute = data.attribute(name);
        Enumeration<Object> values = attribute.enumerateValues();
        while (values.hasMoreElements()) {
            logger.logLn("   " + values.nextElement().toString());
        }
        logger.logLn("}");
    }


    protected static Instances loadData(String path) throws Exception {
        ConverterUtils.DataSource source = new ConverterUtils.DataSource(path);
        return source.getDataSet();
    }
}
