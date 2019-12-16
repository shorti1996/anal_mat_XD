package lista10.zmitad.weka;

import javafx.util.Pair;
import lista10.classification.weka.Logger;
import lista10.classification.weka.WekaClassification;
import lista10.classification.weka.validation.CrossValidation;
import lista10.classification.weka.validation.ValidationResults;
import weka.classifiers.Classifier;
import weka.classifiers.bayes.NaiveBayes;
import weka.classifiers.functions.MultilayerPerceptron;
import weka.classifiers.functions.SMO;
import weka.classifiers.rules.JRip;
import weka.classifiers.rules.ZeroR;
import weka.classifiers.trees.J48;
import weka.core.Instances;
import weka.core.converters.ConverterUtils;

import java.util.ArrayList;
import java.util.List;

public class ZMAD_Lista10 {

    private static final String READ_PATH = "../212785L4_1.arff";
    private static final String STATUS_POZYCZKI = "status pozyczki";
    private static final int ITERATIONS = 1;
    private static final int FOLDS_COUNT = 10;
    private static final String ZLY = "zly";
    private static final String NUMBER_OF_EPOCHS = "-N";
    private static final String LEARNING_RATE = "-L";

    private static List<Pair<Classifier, String>> sClassifiers;

    static {
        try {
            sClassifiers = new ArrayList<>();

            // Przyporzadkowuje wszystkie klasy do najbardziej popularnej - dolna granica dla wszystkich algorytmow.
            ZeroR zeroR = new ZeroR();
            sClassifiers.add(new Pair<>(zeroR, "ZeroR"));

            // decision tree
            J48 j48 = new J48();
            sClassifiers.add(new Pair<>(j48, "J48"));

            // Repeated Incremental Pruning to Produce Error Reduction
            JRip jRip = new JRip();
            sClassifiers.add(new Pair<>(jRip, "JRip"));

            // Sequential minimal optimization, SVM
            SMO smo = new SMO();
            sClassifiers.add(new Pair<>(smo, "SMO"));

            // sieć neuronowa, backpropagation,
            MultilayerPerceptron multilayerPerceptron = new MultilayerPerceptron();
            multilayerPerceptron.setOptions(new String[]{NUMBER_OF_EPOCHS, "2000", LEARNING_RATE, "0.8"});
            sClassifiers.add(new Pair<>(multilayerPerceptron, "MultilayerPerceptron,N:2000,L:0.5"));

            multilayerPerceptron = new MultilayerPerceptron();
            multilayerPerceptron.setOptions(new String[]{NUMBER_OF_EPOCHS, "1000", LEARNING_RATE, "0.3"}); //default
            sClassifiers.add(new Pair<>(multilayerPerceptron, "MultilayerPerceptron,N:1000,L:0.3"));

            multilayerPerceptron = new MultilayerPerceptron();
            multilayerPerceptron.setOptions(new String[]{NUMBER_OF_EPOCHS, "500", LEARNING_RATE, "0.1"});
            sClassifiers.add(new Pair<>(multilayerPerceptron, "MultilayerPerceptron,N:500,L:0.1"));

            multilayerPerceptron = new MultilayerPerceptron();
            multilayerPerceptron.setOptions(new String[]{NUMBER_OF_EPOCHS, "50", LEARNING_RATE, "0.8"});
            sClassifiers.add(new Pair<>(multilayerPerceptron, "MultilayerPerceptron,N:50,L:0.8"));

            // prawdopodobieństwo warunkowe
            NaiveBayes naiveBayes = new NaiveBayes();
            sClassifiers.add(new Pair<>(naiveBayes, "NaiveBayes"));

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public static void main(String[] args) throws Exception {
        System.out.println("ZMAD_Lista10");

        Instances data = loadData(READ_PATH);

        CrossValidation crossValidation = new CrossValidation(data, FOLDS_COUNT, ITERATIONS);
        crossValidation.setClass(STATUS_POZYCZKI);
        crossValidation.setLogger(getLogger());
        crossValidation.setPositiveClassValue(ZLY);
        crossValidation.printAttributesWithValues();
        for (Pair<Classifier, String> pair : sClassifiers) {
            performValidation(crossValidation, pair);
        }
        System.out.println("END.");
    }

    private static void performValidation(CrossValidation crossValidation, Pair<Classifier, String> pair) throws Exception {
        System.out.println("----- Cross validation for classifier: " + pair.getValue() + " ----");
        crossValidation.setClassifier(pair.getKey());
        //crossValidation.performNative();
        long time = System.currentTimeMillis();
        ValidationResults results = crossValidation.perform();
        getLogger().logLn(String.format("Training time: %d milis", System.currentTimeMillis() - time));
        results.print(getLogger());
        System.out.println();
    }

    private static void wekaClassificationUsage() throws Exception {
        WekaClassification wekaClassification = new WekaClassification(READ_PATH);
        wekaClassification.setClass(STATUS_POZYCZKI);
        wekaClassification.setLogger(getLogger());
        wekaClassification.setClassifier(new J48());
        wekaClassification.printAttributesWithValues();
    }

    private static Logger getLogger() {
        return new Logger() {
            @Override
            public void log(String text) {
                System.out.print(text);
            }

            @Override
            public void logLn(String text) {
                System.out.println(text);
            }

            @Override
            public void logLn() {
                System.out.println();
            }
        };
    }


    private static Instances loadData(String path) throws Exception {
        ConverterUtils.DataSource source = new ConverterUtils.DataSource(path);
        return source.getDataSet();
    }

}
