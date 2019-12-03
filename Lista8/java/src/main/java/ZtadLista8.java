
import weka.core.Attribute;
import weka.core.Instances;
import weka.core.converters.ArffSaver;
import weka.core.converters.ConverterUtils.DataSource;
import weka.filters.Filter;
import weka.filters.unsupervised.attribute.Remove;
import weka.filters.unsupervised.instance.RemoveWithValues;

import java.io.File;
import java.io.IOException;
import java.util.Enumeration;

public class ZtadLista8 {

    private static final String READ_PATH = "../228046L2_2.arff";
    private static final String SAVE_PATH = "../228046L3_2.arff";
    private static final String STATUS_POZYCZKI = "status pozyczki";
    private static final String KWOTA_KREDYTU = "kwota kredytu";
    private static final String ODMOWA = "odmowa";
    private static final String ATTRIBUTE_INDEX = "-C";
    private static final String VALUE_INDEX = "-L";
    private static final String INVERT = "-V";
    private static final String CREDIT_900 = "900.01";
    private static final String LESS_THAN = "-S";


    public static void main(String[] args) throws Exception {
        Instances data = loadData();

        printAttributes(data);
        printAttributeValues(data, STATUS_POZYCZKI);

        Attribute statusPozyczki = data.attribute(STATUS_POZYCZKI);
        String statusPozyczkiIndex = getIndex(statusPozyczki);
        String odmowaIndex = getValueIndex(statusPozyczki, ODMOWA);
        System.out.println("statusPozyczkiIndex: " + statusPozyczkiIndex + ", odmowaIndex: " + odmowaIndex + "\n");
        data = removeWithValues(data, new String[] {ATTRIBUTE_INDEX, statusPozyczkiIndex, VALUE_INDEX, odmowaIndex});

        Attribute kwotaKredytu = data.attribute(KWOTA_KREDYTU);
        String kwotaKredytuIndex = getIndex(kwotaKredytu);
        System.out.println("kwotaKredytuIndex: " + kwotaKredytuIndex + "\n");
        data = removeWithValues(data, new String[] {ATTRIBUTE_INDEX, kwotaKredytuIndex, LESS_THAN, CREDIT_900, INVERT});

        data = removeAttribute(data, statusPozyczkiIndex);

        printAttributes(data);

        saveData(data);
    }

    private static String getValueIndex(Attribute attribute, String value) {
        return Integer.toString(attribute.indexOfValue(value) + 1);
    }

    private static String getIndex(Attribute attribute) {
        return Integer.toString(attribute.index() + 1);
    }

    private static void printAttributes(Instances data) {
        Enumeration<Attribute> values = data.enumerateAttributes();
        while (values.hasMoreElements()) {
            System.out.println(values.nextElement().name());
        }
        System.out.println();
    }

    private static void printAttributeValues(Instances data, String name) {
        Attribute attribute = data.attribute(name);
        Enumeration<Object> values = attribute.enumerateValues();
        while (values.hasMoreElements()) {
            System.out.println(values.nextElement().toString());
        }
        System.out.println();
    }

    private static Instances removeAttribute(Instances data, String attributeIndex) throws Exception {
        Remove filter = new Remove();
        filter.setAttributeIndices(attributeIndex);
        filter.setInputFormat(data);
        return Filter.useFilter(data, filter);
    }

    private static Instances removeWithValues(Instances data, String[] optionsRemoveWithValues1) throws Exception {
        RemoveWithValues filter = new RemoveWithValues();
        filter.setOptions(optionsRemoveWithValues1);
        filter.setInputFormat(data);
        return Filter.useFilter(data, filter);
    }

    private static void saveData(Instances data) throws IOException {
        ArffSaver saver = new ArffSaver();
        saver.setInstances(data);
        saver.setFile(new File(SAVE_PATH));
        saver.writeBatch();
    }

    private static Instances loadData() throws Exception {
        DataSource source = new DataSource(READ_PATH);
        return source.getDataSet();
    }
}
