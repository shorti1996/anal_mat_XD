package com.karol.szczepanski.classification.weka;

import com.sun.istack.internal.NotNull;
import com.sun.istack.internal.Nullable;
import weka.classifiers.Classifier;
import weka.core.Instance;
import weka.core.Instances;

/**
 * Created by Karol on 27.05.2017.
 */
public class WekaClassification extends WekaAlgorithm {
    @Nullable
    private Classifier classifier;

    public WekaClassification(@NotNull Instances data) {
        super(data);
    }

    public WekaClassification(@NotNull String path) throws Exception {
        super(path);
    }

    public Classifier getClassifier() {
        return classifier;
    }

    public void setClassifier(@NotNull Classifier classifier) {
        this.classifier = classifier;
    }

    public void train() throws Exception {
        classifier.buildClassifier(data);
    }

    public double[] predict(Instances instances) throws Exception {
        int size = instances.numInstances();
        double[] predictions = new double[size];
        for (int i = 0; i < size; i++) {
            predictions[i] = predict(instances.instance(i));
        }
        return predictions;
    }

    public double predict(Instance instance) throws Exception {
        return classifier.classifyInstance(instance);
    }
}
