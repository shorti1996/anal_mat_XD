package lista9;

import java.util.HashMap;
import java.util.Set;

public class ProbabilityMap {
    private HashMap<Object, Integer> countsMap = new HashMap<>();
    private HashMap<Integer, Object> indexesMap = new HashMap<>();

    public void increment(Object object) {
        int count;
        if (countsMap.containsKey(object)) {
            count = countsMap.get(object) + 1;
        } else {
            count = 1;
            indexesMap.put(size(), object);
        }
        countsMap.put(object, count);
    }

    public double getProbability(Object object) {
        if (object == null || !countsMap.containsKey(object)) {
            throw new IllegalArgumentException("Map does not contain object: " + object);
        }
        return (double) countsMap.get(object) / (double) getTotalElementsCount();
    }

    public int size() {
        return countsMap.size();
    }

    public Object getValue(int index) {
        return indexesMap.get(index);
    }

    private int getTotalElementsCount() {
        return countsMap.values().stream().mapToInt(Integer::intValue).sum();
    }
}
