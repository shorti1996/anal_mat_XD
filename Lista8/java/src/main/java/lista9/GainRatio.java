package lista9;

import weka.core.Attribute;
import weka.core.Instances;

public class GainRatio {

    private final Instances data;

    public GainRatio(Instances data) {
        this.data = data;
    }

    public double evaluateAttribute(int index) {
        Attribute attribute = data.attribute(index);
        Attribute classAttribute = data.classAttribute();
        double hClass = entropy(classAttribute);
        double hAttr = entropy(attribute);
        double hClassAttr = conditionalEntropy(classAttribute, attribute);
        return hAttr != 0 ? (hClass - hClassAttr) / hAttr : 0;
    }

    private double entropy(Attribute attribute) {
        ProbabilityMap probabilityMap = getProbabilityMap(attribute);
        return calculateEntropy(probabilityMap);
    }

    private double calculateEntropy(ProbabilityMap probabilityMap) {
        return -getProbabilitySum(probabilityMap);
    }

    private double conditionalEntropy(Attribute condition, Attribute attribute) {
        ProbabilityMap probabilityMap = getProbabilityMap(attribute);
        ConditionalProbabilityMap conditionalProbabilityMap = getConditionalProbabilityMap(condition, attribute);
        return calculateConditionalEntropy(probabilityMap, conditionalProbabilityMap);
    }

    private double calculateConditionalEntropy(ProbabilityMap probabilityMap, ConditionalProbabilityMap conditionalProbabilityMapMap) {
        double conditionalEntropy = 0;
        for (int i = 0; i < probabilityMap.size(); i++) {
            Object value = probabilityMap.getValue(i);
            double probability = probabilityMap.getProbability(value);
            ProbabilityMap conditionProbabilityMap = conditionalProbabilityMapMap.getProbabilityMap(value);
            double probabilitySum = getProbabilitySum(conditionProbabilityMap);
            conditionalEntropy += probabilitySum * probability;
        }
        return -conditionalEntropy;
    }

    private double getProbabilitySum(ProbabilityMap conditionProbabilityMap) {
        double conditionalProbabilitySum = 0;
        for (int j = 0; j < conditionProbabilityMap.size(); j++) {
            Object conditionalValue = conditionProbabilityMap.getValue(j);
            double conditionalProbability = conditionProbabilityMap.getProbability(conditionalValue);
            conditionalProbabilitySum += conditionalProbability * logE(conditionalProbability);
        }
        return conditionalProbabilitySum;
    }

    private ProbabilityMap getProbabilityMap(Attribute attribute) {
        int size = data.numInstances();
        ProbabilityMap probabilityMap = new ProbabilityMap();
        for (int i = 0; i < size; i++) {
            String value = getValue(i, attribute);
            probabilityMap.increment(value);
        }
        return probabilityMap;
    }

    private ConditionalProbabilityMap getConditionalProbabilityMap(Attribute condition, Attribute attribute) {
        int size = data.numInstances();
        ConditionalProbabilityMap conditionalProbabilityMap = new ConditionalProbabilityMap();
        for (int i = 0; i < size; i++) {
            String conditionValue = getConditionValue(i, condition, attribute);
            conditionalProbabilityMap.increment(conditionValue, getValue(i, attribute));
        }
        return conditionalProbabilityMap;
    }

    private String getConditionValue(int instanceIndex, Attribute condition, Attribute attribute) {
        return getValue(instanceIndex, condition) + getValue(instanceIndex, attribute);
    }

    private String getValue(int instanceIndex, Attribute attribute) {
        return data.instance(instanceIndex).toString(attribute);
    }

//    test
//    private static double logE(double n) {
//        return Math.log(2);
//    }
    private static double logE(double n) {
        return Math.log(n);
    }
}
