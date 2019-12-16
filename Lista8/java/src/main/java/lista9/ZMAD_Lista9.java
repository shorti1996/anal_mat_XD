package lista9;

import weka.attributeSelection.GainRatioAttributeEval;
import weka.core.Attribute;
import weka.core.Instances;
import weka.core.converters.ConverterUtils;
import weka.filters.Filter;
import weka.filters.supervised.attribute.Discretize;

import java.util.Enumeration;

public class ZMAD_Lista9 {

    private static final String READ_PATH = "../212785L3_1.arff";

    private static final String STATUS_POZYCZKI = "status pozyczki";
    private static final String RANGE_LIST = "1,4,5,6,7,8";

    public static void main(String[] args) throws Exception {
        Instances data = loadData();
        Attribute statusPozyczki = data.attribute(STATUS_POZYCZKI);
        data.setClass(statusPozyczki);

        data = discretize(data);

        printAttributes(data);
        for (int i = 0; i < data.numAttributes(); i++) {
            Attribute attribute = data.attribute(i);
            double wekaGainRatio = getWekaGainRatio(data, attribute);
            double gainRatio = getGainRatio(data, attribute);
            print(String.format("%d.%s: \n    wekaGainRatio =  %.5f, gainRatio =  %.5f", attribute.index(), attribute.name(), wekaGainRatio, gainRatio));
        }
    }

    private static double getGainRatio(Instances data, Attribute attribute) {
        GainRatio gainRatio = new GainRatio(data);
        return gainRatio.evaluateAttribute(attribute.index());
    }

    private static double getWekaGainRatio(Instances data, Attribute attribute) throws Exception {
        GainRatioAttributeEval gainRatioAttributeEval = new GainRatioAttributeEval();
        gainRatioAttributeEval.buildEvaluator(data);
        return gainRatioAttributeEval.evaluateAttribute(attribute.index());
    }

    private static Instances discretize(Instances data) throws Exception {
        Discretize discretize = new Discretize();
        discretize.setAttributeIndices(RANGE_LIST);
        discretize.setInputFormat(data);
        return Filter.useFilter(data, discretize);
    }

    private static Instances loadData() throws Exception {
        ConverterUtils.DataSource source = new ConverterUtils.DataSource(READ_PATH);
        return source.getDataSet();
    }

    private static void printAttributes(Instances data) {
        Enumeration<Attribute> values = data.enumerateAttributes();
        while (values.hasMoreElements()) {
            System.out.println(values.nextElement().name());
        }
        System.out.println();
    }

    private static void print(String string) {
        System.out.println(string);
    }
}
