package com.karol.szczepanski.classification.weka.validation;

import com.karol.szczepanski.classification.weka.WekaAlgorithm;
import com.sun.istack.internal.NotNull;
import weka.classifiers.Classifier;
import weka.classifiers.Evaluation;
import weka.core.Debug.Random;
import weka.core.Instance;
import weka.core.Instances;

/**
 * Based on
 * https://weka.wikispaces.com/Generating+cross-validation+folds+%28Java+approach%29
 * https://weka.wikispaces.com/Use+WEKA+in+your+Java+code
 * https://weka.wikispaces.com/Generating+classifier+evaluation+output+manually
 */
public class CrossValidation extends WekaAlgorithm {
    @NotNull
    private final int foldsCount;
    private final int iterations;
    private Classifier classifier;
    private long[] seeds;
    private long seed;
    private String positiveClassName;


    public CrossValidation(@NotNull Instances data, int foldsCount, int iterations) {
        super(data);
        this.foldsCount = foldsCount;
        this.iterations = iterations;
        randomizeSeeds();
    }

    private void randomizeSeeds() {
        Random random = new Random();
        seeds = random.longs().limit(iterations).toArray();
        seed = random.nextLong();
    }

    public ValidationResults perform() throws Exception {
        ValidationResults results = new ValidationResults(data);
        results.setPositiveClassName(positiveClassName);
        for (int i = 0; i < iterations; i++) {
            Instances randData = getRandomizedData(seeds[i]);
            for (int n = 0; n < foldsCount; n++) {
                performSingleEvaluation(randData, n, results);
            }
        }
        return results;
    }

    private Instances getRandomizedData(long seed) {
        Random random = new Random(seed);
        Instances randData = new Instances(data);
        randData.randomize(random);
        randData.stratify(foldsCount);
        return randData;
    }

    private void performSingleEvaluation(Instances randData, int foldIndex, ValidationResults results) throws Exception {
        Instances train = randData.trainCV(foldsCount, foldIndex);
        Instances test = randData.testCV(foldsCount, foldIndex);
        classifier.buildClassifier(train);
        int size = test.size();
        for (int i = 0; i < size; i++) {
            Instance instance = test.instance(i);
            double predictedValue = classifier.classifyInstance(instance);
            double actualValue = instance.classValue();
            String className = instance.stringValue(instance.classIndex());
            results.add(className, actualValue, predictedValue);
        }
    }

    public void setPositiveClassValue(String positiveClassName) {
        this.positiveClassName = positiveClassName;
    }

    public void performNative() throws Exception {
        Random random = new Random(seed);
        Evaluation evaluation = new Evaluation(data);
        evaluation.crossValidateModel(classifier, data, foldsCount, random);
        logger.logLn(evaluation.toSummaryString());
        logger.logLn(evaluation.toClassDetailsString());
        logger.logLn(evaluation.toMatrixString());
    }

    @NotNull
    public Classifier getClassifier() {
        return classifier;
    }

    public void setClassifier(@NotNull Classifier classifier) {
        this.classifier = classifier;
    }

    public int getFoldsCount() {
        return foldsCount;
    }

    public int getIterations() {
        return iterations;
    }
}
