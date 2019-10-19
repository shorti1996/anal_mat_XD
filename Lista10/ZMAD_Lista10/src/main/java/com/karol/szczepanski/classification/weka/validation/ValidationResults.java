package com.karol.szczepanski.classification.weka.validation;

import com.karol.szczepanski.classification.weka.Logger;
import weka.core.Instances;
import weka.core.matrix.Matrix;

import java.util.*;
import java.util.stream.Collectors;

/**
 * Created by Karol on 27.05.2017.
 */
public class ValidationResults {
    private final Map<String, ValidationClassResult> resultsMap;
    private String positiveClassName;
    private Instances data;
    private List<ValidationClassResult> sortedResults;

    public ValidationResults(Instances data) {
        this.data = data;
        resultsMap = new HashMap<>();
    }

    public double getTP() {
        return getSortedResults().get(0).correct;
    }

    public double getFP() {
        return getSortedResults().get(0).incorrect;
    }

    public double getTN() {
        return getSortedResults().stream().skip(1).collect(Collectors.summingDouble(value -> value.correct));
    }

    public double getFN() {
        return getSortedResults().stream().skip(1).collect(Collectors.summingDouble(value -> value.incorrect));
    }

    public double getAccuracy() {
        double tp = getTP();
        double fp = getFP();
        double tn = getTN();
        double fn = getFN();
        if ((tp + tn) == 0) {
            return 0;
        }
        return (tp + tn) / (tp + tn + fn + fp);
    }

    public double getTnRate() {
        double fp = getFP();
        double tn = getTN();
        if (tn == 0) {
            return 0;
        }
        return tn / (tn + fp);
    }

    public double getTpRate() {
        double tp = getTP();
        double fn = getFN();
        if (tp == 0) {
            return 0;
        }
        return tp / (tp + fn);
    }

    public double getGMean() {
        return Math.sqrt(getTpRate() * getTnRate());
    }

    public double getAuc() {
        return (1 + getTpRate() + getTnRate()) / 2;
    }

    public Matrix getConfusionMatrix() {
        int size = resultsMap.keySet().size();
        Matrix matrix = new Matrix(size, size);
        List<ValidationClassResult> sortedResults = getSortedResults();
        for (int i = 0; i < sortedResults.size(); i++) {
            ValidationClassResult result = sortedResults.get(i);
            matrix.set(0, i, result.correct);
            matrix.set(1, i, result.incorrect);
        }
        return matrix;
    }

    public void setPositiveClassName(String positiveClassName) {
        this.positiveClassName = positiveClassName;
    }

    public void add(String className, double actualValue, double predictedValue) {
        ValidationClassResult validationClassResult;
        if (resultsMap.containsKey(className)) {
            validationClassResult = resultsMap.get(className);
        } else {
            validationClassResult = new ValidationClassResult();
            validationClassResult.className = className;
            int index = data.classAttribute().indexOfValue(className);
            validationClassResult.priority = positiveClassName.equalsIgnoreCase(className) ? 0 : index + 1;
        }
        incrementResult(validationClassResult, actualValue, predictedValue);
        resultsMap.put(validationClassResult.className, validationClassResult);
    }

    private void incrementResult(ValidationClassResult validationClassResult, double actualValue, double predictedValue) {
        if (actualValue == predictedValue) {
            validationClassResult.correct++;
        } else {
            validationClassResult.incorrect++;
        }
    }

    public void print(Logger logger) {
        logger.logLn("Cross validation results:");
        printResultsInRows(logger);
        printConfusionMatrix(logger);
        printConfusionElements(logger);
        printIndicators(logger);
    }

    private void printConfusionElements(Logger logger) {
        double tp = getTP();
        double fp = getFP();
        double tn = getTN();
        double fn = getFN();
        String schema = "tp: %.0f, fp: %.0f, tn: %.0f, fn: %.0f";
        String indicatorsString = String.format(schema, tp, fp, tn, fn);
        logger.logLn(indicatorsString);
    }

    private void printIndicators(Logger logger) {
        String schema = "Accuracy: %.3f, TPRate: %.3f, TNRate: %.3f, GMean: %.3f, Auc: %.3f";
        String indicatorsString = String.format(schema, getAccuracy(), getTpRate(), getTnRate(), getGMean(), getAuc());
        logger.logLn(indicatorsString);
    }

    private void printResultsInRows(Logger logger) {
        for (ValidationClassResult result : resultsMap.values()) {
            String schema = "name: %7s, correct: %d, incorrect: %d";
            String format = String.format(schema, result.className, result.correct, result.incorrect);
            logger.logLn(format);
        }
    }

    private void printConfusionMatrix(Logger logger) {
        Matrix matrix = getConfusionMatrix();
        logger.logLn("Confusion matrix:");
        StringBuilder builder = new StringBuilder();
        for (ValidationClassResult result : getSortedResults()) {
            builder.append(String.format("|%2s", result.className));
        }
        builder.append("|");
        logger.logLn(builder.toString());
        logger.logLn(matrix.toString());
    }

    public List<ValidationClassResult> getSortedResults() {
        if (sortedResults == null) {
            sortedResults = new ArrayList<>(resultsMap.values());
            Collections.sort(sortedResults);
        }
        return sortedResults;
    }
}
